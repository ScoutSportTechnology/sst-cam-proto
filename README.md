# SST-Cam Protocol

> **This repo is the single source of truth for the SST-Cam wire contract.**
> It is consumed as a git submodule (mounted at `proto/`) by both
> `sst-cam-app` and `sst-cam-firmware`.
>
> **Firmware developers:** the complete implementation contract — session lifecycle,
> required commands, overlay *authoring*, file layout, and constraints — lives in
> **`docs/firmware-spec.md`** in the **`sst-cam-app`** repo. This README is a
> developer quick-reference for the proto wire format only.
>
> **Overlay rendering semantics** — the rules both stacks must render identically
> (coordinate space, fonts/text layout, shapes, color/opacity, tolerance) — live
> in **`overlay-rendering.md`** in *this* repo, since both consumers must match
> them. (Split: rendering rules here; overlay authoring/UX in the app's
> `firmware-spec.md`.)

All control messages are encoded as Protocol Buffers (proto3). The app writes
requests and reads responses over a two-characteristic GATT service for
control, and pulls bulk data (live preview, recording downloads) over a WiFi
Direct link.

---

## Roadmap

This repo is the **contract** both stacks build against, so its roadmap is
*surface coverage* — which message groups are defined and stable — rather than
runtime features. It leads the system arc: a phase can't land in app/firmware
until its wire shape is defined here.

| Phase | Theme | Contract status |
| ----- | ----- | --------------- |
| 1 | **Framing & control** — `ChunkedPayload`, `Command`/`CommandResponse`, `ChunkAck` | ✅ stable |
| 2 | **Connect & telemetry** — discovery/filter rules, device info, telemetry | ✅ stable |
| 3 | **Capture & transfer** — recording control, WiFi Direct handshake, RTSP preview descriptor | ✅ stable |
| 4 | **Intelligence** — match events, scoreboard/banner state | ✅ defined; semantics may tighten as firmware lands |
| 5 | **Broadcast** — overlay rendering semantics (`overlay-rendering.md`), streaming | ✅ defined |

Message-group coverage (`bluetooth.proto`, 37 messages):

- [x] Framing — `ChunkedPayload`, `ChunkAck`
- [x] Command / response envelopes + `correlation_id` matching
- [x] Telemetry
- [x] Match events
- [x] Recording / streaming control
- [x] Session push
- [x] WiFi Direct handshake (`wifi.proto`: RTSP descriptor, preview heartbeat)
- [x] Overlay rendering semantics (`overlay-rendering.md`)

Stabilizing as the stacks implement against it: see [Versioning](#versioning)
for how breaking changes are coordinated (`protocol_version` bump).

---

## Channel split

| Channel       | Purpose                                                      |
| ------------- | ------------------------------------------------------------ |
| BLE GATT      | Commands, telemetry, match state, thumbnails                 |
| WiFi Direct   | Live preview (RTSP H.264 over WiFi Direct), recording downloads (HTTP) |

BLE is always available. The WiFi Direct group is brought up automatically
once BLE pairs (the app sends `StartWifiDirectCommand` and receives
credentials in `WifiDirectGroupResponse`). The phone joins the group on the
WiFi side, then opens an RTSP connection to `rtsp://<group_owner_ip>:8554/preview`.
See `wifi.proto`.

---

## Device discovery and filtering

The firmware MUST advertise the SST-Cam service UUID in its BLE advertising
payload. The app filters scan results by this UUID — devices that do not
advertise it are ignored regardless of name.

As a secondary check, the app also requires the device name to match the prefix
`sst-cam-` (e.g. `sst-cam-0001`, `sst-cam-0042`). The firmware MUST set the
BLE device name to follow this format: `sst-cam-NNNN` where NNNN is a
zero-padded 4-digit unit number.

This two-layer filter (UUID + name prefix) ensures the app never shows
unrelated BLE devices to the user.

---

## GATT Service Layout

| Role | UUID | Properties |
| ---- | ---- | ---------- |
| **SST-Cam Service** | `A1B2C3D4-0001-0000-8000-00805F9B34FB` | — |
| Command Write | `A1B2C3D4-0011-0000-8000-00805F9B34FB` | Write Without Response |
| Command Response | `A1B2C3D4-0012-0000-8000-00805F9B34FB` | Notify |

> **UUID note:** These UUIDs are placeholders. Replace with officially registered
> UUIDs before production. The layout must not change without updating both this
> document and the firmware.

Only two characteristics are needed. All data flows through them — there are no
dedicated push/notification characteristics for telemetry or match state.

---

## Communication model — app pulls, firmware responds

**The app is always the initiator.** The firmware never pushes unsolicited data.

- The app sends a `Command` to the **Command Write** characteristic.
- The firmware processes it and sends a `CommandResponse` via **Command Response** notify.
- The app matches request to response via `correlation_id`.

Polling responsibilities (all on the app side):

| Data | Command | Suggested interval |
| ---- | ------- | ----------------- |
| Telemetry | `GetTelemetryCommand` | 1 s |
| Match state | `GetMatchStateCommand` | deferred in v1 (telemetry covers operational needs) |
| Thumbnail | `ThumbnailRequest` | on demand |

The firmware MUST respond to every command. If it cannot, it MUST send a
`CommandResponse` with `status = ERROR` and a descriptive `error_message`.

---

## MTU and Chunking

Request MTU 512 bytes after connect (the maximum). Actual MTU depends on
negotiation; minimum guaranteed is 23 bytes (20 usable after ATT overhead).

**All messages use the `ChunkedPayload` envelope** to handle payloads larger
than the negotiated MTU. The `correlation_id` links chunks to their request.

```text
┌──────────────────────────────────────────────┐
│ ChunkedPayload                               │
│   correlation_id  : string                   │
│   chunk_index     : uint32  (0-based)        │
│   total_chunks    : uint32                   │
│   data            : bytes   (proto payload)  │
└──────────────────────────────────────────────┘
```

Single-chunk messages set `chunk_index = 0` and `total_chunks = 1`.

**Thumbnail note:** Target ≤ 160×90 JPEG at quality 60 (~4–8 KB).
At 500-byte chunks ≈ 10–20 writes.

**Flow control (symmetric):** The receiver — *either* side — acknowledges each
received chunk with a `ChunkAck` write keyed by `correlation_id` + `chunk_index`,
and the sender MUST withhold the next chunk until that ack arrives. This applies
in **both** directions: app→camera command chunks and camera→app response chunks.
`ChunkAck` has no direction field by design — it is symmetric.

---

## Schema files

The BLE control schema previously lived in six files (`command`, `telemetry`,
`match`, `recording`, `team`, `config`). They were consolidated into a single
`bluetooth.proto` to mirror the unified `wifi.proto` style. During the merge,
the `Sport` enum was deduplicated (the previous match.proto / team.proto
copies disagreed on integer values — the wider match.proto set won) and
`PlayerInfo.position` was retyped from `string` to the `PlayerPosition` enum.

| File | Contents |
| ---- | -------- |
| `bluetooth.proto` | All BLE control schema: framing, `Command` / `CommandResponse` envelopes, telemetry, match events, recording / streaming, session push, WiFi Direct handshake |
| `wifi.proto` | WiFi-only descriptors: RTSP preview stream descriptor, preview heartbeat |
| `overlay-rendering.md` | Normative overlay rendering semantics both stacks must match: coordinate space, text layout, shapes, color/opacity, tolerance + reference fixtures (companion to `bluetooth.proto` §11) |

**Regenerating Dart bindings:** run `just gen-proto` inside the devcontainer.
Requires `protoc` and `protoc_plugin 21.1.2` (pinned to match `protobuf: 3.1.0`).
Install: `sudo apt-get install protobuf-compiler && dart pub global activate protoc_plugin 21.1.2`

---

## Documented solutions

`docs/solutions/` — documented solutions to past problems (contract-evolution
learnings, cross-stack drift, workflow patterns), organized by category with
YAML frontmatter (`module`, `tags`, `problem_type`). Relevant when amending the
wire contract or debugging app↔firmware divergence — e.g. the proto3
`optional`-and-documented-default pattern for expressing intent on shared
scalars.

---

## Versioning

- Use `reserved` to tombstone removed field numbers so they are never reused.
- `DeviceInfoResponse.protocol_version` (uint32) is incremented on breaking
  schema changes. The app warns and disables unsupported features when the
  firmware protocol version is behind what the app expects.
- Adding optional fields is backward-compatible.
- Removing, renaming, or renumbering fields requires a coordinated firmware +
  app release.

### Release model — branches, ladder, tags

This repo is **artifact-free**: the **tag is the release**, consumers vendor the
submodule and pin a tag's commit. Branch model:
`feat/* → development → release/X.Y.Z → main`, with a contract maturity ladder:

| Rung | Where | Tag | Meaning |
| ---- | ----- | --- | ------- |
| **alpha** | push to `development` | `vX.Y.Z-alpha.N` | contract validated by `buf lint` + `buf breaking` + `buf build` in isolation |
| **beta** | push to `release/X.Y.Z` | `vX.Y.Z-beta.N` | candidate proven against the real consumers (firmware + app) in integration |
| **stable** | merge to `main` | `vX.Y.Z` | shipped (no build, no asset — `release.yml` only tags a beta-validated commit) |

**The bump encodes wire compatibility** — this repo is the org's source of
"breaking". A breaking change (remove/rename/renumber a field) is `feat!:` /
`BREAKING CHANGE` → **major** (past `1.0.0`); additive → `feat:` → **minor**;
non-breaking fix → `fix:`/`perf:` → **patch**. `buf breaking` (in CI, vs `main`)
is the automated classifier. A proto major forces a major in both consumers.

Pushing to `main` does **not** auto-cut a fresh release — promotion only
elevates an already-validated beta candidate to its stable tag.

### How consumers pin a version (submodule)

Both app and firmware embed this repo as a git submodule at `proto/`. Pin a
`-beta.N` for integration and a stable `vX.Y.Z` for release:

```bash
cd proto && git fetch --tags && git checkout v0.1.0-beta.1 && cd ..
git add proto && git commit -m "chore(proto): pin contract to v0.1.0-beta.1"
```
