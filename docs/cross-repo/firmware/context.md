# sst-cam-firmware — context

> Working memory about the firmware consumer, maintained from `sst-cam-proto`.
> The firmware repo is a separate checkout; its code is not visible from here.
> Confirm anything marked **assumed** against the real repo before relying on it.

## What it is

The camera-side C++/CMake firmware. It is the **responder**: it answers every
command and never pushes unsolicited data. It is the BLE peripheral, the WiFi
Direct group owner, and the RTSP preview server.

## Role on the wire

- **BLE peripheral.** MUST advertise service UUID `A1B2C3D4-0001-...` in the
  advertising payload, and set the BLE device name to `sst-cam-NNNN`
  (zero-padded 4-digit unit number). The app's two-layer filter (UUID + name
  prefix) depends on both.
- **Strict responder.** Receives `Command` on Command Write, replies with
  `CommandResponse` on Command Response notify. MUST respond to *every* command;
  on failure send `status = ERROR` with a descriptive `error_message`. Never
  sends unsolicited notifications.
- **Chunking.** Wraps payloads in `ChunkedPayload`; for multi-chunk (e.g.
  thumbnails) waits for the app's `ChunkAck` before sending the next chunk.
- **WiFi Direct group owner.** On `StartWifiDirectCommand`, brings up the group
  and returns credentials in `WifiDirectGroupResponse`.
- **RTSP server.** Serves H.264 preview at
  `rtsp://<group_owner_ip>:8554/preview`.

## How it consumes the contract

- Pins `proto/` as a git submodule at the **same commit** as the app.
- C++ codegen toolchain: **assumed** `protoc --cpp_out` driven by CMake;
  the exact target/output path is not recorded here — verify in the repo and
  fill in.
- Fresh clones need `git submodule update --init` to populate `proto/`.

## Implementation contract lives in the app repo

The full firmware behavior spec — session lifecycle, required commands, overlay
rendering, file layout, constraints — is `docs/firmware-spec.md` **in the
`sst-cam-app` repo**, not here and not in the firmware repo's README. That spec
is the source of truth for *what the firmware must do*; these protos are only
*how it talks*.

## Standing assumptions (verify before relying)

- **Thumbnail budget.** Targets ≤ 160×90 JPEG quality ~60 (~4–8 KB), ~10–20
  writes at 500-byte chunks, gated on `ChunkAck`.
- **Protocol version.** Sets `DeviceInfoResponse.protocol_version`; the app
  gates features on it. Bump on breaking schema changes.
- **No push channel.** There are only two characteristics; no dedicated
  telemetry/match notify characteristic exists. All data flows through the
  request/response pair.

## Pointers

- Last known pushed feature branch tip: `efdbff9`, pinning proto `31ecaca`.
- Coordination checklist for contract changes → [`coordination.md`](coordination.md).
