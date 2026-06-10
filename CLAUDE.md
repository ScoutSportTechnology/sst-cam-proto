# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

The **single source of truth for the SST Cam wire contract.** Proto3 schemas +
normative rendering semantics shared by [`sst-cam-app`](https://github.com/ScoutSportTechnology/sst-cam-app)
and [`sst-cam-firmware`](https://github.com/ScoutSportTechnology/sst-cam-firmware),
each of which mounts this repo as a git submodule at `proto/`.

There is no build here — it's schemas and specs. The cost of a mistake is high:
a change lands in two stacks at once. Treat every edit as a contract amendment.

## Files

| File | Contents |
| ---- | -------- |
| `bluetooth.proto` | All BLE control schema — framing (`ChunkedPayload`/`ChunkAck`), `Command`/`CommandResponse` envelopes, telemetry, match events, recording/streaming, session push, WiFi Direct handshake |
| `wifi.proto` | WiFi-only descriptors — RTSP preview descriptor, preview heartbeat |
| `overlay-rendering.md` | **Normative** overlay rendering semantics both stacks must match byte-for-pixel: coordinate space, text layout, shapes, color/opacity, tolerance + reference fixtures |
| `README.md` | Developer quick-reference: GATT UUIDs, channel split, pull model, MTU/chunking, versioning |

The firmware **implementation** contract (session lifecycle, required commands,
overlay *authoring*, file layout) lives in `docs/firmware-spec.md` in the
**`sst-cam-app`** repo — not here. Split: this repo = wire format + rendering
rules both consumers must match; app repo = how firmware should behave.

## Core invariants — do not break without coordination

- **Pull model.** The app always initiates; firmware never pushes unsolicited
  data. Every exchange is `Command → CommandResponse`, matched by `correlation_id`.
- **Two GATT characteristics only** — Command Write + Command Response (notify).
  No per-data-type notification characteristics. See README for UUIDs.
- **Everything is chunked.** All messages ride the `ChunkedPayload` envelope;
  `ChunkAck` flow control is **symmetric** (no direction field, by design).
- **Device filter** — UUID (primary) + `sst-cam-NNNN` name prefix (secondary).

## Changing the schema (versioning)

- Adding **optional** fields is backward-compatible — safe.
- Use `reserved` to tombstone removed field numbers; never reuse a number.
- Removing, renaming, or renumbering a field is a **breaking change**: bump
  `DeviceInfoResponse.protocol_version` (uint32) and ship a coordinated
  firmware + app release. The app warns and disables unsupported features when
  the firmware's protocol version trails what it expects.
- To express "intentionally absent vs. zero" on a shared scalar, use proto3
  `optional` plus a documented default (see `docs/solutions/`).

## Regenerating bindings

This repo holds no generated code — consumers generate their own:

- **App (Dart):** `just gen-proto` inside its devcontainer (`protoc` +
  `protoc_plugin 21.1.2`, pinned to `protobuf: 3.1.0`).
- **Firmware (C++):** generated in its own build.

After any `.proto` edit, regenerate in **both** consumers and run their suites —
a contract change isn't done until both stacks build against it.

## Documented solutions

`docs/solutions/` — past contract-evolution learnings (cross-stack drift, the
`optional`-plus-default pattern, multi-repo orchestration) with YAML frontmatter
(`module`, `tags`, `problem_type`). Read the relevant one before amending the
contract or debugging app↔firmware divergence. `docs/brainstorms/` and
`docs/plans/` hold requirements and plans behind the current shape.
