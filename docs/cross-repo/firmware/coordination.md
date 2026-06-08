# sst-cam-firmware — coordination

What landing a `proto/` change forces in the firmware repo. Read this **before**
editing a proto.

## After any proto change

1. Bump the firmware's `proto/` submodule to the new commit (same sha as app).
2. Regenerate C++ bindings via the CMake codegen step (**verify the exact
   target in the repo**).
3. Rebuild; the C++ compiler surfaces removed/renamed fields as errors.

## Additive change (backward compatible)

Adding **optional** fields or new messages. No lockstep release required.

- Firmware can ignore new request fields and leave new response fields unset
  until it implements them.
- Still bump the submodule and regenerate.

## Breaking change (lockstep release)

Remove / rename / renumber a field, change an enum's integer value, or shift a
field's meaning.

- Bump `DeviceInfoResponse.protocol_version`.
- Firmware must handle the new shape and report the new version.
- **Ship app + firmware together** pinned to the same proto commit.

## Firmware-specific impact map

| Change touches | Firmware work it forces |
| -------------- | ----------------------- |
| `Command` dispatch / new command | Command handler + `CommandResponse` builder; never leave a command unanswered |
| `CommandResponse` / status enum | Error path must still send `status = ERROR` + `error_message` |
| `ChunkedPayload` / `ChunkAck` | Chunk emitter + ack-gated flow control |
| Telemetry / thumbnail messages | Sensor/frame encode within the thumbnail budget |
| WiFi Direct handshake | Group-owner bring-up, `WifiDirectGroupResponse` credentials |
| RTSP descriptor | Stream server at `:8554/preview` |
| Advertising / device-info fields | BLE advert payload + `sst-cam-NNNN` naming |
| Overlay rendering (`bluetooth.proto` §11) | Renderer must conform to `overlay-rendering.md` (this repo) within tolerance; re-validate against the reference fixtures |
| Behavior change | The behavior spec is `docs/firmware-spec.md` in the **app** repo — update it there |

## Verify

- `git submodule status` in the firmware shows the new sha with a leading space.
- CMake codegen regenerated; firmware build green.
- Manual: app filters and connects (UUID + `sst-cam-NNNN` name still match).
