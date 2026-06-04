# Centralize Proto Contracts — Requirements

**Date:** 2026-06-04
**Status:** Ready for execution
**Scope:** Standard (mechanical, multi-repo)

## Problem

`bluetooth.proto`, `wifi.proto`, and `proto/README.md` live inside `sst-cam-app`. The firmware (`sst-cam-firmware`, C++) needs the same wire contract but currently has no shared source — the schema is duplicated conceptually via prose. Two repos can drift out of protocol sync.

## Goal

Make `sst-cam-proto` the single source of truth for the wire contract, consumed by both `sst-cam-app` and `sst-cam-firmware` as a git submodule.

## Decisions

| Decision | Choice |
| --- | --- |
| Repo contents | `bluetooth.proto`, `wifi.proto`, `README.md` only — pure wire contract |
| Extraction method | Clean copy (fresh commit, no history rewrite) |
| App submodule mount | Replace app's `proto/` in place at `proto/` |
| App codegen | `just gen-proto` unchanged (`-I proto`, `--dart_out=lib/models/proto`) |
| Firmware submodule mount | `proto/` at firmware root (assumption — confirm) |

## In Scope

1. Add the 3 files to `sst-cam-proto`, commit, push.
2. `sst-cam-app`: `git rm -r proto/`, add `sst-cam-proto` as submodule at `proto/`.
3. `sst-cam-firmware`: add `sst-cam-proto` as submodule at `proto/`.
4. Verify `just gen-proto` still regenerates Dart bindings identically after the swap.

## Out of Scope

- C++ codegen for firmware (nanopb / protobuf-c) — future work.
- Moving `docs/firmware-spec.md` into the proto repo.
- Shared/centralized codegen tooling.
- Preserving per-file git history of the protos.

## Success Criteria

- Both repos point `proto/` at the same `sst-cam-proto` commit.
- `just gen-proto` in `sst-cam-app` produces byte-identical output to pre-extraction (no diff in `lib/models/proto/`).
- `sst-cam-proto` is the only place either `.proto` file is edited going forward.

## Assumptions / Open Items

- **Remote exists:** submodule wiring needs `ScoutSportTechnology/sst-cam-proto` pushed to GitHub for clone URLs to resolve. If local-only, defer the firmware/app submodule `add` until pushed, or use a local path URL temporarily.
- **Dangling pointer:** `proto/README.md` references `docs/firmware-spec.md`, which stays in `sst-cam-app`. After extraction that link is cross-repo. Acceptable for v1; reword to a relative-to-app note if it confuses firmware devs.
- **Firmware mount path** `proto/` vs `third_party/proto` — confirm before wiring firmware.

## Risks

- Submodule pin drift: a repo can sit on an old proto commit silently. Mitigation (future): CI check that submodule tracks the proto repo default branch tip.
- Breaking schema change requires coordinated bump of the submodule pointer in both consumers + protocol_version increment (per `proto/README.md` versioning rules).
