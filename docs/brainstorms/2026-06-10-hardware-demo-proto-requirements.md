---
date: 2026-06-10
topic: hardware-demo-proto
---

# Hardware Demo — Proto Requirements (intelligence-deferred)

## Summary

Confirm the wire contract already covers the demo's non-intelligence paths and add the one missing piece — distinguishing raw dual-camera capture (two files, per camera) from normal cam-0 recording — as a backward-compatible optional amendment, no `protocol_version` break. Inherits scope from `sst-cam-app/docs/brainstorms/2026-06-10-hardware-demo-system-requirements.md`.

---

## Problem Frame

The proto is the gate: a demo path can't land in app or firmware until its wire shape is defined here. The contract is already stable through phase 5 surface coverage, and a review of `bluetooth.proto`/`wifi.proto` confirms most of the demo is already expressible:

- Recording control — `RecordingControlCommand` + `RecordingAction` (START/STOP/PAUSE/RESUME). ✓
- Platform streaming — `StreamingControlCommand` (action + destination) and `StreamingConfig` (`youtube_stream_key`, `instagram_stream_key`, `custom_rtmp_url`). ✓
- Download — `DownloadRequestCommand` + `DownloadTokenResponse` (http_url + token). ✓
- WiFi Direct preview — `StartWifiDirectCommand` → `WifiDirectGroupResponse`, plus `wifi.proto` `PreviewStreamDescriptor`. ✓
- Overlay state — `ScoreUpdateCommand`, `BannerEventCommand`, `MatchControlCommand`. ✓

The gap is the raw dual-camera training capture: nothing on the wire distinguishes "record both cameras raw" from "record the final cam-0 output," and `RecordingMetadata` cannot express that a recording is raw or which camera a file belongs to (raw capture yields two files per session).

---

## Requirements

- R1. Confirm and document that the demo's recording, streaming, download, WiFi Direct, preview, and overlay paths are already covered by the existing contract — no change needed for those.
- R2. Add a way to request **raw dual-camera capture** distinct from normal recording, as an additive optional change (e.g. a new `RecordingAction` value or a mode/kind field on `RecordingControlCommand`) — chosen shape decided in planning, but it must be backward-compatible.
- R3. Extend `RecordingMetadata` so a recording can be marked as raw and associate a file with a specific camera, enough for the app to store and label per-camera raw footage — additive optional fields only.
- R4. Any field added uses proto3 `optional` with a documented default where "absent vs zero" matters; removed numbers (none expected) would be `reserved`. No field renumber/removal.
- R5. `DeviceInfoResponse.protocol_version` is **not** bumped — all demo amendments are backward-compatible additions.
- R6. After any edit, regenerate bindings in both consumers (`just gen-proto` in the app; C++ gen in firmware) and confirm both build.

---

## Acceptance Examples

- AE1. **Covers R2, R3.** Given the amended contract, when the app requests raw dual-camera capture and lists recordings, then each raw file's metadata identifies it as raw and names its camera, and an old client ignoring the new fields still parses the message.
- AE2. **Covers R1, R5.** Given the demo's preview/record/stream/download/overlay flows, when implemented against the current contract, then no breaking schema change is required and `protocol_version` is unchanged.

---

## Success Criteria

- Both stacks can express every demo path on the wire, including raw dual-camera capture, without a coordinated breaking release.
- The amendment is additive: an unaware client still parses messages correctly.
- The firmware and app requirements docs can reference concrete wire shapes for raw capture without inventing them.

---

## Scope Boundaries

- No intelligence wire surface work (match events / scoreboard semantics already defined; detections/decision messages are out for the demo).
- No breaking changes — additive optional fields only.
- No new channel or characteristic — existing GATT layout and pull model unchanged.
- Streaming-key handling beyond the existing `StreamingConfig` fields is out (the contract already carries `custom_rtmp_url` + platform keys).

---

## Key Decisions

- **Raw capture is the only new wire surface the demo needs:** everything else is already covered, so the proto change is small and isolated.
- **Additive-only, no version bump:** keeps the demo from forcing a coordinated breaking release across both stacks under deadline pressure.

---

## Dependencies / Assumptions

- Firmware's raw file format/container decision (per-camera) informs how much metadata `RecordingMetadata` must carry — coordinate with the firmware plan before finalizing R3.
- Existing `StreamingConfig.custom_rtmp_url` + `youtube_stream_key` are sufficient for the YouTube broadcast target (no new platform-config message needed).

---

## Outstanding Questions

### Resolve Before Planning

- [Affects R2][User decision] Raw capture as a new `RecordingAction` enum value vs. a `kind`/`mode` field on `RecordingControlCommand` — decide the shape before the firmware/app plans wire it (small but cross-stack).

### Deferred to Planning

- [Affects R3][Technical] Exact additive fields on `RecordingMetadata` (e.g. `is_raw`, `camera_id`) — finalize against the firmware raw file format.
