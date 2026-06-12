---
title: "feat: CI/CD & release pipeline (sst-cam-proto)"
type: feat
status: active
date: 2026-06-10
origin: docs/brainstorms/ci-cd-release-pipeline-requirements.md
---

# feat: CI/CD & Release Pipeline (sst-cam-proto)

**Target repo:** sst-cam-proto

## Summary

Stand up lint → test → release for the proto repo: `buf lint` + `buf breaking` gate PRs, release-please cuts semver tags on merge to `main`, and each release publishes a **versioned Dart package** consumed by the Flutter app via a git-tag dependency. Firmware keeps the submodule unchanged.

---

## Problem Frame

Protocol changes ship today as raw submodule SHA bumps with no breaking-change gate and no versioning; each consumer runs its own codegen. There is no CI, no tags, and no published SDK. The app (Flutter/Dart) needs a versioned, prebuilt binding it can depend on without running protoc in its own build.

> **Origin correction:** the requirements doc assumed a Kotlin/Java SDK on GitHub Packages Maven. Recon confirmed the app is **Flutter/Dart**, so the SDK is a **Dart package distributed by git tag** (decided with user). Maven/Kotlin is dropped. (see origin: docs/brainstorms/ci-cd-release-pipeline-requirements.md)

---

## Requirements

- R1. PRs to `main` run `buf lint` + `buf breaking` (against `main`); merge blocked until green.
- R2. `main` is PR-gated (1 approval) with immutable semver tags.
- R3. Merging a release-please PR bumps semver, tags, and cuts a GitHub Release — no manual tagging.
- R4. Each release exposes a versioned **Dart package** the app can depend on by tag (`ref: vX.Y.Z`), with no protoc in the app build.
- R5. Firmware's submodule consumption stays working unchanged.

**Origin actors:** developers (open PRs), app build (SDK consumer), firmware build (submodule consumer).

---

## Scope Boundaries

- No C++ SDK packaging — firmware keeps the git submodule.
- No public registry (no pub.dev, no self-hosted pub server) — distribution is git-tag only.
- No multi-language SDK fan-out beyond Dart for now.

### Deferred to Follow-Up Work

- Org GitHub App creation + install: shared prerequisite across all 3 repos, done once (see Risks & Dependencies). This plan consumes it; it does not create it.

---

## Context & Research

### Relevant Code and Patterns

- `bluetooth.proto`, `wifi.proto` — 2 files, single package `sst_cam`, proto3 with `optional` fields (needs `--experimental_allow_proto3_optional` / buf equivalent).
- `proto/` — empty subdir, currently unused.
- App codegen today: `sst-cam-app/justfile` `gen-proto` → `protoc --dart_out=lib/models/proto -I proto proto/*.proto` with `protoc_plugin` (Dart). This is the codegen contract the Dart package must reproduce.
- Firmware codegen: `sst-cam-firmware/CMakeLists.txt` host-protoc invocation; must keep working off the submodule.

### Institutional Learnings

- `docs/solutions/` — none directly relevant to CI yet.
- README already documents semver governance (breaking change ⇒ `protocol_version` bump + coordinated release) — align release-please bumps with this.

### External References

- buf: `buf lint`, `buf breaking --against` for PR gating; `buf generate` with `protoc-gen-dart` plugin for Dart output.
- release-please: manifest mode, `extra-files` generic updater to bump a version string inside the generated package's `pubspec.yaml`.

---

## Key Technical Decisions

- **buf for lint/breaking AND codegen.** `buf.yaml` for lint+breaking rules; `buf.gen.yaml` drives Dart generation via `protoc-gen-dart`. Single tool, reproducible. Keeps the same Dart output the app already uses.
- **Generated Dart package is committed in-repo** at `gen/dart/` (pubspec + `lib/`), not gitignored. The app's git-tag dependency resolves a subdir at a tagged commit, so generated code must exist at that commit. A PR CI check regenerates and fails on drift.
- **release-please owns the version** in `gen/dart/pubspec.yaml` via `extra-files`, so the package version always equals the release tag.
- **GitHub App token** (not `GITHUB_TOKEN`) pushes the tag so downstream workflows can fire and the tag-ruleset bypass works.

---

## Open Questions

### Resolved During Planning

- SDK language/distribution: Dart package via git tag (user-confirmed; supersedes origin Maven/Kotlin).
- Codegen tool: buf (`protoc-gen-dart`).

### Deferred to Implementation

- Exact `protoc-gen-dart` version pin (match app's `protoc_plugin 21.1.2` lineage) — confirm at implementation against current buf plugin availability.
- `buf breaking` baseline: against `main` branch HEAD vs last release tag — default to `main` for PRs; revisit if noisy.

---

## Output Structure

    sst-cam-proto/
      buf.yaml
      buf.gen.yaml
      bluetooth.proto
      wifi.proto
      gen/
        dart/
          pubspec.yaml          # version managed by release-please
          lib/
            sst_cam_proto.dart  # barrel export
            *.pb.dart           # generated (committed)
      release-please-config.json
      .release-please-manifest.json
      .github/
        workflows/
          ci.yml                # buf lint + breaking + codegen-drift check
          release.yml           # release-please + regenerate on tag

---

## Implementation Units

### U1. buf tooling + Dart package skeleton

**Goal:** Introduce buf for lint/breaking and Dart codegen; establish the committed `gen/dart/` package.

**Requirements:** R1, R4

**Dependencies:** None

**Files:**
- Create: `buf.yaml` (lint + breaking config, proto3-optional allowed)
- Create: `buf.gen.yaml` (managed `protoc-gen-dart` plugin → `gen/dart/lib`)
- Create: `gen/dart/pubspec.yaml` (package name `sst_cam_proto`, version `0.0.0` placeholder, Dart SDK + protobuf dep)
- Create: `gen/dart/lib/sst_cam_proto.dart` (barrel export of generated files)
- Generate (committed): `gen/dart/lib/*.pb.dart`

**Approach:**
- `buf.yaml`: enable default lint rules; `breaking.use: [FILE]`. Tune lint exclusions only where the existing 2 files would otherwise fail (document any disabled rule).
- `buf.gen.yaml`: single Dart plugin, output `gen/dart/lib`.
- Barrel file re-exports `bluetooth.pb.dart` + `wifi.pb.dart` so the app imports one package.

**Patterns to follow:**
- Match the app's current Dart output (`sst-cam-app/lib/models/proto/`) so import surface is equivalent.

**Test scenarios:**
- Happy path: `buf generate` produces `gen/dart/lib/*.pb.dart` that compiles under `dart analyze` in `gen/dart`.
- Edge case: proto3 `optional` fields generate without error (mirrors firmware's `--experimental_allow_proto3_optional` need).

**Verification:**
- `buf lint` passes on the 2 existing protos; `buf generate` output committed and `dart analyze` clean in `gen/dart`.

### U2. PR CI workflow (lint + breaking + drift check)

**Goal:** Gate PRs on buf lint, buf breaking vs `main`, and generated-Dart-in-sync.

**Requirements:** R1, R2

**Dependencies:** U1

**Files:**
- Create: `.github/workflows/ci.yml`

**Approach:**
- Jobs: `lint` (`buf lint`), `breaking` (`buf breaking --against 'https://github.com/ScoutSportTechnology/sst-cam-proto.git#branch=main'`), `codegen-drift` (`buf generate` then `git diff --exit-code gen/dart`).
- Trigger: PR + push to `main`. These job names become the `required_status_checks` (U5).

**Test scenarios:**
- Test expectation: none — CI config; validated by a trial PR run (one passing, one intentionally-breaking change confirmed to fail `breaking`, one stale-codegen PR confirmed to fail `codegen-drift`).

**Verification:**
- A PR with a breaking proto change fails `breaking`; a PR that edits a proto without regenerating fails `codegen-drift`; a clean PR is green.

### U3. release-please (autotag + version management)

**Goal:** Conventional-commit-driven semver releases that keep `gen/dart/pubspec.yaml` version in lockstep.

**Requirements:** R3, R4

**Dependencies:** U1

**Files:**
- Create: `release-please-config.json` (release-type `simple`, `extra-files` → `gen/dart/pubspec.yaml`)
- Create: `.release-please-manifest.json`
- Create: `.github/workflows/release.yml` (release-please action, runs on push to `main`)

**Approach:**
- release-please opens/maintains a release PR; merging it bumps version, updates `pubspec.yaml` version via the generic updater, tags `vX.Y.Z`, cuts the Release.
- Auth via the **org GitHub App** token (see Risks & Dependencies), not `GITHUB_TOKEN`.

**Test scenarios:**
- Test expectation: none — release automation; validated by a dry-run release PR producing the correct version bump and a matching `pubspec.yaml` version.

**Verification:**
- Merging a `feat:`-bearing release PR creates `vX.Y.Z`, a GitHub Release, and `gen/dart/pubspec.yaml` version == tag.

### U4. Release regeneration safeguard

**Goal:** Guarantee the tagged commit contains freshly generated Dart matching the protos.

**Requirements:** R4

**Dependencies:** U2, U3

**Files:**
- Modify: `.github/workflows/release.yml` (pre-tag regenerate step, or rely on U2 drift gate on the release PR)

**Approach:**
- Because the release PR is a normal PR, U2's `codegen-drift` job already runs on it — so the tagged merge commit is guaranteed in-sync. This unit documents that guarantee and adds a belt-and-suspenders `buf generate` + diff assertion in the release job. No separate regenerate-and-commit dance needed.

**Test scenarios:**
- Integration: tagging from a release PR that passed `codegen-drift` yields a tag whose `gen/dart` matches `buf generate` output.

**Verification:**
- Checkout of `vX.Y.Z` + `buf generate` produces no diff.

### U5. Branch & tag governance

**Goal:** Apply the shared rulesets and wire the App as bypass actor + CI as required checks.

**Requirements:** R2

**Dependencies:** U2

**Files:**
- Reference (org/repo settings, not committed code): branch ruleset on `main`, tag ruleset `v*`.

**Approach:**
- Branch ruleset: PR required, 1 approval, dismiss stale, thread resolution, block force-push/delete; `required_status_checks` = `lint`, `breaking`, `codegen-drift` (U2 job names).
- Tag ruleset: semver regex, immutable; bypass actors = `OrganizationAdmin` + org GitHub App, **added via GitHub UI** (string `actor_id` in JSON import fails — origin firmware repo hit exactly this).

**Test scenarios:**
- Test expectation: none — repo settings; validated by attempting a direct push to `main` (blocked) and a non-semver tag (blocked).

**Verification:**
- Direct push to `main` rejected; `buf` checks required before merge; only the App/admin can push `v*` tags.

---

## System-Wide Impact

- **Interaction graph:** app build switches to depend on `gen/dart` at a tag (see app plan U2); firmware build untouched (submodule).
- **API surface parity:** the Dart barrel export must cover every message the app uses today (currently `BleServiceImpl`).
- **Unchanged invariants:** `.proto` package `sst_cam`, firmware submodule path `proto/`, and firmware host-protoc codegen all remain.

---

## Risks & Dependencies

| Risk | Mitigation |
|------|------------|
| Org GitHub App not yet created (shared prerequisite) | Block release wiring (U3) until an org admin creates + installs the App on all 3 repos and stores its token/app-id as repo secrets. |
| `protoc-gen-dart` via buf differs from app's current `protoc_plugin` output | Pin plugin version; U1 verifies generated output compiles and U2 keeps app+proto in sync. |
| Committed generated code drifts from protos | U2 `codegen-drift` job fails PRs that forget to regenerate. |
| buf lint fails the existing protos en masse | U1 documents and minimally disables offending rules rather than rewriting protos under time pressure. |

---

## Sources & References

- **Origin document:** docs/brainstorms/ci-cd-release-pipeline-requirements.md
- Related code: `bluetooth.proto`, `wifi.proto`, `sst-cam-app/justfile` (`gen-proto`), `sst-cam-firmware/CMakeLists.txt` (proto codegen)
- Cross-repo plans: `sst-cam-app/docs/plans/2026-06-10-001-feat-ci-cd-release-pipeline-plan.md`, `sst-cam-firmware/docs/plans/2026-06-10-001-feat-ci-cd-release-pipeline-plan.md`
