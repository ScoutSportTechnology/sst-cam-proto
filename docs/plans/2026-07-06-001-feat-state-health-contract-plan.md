---
title: "feat: State, health, and time contract for the reconnect handshake"
type: feat
status: active
date: 2026-07-06
origin: docs/brainstorms/2026-07-06-state-health-quality-cycle-requirements.md
---

# feat: State, health, and time contract for the reconnect handshake

## Summary

Add the wire surface the state/health cycle needs: a session-snapshot read, an absolute match-state set verb, a last-session summary, per-camera health, auto-stop configuration, device time-sync, and an autofocus mode — all additive `optional` fields/commands with a protocol version bump. Companion plans: `sst-cam-firmware/docs/plans/2026-07-06-001-feat-state-health-quality-cycle-firmware-plan.md` and `sst-cam-app/docs/plans/2026-07-06-001-feat-state-health-quality-cycle-app-plan.md`.

---

## Problem Frame

The contract today cannot express a reconnect: there is no way to read what the firmware is doing (no session/phase/elapsed/health on the wire), no absolute score verb (`ScoreUpdateCommand` is delta-only, so post-gap reconciliation double-applies), and `MatchState` carries only a clamped `time_remaining_s` — lossy exactly in the long-disconnect case. See origin R1–R3, R6, R16 and the firmware/app plans for consuming behavior.

---

## Requirements

- R1. App can read firmware actual state in one round-trip at connect (origin R2, F1).
- R2. App can set match state absolutely (score/period/clock), not just by delta (origin R1, R4).
- R3. App can learn how the previous session ended after firmware returns to idle (origin F2 terminal branches).
- R4. Per-camera health is readable both at handshake and in the 1 Hz telemetry poll (origin R6–R8).
- R5. Auto-stop timeout is app-configurable per session, default 30 minutes (origin R5).
- R6. App can push wall-clock time to the device at connect (origin R16).
- R7. Autofocus mode (manual vs continuous) is commandable (origin R15) — already satisfied by the shipped contract: `CameraFocusControlCommand.mode` (`CameraFocusMode`: `FOCUS_MODE_AUTO` = continuous, `FOCUS_MODE_MANUAL`), echoed by `CameraFocusResponse`. No proto change; consumers use the existing field.
- R8. All changes are additive and version-gated; pull-model invariant preserved — the firmware still never pushes.

---

## Scope Boundaries

- No push/notify mechanism — health and state ride existing app-initiated reads (contract core invariant).
- No epoch timestamps in session/match clocks — elapsed values are monotonic/relative; wall-clock sync (R6) fixes device-local timestamps only.
- No mic fields — diagnostics mic indicators are app-side placeholders (origin R9).

---

## Context & Research

### Relevant Code and Patterns

- `bluetooth.proto`: `Command` oneof has free slots 45–49 (60–70/80–83 reserved); `CommandResponse` oneof uses 10–15 and 23–29; 16–22 reserved; free from 30. `DeviceTelemetry` is the closest existing state snapshot (no session phase/elapsed/health today). `PushSessionConfigCommand`, `CameraFocusCommand`, `MatchState` are the extension points.
- Contract rules (`CLAUDE.md`): pull-model core invariant; new command surface ⇒ `protocol_version` bump; every field lands in three places (firmware, app, `MockBleService`).
- `wifi.proto` carries a stale "RTSP H.264 (NVENC)" comment — Orin Nano has no NVENC.

### Institutional Learnings

- `docs/solutions/architecture-patterns/cross-stack-contract-drift-2026-06-09.md` — pin defaults, units, presence semantics, identity keys in the proto, not in either implementation.
- Firmware/app alignment learnings (2026-06-09 pair): every new field uses `optional` + `has_*()` discipline from day one; proto3 unset-vs-zero was a real bug class.

---

## Key Technical Decisions

- One snapshot command, not scattered reads: the handshake must be one round-trip; a multi-command handshake widens the reconciling window the app must lock the UI for.
- `SetMatchState` is a new absolute verb; `ScoreUpdateCommand` stays for live incremental use — replacing it would break the common path to fix the rare one.
- Last-session summary rides in the snapshot response (populated when session is idle) rather than a separate command — the consumer always wants it exactly when it reads a snapshot that says idle.
- Elapsed values are monotonic seconds (`elapsed_seconds`, `clock_running`), never epoch: Jetson wall clock is untrustworthy pre-sync, and clamped `time_remaining_s` loses information past period end.
- Per-camera health is an enum (`OK / RECOVERING / DOWN`), not a bool: the recovering state is what prevents UI flapping during watchdog restarts (origin Key Decision: hold-then-finalize).
- Auto-stop minutes ride on `PushSessionConfigCommand` (per-session, app-owned intent) rather than a device setting command.
- Time sync is its own small command (epoch ms), sent by the app right after the protocol check — not folded into the snapshot read, which is a pure read.

---

## Implementation Units

### U1. Contract additions in `bluetooth.proto`

**Goal:** All new messages/fields for snapshot, reconcile, health, auto-stop, time, and AF mode; `protocol_version` bumped.

**Requirements:** R1–R8

**Dependencies:** None

**Files:**
- Modify: `bluetooth.proto`

**Approach:**
- New command/response pair: session snapshot — session axis state (idle/configured/ready/recording), active camera, preview layout, recording/streaming/raw flags, recording `elapsed_seconds`, embedded absolute match state (`match_uuid`, scores, period, `elapsed_seconds`, `clock_running`), per-camera health list, and (when idle) last-session summary (`match_uuid`, end-reason enum: app-stop / auto-stop / camera-failure / unknown-reboot, end clock, file-valid flag).
- New command: absolute `SetMatchState` (scores, period, clock seconds, clock running).
- New command: set device time (epoch ms).
- `DeviceTelemetry`: add per-camera health enum fields (camera 0/1) so the 1 Hz poll carries live health.
- `PushSessionConfigCommand`: add `optional uint32 auto_stop_minutes` (semantic default 30, pinned in a comment).
- AF mode: no addition — `CameraFocusControlCommand.mode` already expresses manual vs continuous (adding a second mode field would create two overlapping sources of truth on the wire, the exact drift class the contract-drift learning warns about).
- Every new field `optional`; document units/defaults/presence semantics inline; use free oneof slots per the reservation map. Protocol version: this repo has no constant to bump — `DeviceInfoResponse.protocol_version` is a firmware-populated field; the proto side documents the new expected value in a comment on that field, and the numeric bump lands in the firmware plan's device-info handler (firmware U2).

**Patterns to follow:**
- Existing message-comment style pinning units and defaults; `optional` + `has_*()` discipline from the 2026-06-09 alignment work.

**Test scenarios:**
- Test expectation: none — proto repo carries no test harness; contract validation happens in firmware/app consumers (their U-IDs cover encode/decode tests). CI protoc compile is the gate here.

**Verification:**
- `protoc` compiles clean in CI; firmware and app plans' contract units consume these exact messages without needing further proto edits.

---

### U2. Contract docs + stale-comment cleanup

**Goal:** Contract docs reflect the new surface; stale claims removed.

**Requirements:** R8

**Dependencies:** U1

**Files:**
- Modify: `wifi.proto` (NVENC comment — encode is software x264)
- Modify: `CLAUDE.md` / `README.md` contract notes (new commands, version bump, three-places rule pointer)

**Approach:**
- Document the handshake sequence (protocol check → time push → snapshot read) as the canonical connect flow so both consumers implement the same order.

**Test scenarios:**
- Test expectation: none — docs/comments only.

**Verification:**
- Docs mention every new command; no remaining NVENC references.

---

## System-Wide Impact

- **API surface parity:** every new field/command lands in firmware handlers, app `BleProtocol`, and `MockBleService` in the same cycle (three-places rule) — tracked as explicit units in the companion plans.
- **Unchanged invariants:** pull model (firmware never pushes); existing command semantics untouched; `ScoreUpdateCommand` behavior unchanged.

---

## Risks & Dependencies

| Risk | Mitigation |
|------|------------|
| Version bump strands mid-rollout devices (old app can't stop a running recording) | Lockstep fw+app release (origin R14); auto-stop is the backstop; documented as accepted behavior |
| Semantic drift between fw and app interpretation of new fields | Units/defaults/presence pinned in proto comments (contract-drift learning); mock parity unit in app plan |

---

## Sources & References

- **Origin document:** [docs/brainstorms/2026-07-06-state-health-quality-cycle-requirements.md](docs/brainstorms/2026-07-06-state-health-quality-cycle-requirements.md)
- Companion plans: firmware + app repos, same date/seq.
- Related learning: `docs/solutions/architecture-patterns/cross-stack-contract-drift-2026-06-09.md`
