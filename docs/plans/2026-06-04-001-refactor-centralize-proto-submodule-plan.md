---
title: "refactor: Centralize proto contracts as shared git submodule"
type: refactor
status: active
date: 2026-06-04
origin: docs/brainstorms/centralize-proto-contracts-requirements.md
---

# refactor: Centralize proto contracts as shared git submodule

## Summary

Populate the empty `sst-cam-proto` repo with the three wire-contract files, then replace the app's tracked `proto/` directory with a submodule pointing at it and add the same submodule to the firmware repo. Both consumers end up pinned to one shared proto commit; the app's Dart codegen path is unchanged so generated bindings stay byte-identical.

**Repo paths convention:** This plan spans three repos. Paths are prefixed with the repo name when ambiguous (`app:`, `firmware:`, `proto:`). Unprefixed paths are relative to `sst-cam-proto` (this repo). All paths are repo-relative.

---

## Problem Frame

`bluetooth.proto`, `wifi.proto`, and `proto/README.md` live inside `sst-cam-app`. The firmware (C++) needs the same wire contract but has no shared source, so the protocol is duplicated conceptually and can drift. The `sst-cam-proto` repo exists and is cloned locally but is empty (only `LICENSE`, `README.md`).

---

## Requirements

- R1. `sst-cam-proto` is the single source of truth holding `bluetooth.proto`, `wifi.proto`, `README.md` — nothing else.
- R2. Extraction is a clean copy (fresh commit, no history rewrite).
- R3. `sst-cam-app` consumes the protos via submodule mounted in place at `proto/`; `just gen-proto` keeps working unchanged.
- R4. `sst-cam-firmware` consumes the same submodule mounted at `proto/` (repo root).
- R5. Regenerating Dart bindings post-swap produces byte-identical output in `app: lib/models/proto/` (no diff).
- R6. Both repos pin `proto/` to the same `sst-cam-proto` commit.

**Origin acceptance examples:** Success Criteria in origin map to R5 (byte-identical regen) and R6 (both repos point at same commit).

---

## Scope Boundaries

- No C++ codegen for firmware (nanopb / protobuf-c) — firmware mounts the schema only; binding generation is future work.
- `app: docs/firmware-spec.md` is NOT moved into the proto repo.
- No shared/centralized codegen tooling in the proto repo.
- No git-history preservation of the proto files.
- No change to the protocol schema content itself — pure relocation.

---

## Context & Research

### Relevant Code and Patterns

- `app: proto/` — git-tracked source: `bluetooth.proto`, `wifi.proto`, `README.md`. README points at `app: docs/firmware-spec.md` for the full contract.
- `app: justfile` `gen-proto` target: `protoc --dart_out=lib/models/proto -I proto proto/*.proto`. Both `-I proto` and the output dir are unchanged by mounting the submodule at `proto/`.
- `app: lib/models/proto/` — live generated Dart, gitignored (`app: .gitignore:55`), imported across `lib/` via relative path `../../models/proto/` (e.g. `lib/core/ble/ble_protocol.dart:11`). Generated output dir is independent of the `proto/` source dir, so the swap does not touch Dart imports.
- `app: lib/core/models/proto/` — empty stale directory, not used. Out of scope; optionally delete in cleanup.
- `firmware:` — C++/CMake/conan. No `proto/` dir, no protobuf dependency today. Mounting at `proto/` has no conflict and does not yet feed the build.

### Institutional Learnings

- Versioning rules in `proto: README.md` ("Versioning" section): breaking schema changes bump `DeviceInfoResponse.protocol_version` and require coordinated submodule-pointer updates in both consumers. Carries forward unchanged.

### External References

- Submodule URL: `https://github.com/ScoutSportTechnology/sst-cam-proto.git` (confirmed via `git remote -v`).

---

## Key Technical Decisions

- Mount the submodule at `proto/` in both repos (mirror layout): keeps `just gen-proto -I proto` untouched in the app and gives the firmware a consistent, predictable path.
- Push `sst-cam-proto` content (U1) before wiring either consumer: submodule `add` resolves the commit from the remote, so the remote must carry the files first.
- Leave generated Dart gitignored and regenerate after the swap rather than committing bindings: parity is then provable by an empty `git diff` (R5).

---

## Open Questions

### Resolved During Planning

- Firmware mount path: `proto/` at repo root (chosen over `third_party/` / `external/`) — mirrors app, no existing conflict.
- Remote availability: `ScoutSportTechnology/sst-cam-proto` exists and is cloned locally; safe to push.
- Which generated dir is live: `app: lib/models/proto/` (the `core/models/proto` variant is empty/stale).

### Deferred to Implementation

- Whether to delete the stale empty `app: lib/core/models/proto/` dir — trivial cleanup, decide at execution.
- Exact reword (if any) of the `proto: README.md` line referencing `docs/firmware-spec.md`, now cross-repo — see U1 approach.

---

## Implementation Units

- U1. **Populate and push sst-cam-proto**

**Goal:** Get the three contract files into this repo on the remote so consumers can resolve the submodule.

**Requirements:** R1, R2

**Dependencies:** None

**Files:**
- Create: `bluetooth.proto` (copy of `app: proto/bluetooth.proto`)
- Create: `wifi.proto` (copy of `app: proto/wifi.proto`)
- Create: `README.md` — replace the current 1-line placeholder with `app: proto/README.md` content
- Modify (optional): `README.md` — adjust the `docs/firmware-spec.md` reference note since that doc stays in the app repo (e.g. note it lives in `sst-cam-app`)

**Approach:**
- Copy the three files verbatim from `app: proto/` into the repo root (proto files sit at root so the app's `-I proto` resolves `proto/bluetooth.proto` etc.).
- Preserve the existing `LICENSE`. The repo `README.md` becomes the proto quick-reference (origin keeps `README.md` as one of the three centralized files).
- Commit and push to `origin/main` so U2/U3 can add the submodule against a real remote commit.

**Patterns to follow:**
- Keep file layout flat at repo root, matching how `app: proto/` lays out `*.proto` + `README.md` side by side.

**Test scenarios:**
- Test expectation: none — file relocation + commit, no behavioral logic. Verified structurally in Verification.

**Verification:**
- Remote `main` contains `bluetooth.proto`, `wifi.proto`, `README.md` and they are byte-identical to the app's originals (`diff` clean).
- `LICENSE` still present.

---

- U2. **Replace app proto/ with submodule and prove codegen parity**

**Goal:** Swap the app's tracked `proto/` for the `sst-cam-proto` submodule and confirm Dart bindings regenerate identically.

**Requirements:** R3, R5, R6

**Dependencies:** U1

**Files:**
- Modify: `app: .gitmodules` (created by submodule add)
- Delete (from git): `app: proto/bluetooth.proto`, `app: proto/wifi.proto`, `app: proto/README.md`
- Add: `app: proto/` as submodule → `https://github.com/ScoutSportTechnology/sst-cam-proto.git`
- Unchanged: `app: justfile` (`gen-proto`), `app: lib/models/proto/*` (regenerated, gitignored)

**Approach:**
- Remove the three tracked files from the app's `proto/` and untrack the directory, then add the submodule at the same `proto/` path pinned to the U1 commit.
- Regenerate bindings (`just gen-proto`) and confirm the working tree shows no diff in `app: lib/models/proto/` — proves the relocated schema is identical (R5).
- Optionally delete the stale empty `app: lib/core/models/proto/`.
- Sanity-check that the app still analyzes/builds (imports resolve unchanged because the generated output path did not move).

**Patterns to follow:**
- `app: justfile` `gen-proto` invocation stays exactly as-is — the submodule makes `proto/*.proto` resolve to the same paths.

**Test scenarios:**
- Integration: run `just gen-proto`; expect `git status` clean for `app: lib/models/proto/` (no regenerated diff). Covers R5.
- Integration: `flutter analyze` (or existing `just analyze`) passes — proto imports across `app: lib/` still resolve.
- Edge case: fresh checkout simulation — after `git submodule update --init`, `proto/*.proto` are present and `gen-proto` succeeds.

**Verification:**
- `app: .gitmodules` references `sst-cam-proto` at `proto/`; `git submodule status` shows the pinned U1 commit.
- `just gen-proto` yields zero diff in generated bindings.
- App analyze/build passes.

---

- U3. **Add submodule to firmware**

**Goal:** Give the firmware repo the shared contract at `proto/`.

**Requirements:** R4, R6

**Dependencies:** U1

**Files:**
- Modify: `firmware: .gitmodules` (created by submodule add)
- Add: `firmware: proto/` as submodule → `https://github.com/ScoutSportTechnology/sst-cam-proto.git`

**Approach:**
- Add the submodule at `proto/` (repo root), pinned to the same U1 commit the app uses (R6).
- Do NOT wire it into CMake/conan yet — this unit only vendors the schema source. C++ binding generation is out of scope (Scope Boundaries).
- Confirm the firmware still configures/builds unchanged (the new `proto/` dir is inert to the current build).

**Patterns to follow:**
- Mirror the app mount path (`proto/`) for cross-repo consistency.

**Test scenarios:**
- Edge case: fresh checkout — `git submodule update --init` populates `firmware: proto/` with `bluetooth.proto`, `wifi.proto`, `README.md`.
- Integration: existing CMake configure (`cmake --preset ...`) still succeeds — the inert `proto/` dir does not break the build.

**Verification:**
- `firmware: .gitmodules` references `sst-cam-proto` at `proto/`; `git submodule status` shows the same pinned commit as the app.
- Firmware build/configure unaffected.

---

## System-Wide Impact

- **API surface parity:** Both consumers now derive the wire contract from one source. A schema change is made once in `sst-cam-proto`, then each consumer bumps its submodule pointer — replacing today's silent-drift risk.
- **State lifecycle risks:** Submodule pin drift — a repo can sit on an old proto commit. Mitigated by R6 (both pinned to same commit at landing) and the versioning discipline in `proto: README.md`. A future CI check (deferred) could enforce tip-tracking.
- **Unchanged invariants:** App Dart import paths (`../../models/proto/`), the `gen-proto` command, the gitignore of generated bindings, and the firmware build are all explicitly unchanged. Only the source-of-truth location of the `.proto` files moves.

---

## Risks & Dependencies

| Risk | Mitigation |
|------|------------|
| Submodule `add` fails because remote lacks the files | U1 pushes content first; U2/U3 depend on U1. |
| Regenerated Dart differs after swap (unexpected schema change during copy) | U2 regenerates and asserts zero diff (R5); copy is verbatim in U1. |
| Consumers drift to different proto commits over time | Pin both to same commit at landing (R6); README versioning rules; future CI tip-check (deferred). |
| `proto: README.md` dangling reference to `docs/firmware-spec.md` confuses firmware devs | U1 reword note clarifying the spec lives in `sst-cam-app`. |

---

## Sources & References

- **Origin document:** [docs/brainstorms/centralize-proto-contracts-requirements.md](docs/brainstorms/centralize-proto-contracts-requirements.md)
- Submodule remote: `https://github.com/ScoutSportTechnology/sst-cam-proto.git`
- App codegen: `sst-cam-app: justfile` (`gen-proto`), generated into `sst-cam-app: lib/models/proto/`
- Proto wire-format & versioning reference: `sst-cam-app: proto/README.md` (becomes `sst-cam-proto: README.md`)
