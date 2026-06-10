---
title: "feat: Raw dual-camera capture contract amendment"
type: feat
status: completed
date: 2026-06-10
origin: docs/brainstorms/2026-06-10-hardware-demo-proto-requirements.md
---

# feat: Raw dual-camera capture contract amendment

## Summary

Add a first-class `RawCaptureControlCommand` to `bluetooth.proto` plus additive `optional` fields on `RecordingMetadata` and `DeviceTelemetry`, so the app can independently control and identify raw per-camera footage running concurrently with final-match recording and streaming — all backward-compatible, no `protocol_version` bump. Everything else the hardware demo needs is already on the wire.

---

## Problem Frame

The contract is stable through phase-5 surface coverage and already expresses recording control, platform streaming (`StreamingConfig.custom_rtmp_url`/`youtube_stream_key`), download tokens, WiFi Direct handshake, and overlay state. The single gap is raw dual-camera training capture: nothing distinguishes "record both cameras raw" from "record the final cam-0 output," and `RecordingMetadata` cannot say a file is raw or which camera it belongs to (raw capture yields two files per session). This contract is the gate — firmware and app cannot wire raw capture until its wire shape exists here. (See origin: `docs/brainstorms/2026-06-10-hardware-demo-proto-requirements.md`.)

---

## Requirements

- R1. Confirm/document that recording, streaming, download, WiFi Direct, preview, and overlay paths need no contract change. (origin R1)
- R2. Add an independent raw dual-camera capture command, distinct from `RecordingControlCommand`, with its own start/stop lifecycle. (origin R2)
- R3. Extend `RecordingMetadata` so a file is markable as raw and associable to a specific camera + capture session. (origin R3)
- R4. Every added field uses proto3 `optional` with a documented default/unit/identity semantic stated in the `.proto` prose. (origin R4)
- R5. No `DeviceInfoResponse.protocol_version` bump — additive only. (origin R5)
- R6. Regenerate bindings in both consumers and confirm both build. (origin R6)

---

## Scope Boundaries

- No breaking changes — additive `optional` fields and one new oneof member only; no renumber/removal.
- No new GATT characteristic or channel; pull model unchanged.
- No per-camera *selective* raw control yet (this demo is both-cameras `RAW_DUAL`); a camera selector is a future additive field.
- No intelligence/detection wire surface.
- No new streaming-config surface — existing `custom_rtmp_url` + platform keys suffice.

### Deferred to Follow-Up Work

- `sst-cam-app/docs/firmware-spec.md` update describing raw-capture session lifecycle/file layout: handled in the app plan (that doc lives in the app repo), not here.

---

## Context & Research

### Relevant Code and Patterns

- `bluetooth.proto` §7 (`RecordingControlCommand`, `RecordingAction`, `RecordingMetadata`, `RecordingListResponse`, `DownloadRequestCommand`/`DownloadTokenResponse`) — the recording surface to extend.
- `bluetooth.proto` `Command` oneof (fields 30–33 used in the recording/streaming block; next free local number is 34).
- `bluetooth.proto` `DeviceTelemetry` (`is_recording = 11`, `is_streaming = 12`, `battery_level_pct = 13`) — pattern for an additive `is_raw_capturing` state bool. **Next free field is 14** (13 is taken by `battery_level_pct`).
- `RecordingControlCommand` returns a status-only `CommandResponse` (it is **not** in the `CommandResponse` payload oneof) — `RawCaptureControlCommand` mirrors this; no new response message.

### Institutional Learnings

- `docs/solutions/architecture-patterns/cross-stack-contract-drift-2026-06-09.md` — on a two-consumer contract the dangerous drift is **semantic**, and per-repo tests can't catch it. Every new field must pin **default, unit, presence, and identity key** in the `.proto` prose, declared `optional` so consumers branch on `has_*()`. Directly governs U1–U3 below: `camera_index` is an identity key (must mean the same 0/1 on both ends), `capture_group_id` is a routing/pairing key, and `is_raw`/`is_raw_capturing` need documented absent-defaults.

---

## Key Technical Decisions

- **Separate `RawCaptureControlCommand`, not a `target` field or new `RecordingAction` values:** raw capture has an independent lifecycle and runs concurrently with final recording + streaming; a separate command keeps `is_recording` telemetry and the `RecordingAction` enum unconflated and scales to a future internal-analysis raw feature (user's stated driver). (see origin: proto doc "Resolve Before Planning")
- **Reuse `RecordingAction` (START/STOP only) inside the new command:** avoids a parallel enum; PAUSE/RESUME are documented as unsupported for raw and answered with `UNSUPPORTED` status.
- **`capture_group_id` pairs the two per-camera files, and the APP mints it:** consistent with the app-as-source-of-truth boundary, the app generates the id and sends it on `RawCaptureControlCommand` START; firmware stamps both files' `RecordingMetadata` with exactly that value. This closes the gap where a status-only stop response leaves the app unable to learn a firmware-minted id. Without app-minting, the app could never reliably pair the two files.
- **`camera_index` (0/1) is the camera identity key, pinned to a physical referent:** documented in `.proto` prose as the `nvarguscamerasrc sensor-id` (0 = primary sensor, 1 = secondary), not a vague "same index both stacks use." Cite the hardware/sensor mapping so front/back cannot be assumed oppositely (the identity-key drift the learning warns about).

---

## Open Questions

### Resolved During Planning

- Raw-capture wire shape: separate command (decided above with user).
- Response shape: status-only `CommandResponse`, mirroring `RecordingControlCommand` (no payload message needed).

### Deferred to Implementation

- Whether `DeviceTelemetry.is_raw_capturing` is sufficient or the app also wants a raw recording count — resolve when the app wires the telemetry view; additive either way.

---

## Implementation Units

- U1. **Add `RawCaptureControlCommand` and wire it into the `Command` oneof**

**Goal:** An independent raw dual-camera start/stop command on the wire.

**Requirements:** R2, R4, R5

**Dependencies:** None

**Files:**
- Modify: `bluetooth.proto` (new message in §7; new oneof member in `Command`)

**Approach:**
- Define `message RawCaptureControlCommand { RecordingAction action = 1; optional string capture_group_id = 2; }` reusing the existing `RecordingAction` enum. The app sets `capture_group_id` on START (app-minted, see Key Decisions); firmware echoes it onto both files' metadata.
- Add `RawCaptureControlCommand raw_capture = 34;` to the `Command` payload oneof (next free number in the recording/streaming block).
- Prose comment pins semantics: both cameras captured raw (`RAW_DUAL` scope), only `RECORDING_START`/`RECORDING_STOP` honored. The contract does **not** restrict the enum (it permits all values) — the *firmware behavior* answers PAUSE/RESUME and the proto3 zero-value `RECORDING_ACTION_UNKNOWN` (an unset `action`) with `UNSUPPORTED`/`ERROR`, never treating UNKNOWN as START. Runs independently of `recording_control` and `streaming_control`.
- No `CommandResponse` payload — returns status-only, like `RecordingControlCommand`. Note this in the comment. (The app already knows the `capture_group_id` it minted, so no payload is needed to learn it.)

**Patterns to follow:**
- `RecordingControlCommand` (message shape + status-only response convention).
- Comment-pins-semantics style from the cross-stack-drift learning.

**Test scenarios:**
- Happy path: encode `Command{raw_capture: {action: RECORDING_START}}`, decode, assert oneof case + action round-trip.
- Edge case: a decoder unaware of field 34 parses the rest of `Command` without error (forward-compat).
- Edge case: `RawCaptureControlCommand{}` with unset `action` decodes as `RECORDING_ACTION_UNKNOWN` (proto3 zero) — documents that firmware must reject this, never START.
- Edge case: START carries the app-minted `capture_group_id`; round-trips intact.
- Covers AE2. Confirm no field renumber/removal in the diff (additive-only).

**Verification:**
- `bluetooth.proto` compiles under `protoc`; `Command` oneof has `raw_capture = 34`; field 34 not previously reserved/used.

---

- U2. **Extend `RecordingMetadata` for raw + per-camera identity**

**Goal:** A listed recording can declare it is raw and which camera + session it belongs to.

**Requirements:** R3, R4, R5

**Dependencies:** None (independent of U1; pairs with it semantically)

**Files:**
- Modify: `bluetooth.proto` (`RecordingMetadata`)

**Approach:**
- Add `optional bool is_raw = 8;` (absent ⇒ false ⇒ final recording).
- Add `optional uint32 camera_index = 9;` (identity key: 0/1, same sensor index both stacks use; meaningful only when `is_raw`).
- Add `optional string capture_group_id = 10;` (pairs the cam0/cam1 files of one raw session; absent for final recordings; equals the app-minted id from `RawCaptureControlCommand`).
- Prose comment documents each default/unit/identity per the drift learning, **and the joint invariant**: when `is_raw==true`, both `camera_index` and `capture_group_id` MUST be present; when `is_raw` is absent/false, both MUST be absent. A consumer MUST treat a raw file lacking either as malformed.
- Add a test for the partial-presence case (`is_raw=true` with `camera_index` absent → rejected/malformed).

**Patterns to follow:**
- Existing `RecordingMetadata` fields 1–7; `optional`-plus-documented-default pattern from `docs/solutions/`.

**Test scenarios:**
- Happy path: encode two `RecordingMetadata` with same `capture_group_id`, `camera_index` 0 and 1, `is_raw=true`; decode and assert pairing + identity.
- Edge case: a final-recording metadata with all three new fields absent decodes with `has_is_raw()==false` (old-client behavior).
- Covers AE1. New fields are `optional` and presence-detectable.

**Verification:**
- `RecordingMetadata` carries fields 8–10 as `optional`; existing field numbers unchanged.

---

- U3. **Add `is_raw_capturing` telemetry state**

**Goal:** The app can reflect raw-capture running state alongside `is_recording`/`is_streaming`.

**Requirements:** R3, R4, R5

**Dependencies:** None

**Files:**
- Modify: `bluetooth.proto` (`DeviceTelemetry`)

**Approach:**
- Add `optional bool is_raw_capturing = 14;` (absent ⇒ false), mirroring `is_recording`/`is_streaming`. Field 13 is already `battery_level_pct`.
- Comment documents the absent-default.

**Patterns to follow:**
- `DeviceTelemetry.is_recording = 11`, `is_streaming = 12`.

**Test scenarios:**
- Happy path: telemetry with `is_raw_capturing=true` round-trips; with field absent, `has_*()==false`.

**Verification:**
- `DeviceTelemetry` has `is_raw_capturing = 14` as `optional`; no existing field touched.

---

- U4. **Regenerate bindings in both consumers and confirm builds**

**Goal:** The contract change is real only when both stacks build against it.

**Requirements:** R1, R6

**Dependencies:** U1, U2, U3

**Files:**
- (App) regenerate `sst-cam-app/lib/models/proto/` via `just gen-proto` (gitignored output).
- (Firmware) regenerate C++ bindings via its build.
- Modify (cross-stack note only): no source edits here — wiring lives in the firmware/app plans.

**Approach:**
- Bump the proto submodule in both consumers to this commit; regenerate; ensure each consumer still compiles with the new symbols present but not yet used.
- Confirm `protocol_version` unchanged (R5).
- This unit closes R1 by confirming the *rest* of the demo needs no contract change — only the raw-capture symbols are new.

**Execution note:** This is a cross-stack verification unit — done means both consumers compile, not that they use the new fields yet.

**Test scenarios:**
- Integration: `just gen-proto` in the app produces Dart bindings that compile; firmware C++ gen compiles. (Both run in their own devcontainers.)
- Covers AE2. Diff against the prior tag shows additions only; `protocol_version` constant unchanged.

**Verification:**
- App and firmware both build with regenerated bindings; no breaking-change warnings; `protocol_version` identical to before.

---

## System-Wide Impact

- **Interaction graph:** New `raw_capture` command flows app → firmware over the same Command Write characteristic; firmware adds a handler. `RecordingMetadata` additions surface in `ListRecordingsCommand` → `RecordingListResponse` already in the contract.
- **Error propagation:** PAUSE/RESUME on raw → `UNSUPPORTED` status (existing `ResponseStatus`). Unknown command on an old firmware → `UNSUPPORTED`/`ERROR` per existing convention.
- **API surface parity:** Both consumers must regenerate and agree on `camera_index` semantics (identity-key rule) — the exact drift class the learning warns about.
- **Unchanged invariants:** Pull model, two-characteristic GATT layout, `ChunkedPayload`/`ChunkAck` framing, and `protocol_version` all unchanged. Final-recording (`RecordingControlCommand`) and streaming paths are untouched.

---

## Risks & Dependencies

| Risk | Mitigation |
|------|------------|
| Semantic drift on `camera_index`/`capture_group_id` (each side assumes differently) | Pin default/unit/identity in `.proto` prose per the cross-stack-drift learning; firmware/app plans cite the same semantics. |
| Field-number collision (34 / 8–10 / 14 reused later) | Verify against **both `reserved` blocks and active field numbers** in the target message (the field-13 collision proves a reserved-only scan is insufficient — 13 is active, not reserved). |
| Consumers drift out of sync (one regenerates, other doesn't) | U4 gates on *both* building; submodule bump coordinated across both repos. |

---

## Sources & References

- **Origin document:** `docs/brainstorms/2026-06-10-hardware-demo-proto-requirements.md`
- System spec: `sst-cam-app/docs/brainstorms/2026-06-10-hardware-demo-system-requirements.md`
- Learning: `docs/solutions/architecture-patterns/cross-stack-contract-drift-2026-06-09.md`
- Contract surface: `bluetooth.proto` §7 (recording/streaming), `Command`/`CommandResponse` oneofs, `DeviceTelemetry`
