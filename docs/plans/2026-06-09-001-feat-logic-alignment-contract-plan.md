---
title: "feat: contract amendments for app-firmware logic alignment"
type: feat
status: active
date: 2026-06-09
origin: docs/brainstorms/2026-06-08-app-firmware-logic-alignment-requirements.md
---

# feat: Contract Amendments for App-Firmware Logic Alignment

## Summary

Amend the proto contract so it is the single binding truth for the behaviors an audit found diverging: make `visible`/`opacity` defaults unambiguous via proto3 `optional`, harden the overlay-rendering rules (uniform scale, text-height clip, text background box, baseline/fonts) to hard MUSTs, document the WiFi-Direct-before-session ordering in §11, require a `protocol_version` check, and make the `ChunkAck` flow-control symmetric across both directions.

---

## Problem Frame

The app and firmware pin the same proto commit and share the wire format, but a subset of their behavioral divergences trace to the contract itself rather than to consumer bugs — proto3 non-optional defaults that invert meaning, rules no renderer implements, an undocumented ordering constraint, and one-directional chunk flow-control wording. This plan covers only the proto repo; the app and firmware implement against the amended contract (see origin). Because every consumer pins proto via submodule, these changes land as a coordinated lockstep re-bump.

---

## Requirements

- R1. Make element default semantics explicit and safe so the firmware default-inversion class cannot recur (origin R1).
- R2. Resolve the text `fill_color` background-box rule — decision: KEEP, both renderers paint it (origin R2).
- R3. State uniform aspect-preserving scale as a hard MUST (origin R3).
- R4. State text-height clipping to `bounds` as a hard MUST (origin R4).
- R5. Clarify baseline and metric-comparable-font rules (origin R5).
- R6. `get_match_state` + `thumbnail` — decision: KEEP in contract, firmware implements; response payloads already exist, so no proto change beyond confirming the surface (origin R6).
- R7. Document the WiFi-Direct-before-session-config ordering in the §11 design flow — decision: document it (origin R7).
- R8. Require consumers to read and check `DeviceInfoResponse.protocol_version`, and define mismatch behavior (origin R8).
- R9. Make `ChunkedPayload`/`ChunkAck` flow control precise and symmetric (inbound acked per chunk, not only outbound) (origin R9).

**Origin acceptance examples:** none defined in origin.

---

## Scope Boundaries

- No app or firmware code changes — those are sibling plans.
- No new features or wire fields beyond what the audited divergences require.
- Mutually-absent commands (`set_wifi_config`, `set_streaming_config`, `factory_reset`, `firmware_update`) untouched — already consistent.
- No CI/lint/buf tooling added to the proto repo this pass.

### Cross-Repo Scope (Sibling Plans, Same Release)

These are concurrent prerequisites in the same coordinated lockstep release — not deferred to a later release.

- App-side conformance to the amended rules: `sst-cam-app` plan (`docs/plans/2026-06-09-016-feat-logic-alignment-app-plan.md`).
- Firmware-side conformance: `sst-cam-firmware` plan (`docs/plans/2026-06-09-001-feat-logic-alignment-firmware-plan.md`).

---

## Context & Research

### Relevant Code and Patterns

- `bluetooth.proto:446` — `bool visible = 6;` (plain proto3 scalar; comment already says "default true").
- `bluetooth.proto:462` — `float opacity = 3;` (plain scalar; comment "default 1.0").
- `bluetooth.proto:159` — `uint32 protocol_version = 5;` in `DeviceInfoResponse`.
- `bluetooth.proto:362-363` — existing `optional string rtmp_url`/`stream_key` precedent that `optional` is already used and supported.
- `bluetooth.proto:402-408` — the §11 "Design flow" comment (ordering lives here); `PushOverlayLayoutCommand` at 421.
- `bluetooth.proto:39-44` — versioning policy + `// History:` block (serves as changelog).
- `README.md:93-115` — "MTU and Chunking"; ack wording at 113-114 (outbound-only today).
- `overlay-rendering.md` sections: Coordinate space, Shapes, Text rendering, Color & opacity, Conformance, Changing this contract.
- `docs/plans/2026-06-07-001-feat-overlay-rendering-semantics-plan.md` — completed precedent for exactly this kind of amendment (added overlay-rendering.md, reworded §11). Mirror its approach.

### Institutional Learnings

- `docs/solutions/workflow-issues/folding-git-submodule-onto-feature-branches-2026-06-05.md` — operational workflow for propagating a proto change as a lockstep submodule pin across consumers.

---

## Key Technical Decisions

- Make `visible` and `opacity` proto3 `optional` rather than relying on firmware-side default mapping. Rationale: `optional` makes "unset" detectable via `has_*()`, so each consumer applies the documented default deterministically; wire-compatible (field numbers unchanged), codegen-affecting only; the firmware build already passes `--experimental_allow_proto3_optional`. This is the contract-level root fix for the default-inversion blocker.
- KEEP the text `fill_color` background-box rule (per user decision) and make it explicit so both renderers implement it identically.
- Document, do not drop, the WiFi-before-session ordering (per user decision) — it reflects a real network dependency (session config provisions streaming sinks that need the group up).
- No `protocol_version` bump: making fields `optional` and tightening prose are backward-compatible per the versioning policy; record the change in the `// History:` block instead.

---

## Open Questions

### Resolved During Planning

- Default-inversion fix location: proto `optional` (here) is the source fix; firmware still applies the default on `has_*()==false` (firmware plan U1).
- get_match_state/thumbnail proto surface: already fully defined (`get_match_state=13`, `thumbnail=11`, responses `match_state=15`, `thumbnail=11`); no schema edit needed.

### Deferred to Implementation

- Exact wording of the `protocol_version` mismatch behavior (hard error vs warn) — define in the contract prose during this work, consumers follow.

---

## Implementation Units

- U1. **Make overlay element defaults explicit in `overlay-rendering.md`**

**Goal:** State unambiguously that an unset `visible` renders (default visible) and an unset `opacity` renders fully opaque (1.0), and how consumers must treat proto3 defaults.

**Requirements:** R1

**Dependencies:** None

**Files:**
- Modify: `overlay-rendering.md` (Color & opacity section; add a short "Element defaults" note near Shapes/Color)

**Approach:**
- Add normative prose: consumers MUST treat an absent `visible` as true and an absent `opacity` as 1.0; senders SHOULD set them explicitly when not the default. Cross-reference the `optional` change in U2.

**Patterns to follow:** the normative MUST/SHOULD phrasing already used in `overlay-rendering.md` Text rendering section.

**Test scenarios:**
- Test expectation: none -- contract markdown, no executable behavior in this repo; default-mapping conformance is verified by firmware U1 (the firmware is the only consumer that *receives* elements with unset fields and applies defaults; the app only sends).

**Verification:**
- The rule is stated once, normatively, and referenced from the `optional` field comments in `bluetooth.proto`.

---

- U2. **Make `visible` and `opacity` proto3 `optional` in `bluetooth.proto`**

**Goal:** Let consumers detect "unset" and apply the documented default deterministically.

**Requirements:** R1

**Dependencies:** U1 (prose the field comments reference)

**Files:**
- Modify: `bluetooth.proto` (`OverlayElement.visible` L446, `OverlayStyle.opacity` L462, `// History:` block ~L39)

**Approach:**
- Change `bool visible = 6;` → `optional bool visible = 6;` and `float opacity = 3;` → `optional float opacity = 3;`, keeping field numbers. Update inline comments to point at the overlay-rendering.md defaults note. Add a `// History:` line recording the optional change and that no `protocol_version` bump is required.

**Patterns to follow:** existing `optional string rtmp_url = 6;` at L362.

**Test scenarios:**
- Test expectation: none -- schema change; validated by consumer codegen (firmware build-time protoc, app `just gen-proto`) and the firmware/app plans' default-mapping tests.

**Verification:**
- `protoc --experimental_allow_proto3_optional` accepts the file; generated code exposes `has_visible()`/`has_opacity()`.

---

- U3. **Harden overlay rendering rules to hard MUSTs in `overlay-rendering.md`**

**Goal:** Remove ambiguity on uniform scale, text-height clip, the text background box, and baseline/fonts.

**Requirements:** R2, R3, R4, R5

**Dependencies:** None

**Files:**
- Modify: `overlay-rendering.md` (Coordinate space, Shapes, Text rendering, Color & opacity sections)

**Approach:**
- Most of these rules already exist as prose/SHOULD in `overlay-rendering.md` — **upgrade the existing clauses in place** at the cited line ranges; do NOT append duplicate clauses.
- Coordinate space (L43-46): state the single uniform aspect-preserving scale factor as a MUST; non-uniform x/y scaling is non-conformant.
- Text rendering (clip L98-99, baseline L90-92): text MUST be clipped to `bounds` height (no overflow); keep/clarify the baseline rule (first line's baseline one ascent below `bounds` top) and the metric-comparable `monospace`/`sans-serif`/`serif` requirement.
- Shapes/Color (L73-75): state explicitly that for `SHAPE_TEXT`, a non-empty `fill_color` paints the `bounds` background box behind the glyphs (KEEP decision).

**Patterns to follow:** the existing tolerance/MUST phrasing in the Conformance and Text sections.

**Test scenarios:**
- Test expectation: none -- contract markdown; the rules are enforced by app U6 and firmware U2/U3/U4/U5 tests.

**Verification:**
- Each of the four audited render divergences maps to one tightened clause that a reviewer can cite.

---

- U4. **Document §11 ordering and the `protocol_version` requirement in `bluetooth.proto`**

**Goal:** Make the WiFi-Direct-before-session-config ordering explicit, and require a version check.

**Requirements:** R7, R8

**Dependencies:** None

**Files:**
- Modify: `bluetooth.proto` (§11 "Design flow" comment L402-408; `DeviceInfoResponse.protocol_version` comment ~L159; versioning block ~L39)

**Approach:**
- Extend the Design flow comment to state the ordering: `StartWifiDirectCommand` → `PushSessionConfigCommand` → `PushOverlayLayoutCommand` → `RecordingControlCommand`, with a one-line rationale (session config provisions streaming sinks needing the group).
- Add prose at `protocol_version`: consumers MUST read it from `DeviceInfoResponse` and define mismatch behavior (state the chosen behavior: surface a clean version-skew error, do not silently proceed).

**Patterns to follow:** existing §-numbered comment blocks and the versioning policy at L39-44.

**Test scenarios:**
- Test expectation: none -- contract comments; ordering is enforced + tested by firmware U8, and the version check by app U5.

**Verification:**
- §11 names the full ordering; the `protocol_version` field carries an explicit MUST.

---

- U5. **Make `ChunkAck` flow-control symmetric in `README.md`**

**Goal:** Specify that inbound (app→camera) command chunks are acknowledged per chunk, not only firmware→app response chunks.

**Requirements:** R9

**Dependencies:** None

**Files:**
- Modify: `README.md` ("MTU and Chunking", L93-115)

**Approach:**
- Reword L113-114 to state the rule for both directions: the receiver (either side) acknowledges each received chunk with a `ChunkAck` write keyed by `correlation_id` + `chunk_index`, and the sender withholds the next chunk until acked. Note `ChunkAck` has no direction field by design — it is symmetric.

**Patterns to follow:** the existing chunking prose; keep the 500-byte/MTU example.

**Test scenarios:**
- Test expectation: none -- contract markdown; enforced by app U3/U4 and firmware U7 chunking tests.

**Verification:**
- The ack rule reads symmetrically; both consumer plans can cite it for their inbound and outbound chunk handling.

---

## System-Wide Impact

- **Interaction graph:** every consumer pins this contract via submodule; a re-bump propagates U1-U5 to app + firmware in lockstep.
- **API surface parity:** `optional` codegen changes the generated accessors (`has_*()`); both consumers regenerate (firmware at build, app via `just gen-proto`).
- **Unchanged invariants:** field numbers, message/oneof tags, and the wire format are unchanged — `optional` is wire-compatible; no `protocol_version` bump.

---

## Risks & Dependencies

| Risk | Mitigation |
|------|------------|
| No CI/lint in proto repo — a syntax error ships silently | Eyeball-validate; the firmware build-time protoc and app `just gen-proto` are the first real validators — run them before the lockstep re-bump |
| `optional` codegen subtly changes consumer accessors | Coordinated lockstep re-bump; consumer plans (firmware U1, app U6) explicitly handle `has_*()` |
| Documented ordering may be stricter than a future flow needs | Stated with rationale; revisit via the same coordinated-change process if the dependency disappears |

---

## Sources & References

- **Origin document:** [docs/brainstorms/2026-06-08-app-firmware-logic-alignment-requirements.md](docs/brainstorms/2026-06-08-app-firmware-logic-alignment-requirements.md)
- Precedent: `docs/plans/2026-06-07-001-feat-overlay-rendering-semantics-plan.md`
- Sibling plans: `sst-cam-app` `docs/plans/2026-06-09-016-feat-logic-alignment-app-plan.md`, `sst-cam-firmware` `docs/plans/2026-06-09-001-feat-logic-alignment-firmware-plan.md`
