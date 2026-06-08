# Connected repos

This repo (`sst-cam-proto`) is the **wire-contract source of truth**. It is
consumed as a git submodule (mounted at `proto/`) by downstream repos. Those
repos live in separate checkouts, so their code is **not** visible from here.

This folder holds, one subfolder per connected repo, the working memory about
each consumer: its stack, how it consumes the contract, the assumptions this
repo relies on when changing the protos, and the cross-repo coordination steps
a contract change forces on it.

## Why this exists

When working in `sst-cam-proto` you regularly need to:

- **Assume** something about a consumer's behavior or build (e.g. how the app
  regenerates bindings) without being able to read its code.
- **Coordinate** a change: a breaking proto edit means the app *and* firmware
  must move alongside it. Each repo folder records what that move looks like.

Treat each folder as the canonical record. When an assumption is confirmed or
proved wrong against the real consumer repo, **update the folder** so the next
change starts from fact, not guesswork.

## Folders

| Repo               | Folder                       | Stack         | Role on the wire |
| ------------------ | ---------------------------- | ------------- | ---------------- |
| `sst-cam-app`      | [`app/`](app/)               | Flutter/Dart  | Initiator — BLE central, WiFi Direct client, RTSP consumer |
| `sst-cam-firmware` | [`firmware/`](firmware/)     | C++/CMake     | Responder — BLE peripheral, WiFi Direct group owner, RTSP server |

## Each folder contains

- **`context.md`** — what the repo is, its stack/build, how it consumes
  `proto/`, and the standing assumptions this repo makes about it.
- **`coordination.md`** — the checklist for landing a contract change in that
  repo: what regenerates, what breaks, what must ship together.
- **`external/`** — handoffs/questions that **came from** that repo or an
  external session (inbound to this repo). The firmware-authored asks land here.
- **`outbound/`** — handoffs this repo **sends to** that repo (authored here).
  Direction is also in each doc's `source_repo` / `target_repo` frontmatter.

Both handoff folders are optional — create them when the first doc appears.

## Adding a new connected repo

1. Create `docs/cross-repo/<repo>/` with `context.md` + `coordination.md`.
2. Add a row to the table above.
3. Record how it pins and regenerates from `proto/`, and what a breaking change
   costs it.

## When implementing something new across repos

A new feature that touches the wire almost always lands in three places at
once: the schema here, the responder in firmware, the initiator in app. Before
editing a proto:

1. Read both `coordination.md` files — they say what a change forces downstream.
2. Decide if the change is **additive** (optional fields → backward compatible,
   no lockstep release) or **breaking** (remove/rename/renumber, enum value
   change, semantic shift → bump `DeviceInfoResponse.protocol_version` and ship
   all repos together).
3. Note the planned downstream work in each `coordination.md` so the consuming
   repos develop alongside instead of after.
