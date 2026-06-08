# sst-cam-app — context

> Working memory about the app consumer, maintained from `sst-cam-proto`.
> The app repo is a separate checkout; its code is not visible from here.
> Confirm anything marked **assumed** against the real repo before relying on it.

## What it is

The phone-side Flutter/Dart application. It is the **initiator** of every
exchange on the wire: BLE central, WiFi Direct client, RTSP preview consumer.
The firmware never pushes unsolicited — the app polls and matches responses by
`correlation_id`.

## Role on the wire

- **BLE central.** Scans, filters by service UUID `A1B2C3D4-0001-...` **and**
  name prefix `sst-cam-`. Writes `Command` to the Command Write characteristic,
  receives `CommandResponse` via the Command Response notify.
- **MTU.** Requests MTU 512 after connect. Reassembles `ChunkedPayload` by
  `correlation_id`; acks each chunk with `ChunkAck` for flow control.
- **WiFi Direct client.** After BLE pairs, sends `StartWifiDirectCommand`,
  reads credentials from `WifiDirectGroupResponse`, joins the group.
- **RTSP consumer.** Opens `rtsp://<group_owner_ip>:8554/preview` for live
  H.264 preview. Pulls recording downloads over HTTP.
- **Polling owner.** Telemetry ~1 s (`GetTelemetryCommand`), thumbnails on
  demand (`ThumbnailRequest`). Match-state polling deferred in v1.

## How it consumes the contract

- Pins `proto/` as a git submodule at the **same commit** as firmware.
- Codegen: `just gen-proto` →
  `protoc --dart_out=lib/models/proto -I proto proto/*.proto`.
- Toolchain (pinned): `protoc_plugin 21.1.2`, `protobuf: 3.1.0` Dart package.
  Run inside the devcontainer — the host may lack `just`/`protoc`.
- Generated Dart lands in `lib/models/proto/` (**assumed** path from codegen
  command; verify in repo).

## The app owns the implementation contract

`docs/firmware-spec.md` — session lifecycle, required commands, overlay
rendering, file layout, constraints — **lives in the app repo**, not here. This
proto repo's README is the wire-format quick-reference only. When a schema
change implies behavior, the spec in the app repo is where that behavior is
written down.

## Standing assumptions (verify before relying)

- **Protocol-version gate.** The app reads `DeviceInfoResponse.protocol_version`
  and warns / disables features when firmware is behind what it expects.
- **Strict initiator model.** App tolerates no unsolicited notifications beyond
  the Command Response channel it requested.
- **Enum stability.** App switch/case over enums (`Sport`, `PlayerPosition`,
  status codes) assumes integer values never change under it.

## Pointers

- Last known pushed feature branch tip: `47b7eb5`, pinning proto `31ecaca`.
- Coordination checklist for contract changes → [`coordination.md`](coordination.md).
