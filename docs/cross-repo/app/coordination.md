# sst-cam-app — coordination

What landing a `proto/` change forces in the app repo. Read this **before**
editing a proto.

## After any proto change

1. Bump the app's `proto/` submodule to the new commit (same sha as firmware).
2. Regenerate bindings in the devcontainer: `just gen-proto`.
3. Rebuild; the Dart compiler surfaces removed/renamed fields as errors.

## Additive change (backward compatible)

Adding **optional** fields or new messages. No lockstep release required.

- App can adopt the new field at its own pace; old builds ignore it.
- Still bump the submodule and regenerate so the field is available.

## Breaking change (lockstep release)

Remove / rename / renumber a field, change an enum's integer value, or shift a
field's meaning.

- Bump `DeviceInfoResponse.protocol_version` here.
- App must update its `protocol_version` expectation and handle the new shape.
- **Ship app + firmware together** pinned to the same proto commit.
- Audit app enum switch/case for any changed enum values.

## App-specific impact map

| Change touches | App work it forces |
| -------------- | ------------------ |
| `Command` / `CommandResponse` envelope | Request builder + response dispatcher (`correlation_id` matching) |
| `ChunkedPayload` / `ChunkAck` | Reassembly + flow-control logic |
| Telemetry / thumbnail messages | Polling layer + decode/render |
| WiFi Direct handshake | `StartWifiDirectCommand` flow, RTSP connect |
| Any enum | switch/case over that enum |
| Overlay rendering (`bluetooth.proto` §11) | Flutter overlay renderer must conform to `overlay-rendering.md` (this repo) within tolerance; re-validate against the reference fixtures |
| Behavior, not just shape | Update `docs/firmware-spec.md` in the app repo |

## Verify

- `git submodule status` in the app shows the new sha with a leading space.
- `just gen-proto` output committed; build green in devcontainer.
