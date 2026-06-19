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

### The bump encodes wire compatibility

This repo is the org's source of truth for "breaking", so the SemVer bump on
the release **must classify wire compatibility** — consumers rely on it to tell
a safe contract change from a dangerous one:

- **breaking** (remove/rename/renumber a field) → **major** (once past `1.0.0`).
  Commit must be `feat!:` / carry `BREAKING CHANGE`. `buf breaking` (run in
  the alpha/beta gate vs `main`, the last released contract) is the automated classifier;
  the commit type must match what `buf breaking` reports.
- **additive** (new optional field/message) → **minor** (`feat:`).
- **non-breaking fix** → **patch** (`fix:` / `perf:`).
- docs/chore/ci/test/refactor-only → **no release**.

## Regenerating bindings

This repo holds no generated code — consumers generate their own:

- **App (Dart):** `just gen-proto` inside its devcontainer (`protoc` +
  `protoc_plugin 21.1.2`, pinned to `protobuf: 3.1.0`).
- **Firmware (C++):** generated in its own build.

After any `.proto` edit, regenerate in **both** consumers and run their suites —
a contract change isn't done until both stacks build against it.

## CI/CD & releasing

PR-gated, Conventional-Commit driven, **artifact-free** (the tag IS the release;
there is no build output to publish). Branch model:
`feat/* → develop → release/X.Y.Z → main`. Contract **maturity ladder**:

- **alpha** — the contract validated by `lint` + `breaking` + `build` *in
  isolation* on `develop`.
- **beta** — the candidate proven against the **real consumers** (firmware +
  app) in integration off a `release/X.Y.Z` branch.
- **stable** — shipped on promotion to `main`.

Tag scheme: `vX.Y.Z-alpha.N` (develop) → `vX.Y.Z-beta.N` (release/*) →
`vX.Y.Z` (main). Version math lives in `scripts/ci/resolve-version.sh` (unit-
tested via `resolve-version-test.sh`).

Three branch-scoped workflows (no standalone `ci.yml` — the PR gate checks are
folded into the alpha/beta workflows, gated to `pull_request`):

- `.github/workflows/release-alpha.yml` (name `release-alpha`) — **owns
  `develop`**. On `pull_request:[develop]` runs the gate: jobs `lint` (`buf
  lint`), `breaking` (`buf breaking` vs `main`, the last released contract),
  `build` (`buf build` compile-smoke). On `push:[develop]` (+ dispatch) runs
  `resolve-version.sh alpha`; on a releasable bump, cuts `vX.Y.Z-alpha.N` as a
  **prerelease** Release — **no asset**. No language codegen — consumers vendor
  the submodule and generate their own bindings.
- `.github/workflows/release-beta.yml` (name `release-beta`) — **owns
  `release/**`**. On `pull_request` into `release/*` runs the same
  `lint`/`breaking`/`build` gate. On `push:[release/**]` (+ dispatch) takes base
  `X.Y.Z` from the branch name, runs `resolve-version.sh beta`, cuts
  `vX.Y.Z-beta.N` **prerelease** — **no asset**. The beta commit is what
  firmware + app vendor for integration.
- `.github/workflows/release.yml` (name `release`) — **owns `main`**. On
  `push:[main]` (+ dispatch) asserts a `vX.Y.Z-beta.*` candidate exists (fail
  fast otherwise), then `resolve-version.sh stable` cuts `vX.Y.Z` — **no checks,
  no build, no asset**. `main` never builds (structural here: this repo has no
  artifact).

The gate job names (`lint`/`breaking`/`build`) are unchanged from the prior
split-out `ci.yml`, so branch-protection rulesets are unaffected.

All use the default `GITHUB_TOKEN` (tagging is `contents: write`; the "Release
Tags" ruleset permits creating compliant `v*` tags). The org blocks
Actions-created PRs, so `pr_comment: false` and no release-please.

Two **one-time maintainer runbooks** (not run by CI): `docs/ci/rulesets.md`
(branch + tag rulesets) and `docs/ci/version-reset-runbook.md` (delete the bogus
`v0.1.0`, seed the `0.1.0-alpha` line; `0.1.0-beta.1` is the joint firmware+app
beta target; `1.0.0` is the first stable contract).

### How consumers pin a version (submodule)

Both app and firmware embed this repo as a git submodule at `proto/`. A submodule
records a commit, so pin it to a tag's commit and bump deliberately. Consumers
can pin a `-beta.N` for integration and a stable `vX.Y.Z` for release:

```bash
cd proto && git fetch --tags && git checkout v0.1.0-beta.1 && cd ..   # integration
git add proto && git commit -m "chore(proto): pin contract to v0.1.0-beta.1"
```

A proto **major** bump forces a major in both consumers (see the bump-encodes-
wire-compatibility rule above).

### Branch + commit + tag rules

- `develop` is the default branch and the target for `feat/*`/`fix/*`. `main`
  and `release/*` are protected: no direct push; PR + 1 approval + green
  `lint`/`breaking`/`build` to merge (admin/hotfix bypass on `main`).
- Tags `v*` are immutable SemVer (no delete/move/force-push).
- Use Conventional Commits. The merge subject's type drives the bump
  `resolve-version.sh` computes — a non-conventional subject cuts no alpha.
- **Push to `main` does NOT auto-cut a fresh release** — `release.yml` only
  promotes a beta-validated candidate to its stable tag.

### Releasing

1. Land `feat:`/`fix:` PRs into `develop` → `release-alpha.yml` mints
   `vX.Y.Z-alpha.N` (its PR gate ran `lint`/`breaking`/`build` first).
2. Cut `release/X.Y.Z` from `develop` → `release-beta.yml` mints
   `vX.Y.Z-beta.N`; firmware + app vendor it and sign off.
3. PR `release/X.Y.Z → main` (green `lint`/`breaking`/`build`) → `release.yml`
   mints stable `vX.Y.Z`.
- A breaking schema change is `feat!:`/`BREAKING CHANGE` (major), coordinated
  with both consumers (see versioning above).

## Release lifecycle

The version ladder is driven by **which branch you push to**, not by counters. Tags climb `vX.Y.Z-alpha.N` (develop) → `vX.Y.Z-beta.N` (release/*) → `vX.Y.Z` (main); the math lives in `scripts/ci/resolve-version.sh`.

**Alpha — automatic, every `develop` merge.** `release-alpha.yml` runs `resolve-version.sh alpha`: the base is a Conventional-Commit bump from the latest *stable* tag (or from `v0.0.0` when none exists), and `-alpha.N` increments per merge.

```
feat A → develop   →  v0.1.0-alpha.1
feat B → develop   →  v0.1.0-alpha.2
feat C → develop   →  v0.1.0-alpha.3
```

With no stable tag yet, a `feat:` yields base `0.1.0` (a `feat!:`/`BREAKING CHANGE` → `1.0.0`; a `fix:`-only → `0.0.1`); docs/chore-only mints nothing.

**Beta — when you cut the release branch.** Manually branch `release/X.Y.Z` off `develop` and push it; `release-beta.yml` runs `resolve-version.sh beta X.Y.Z` (base = the branch name):

```
git switch -c release/0.1.0 develop && git push   →  v0.1.0-beta.1
```

Each subsequent push to that branch bumps the beta counter — `-beta.2`, `-beta.3`, … This is the rung the **real consumers (firmware + app) vendor and validate in integration**. Alpha and beta are independent counters.

**Stable — when you merge `release/X.Y.Z → main`.** Pushing the branch *creates* the betas; **merging it to `main` promotes the latest beta to stable.** `release.yml` auto-selects the highest `vX.Y.Z-beta.N`, then tags `vX.Y.Z` and creates the stable Release — artifact-free (the tag *is* the release; consumers vendor the commit), no build on `main`.

```
develop:        alpha.1   alpha.2   alpha.3
                                       │ cut release/0.1.0
release/0.1.0:                         └─► beta.1 → beta.2 → beta.3
                                                              │ merge → main
main:                                                         └─► v0.1.0  (stable)
```

After `v0.1.0` stable exists, the next `feat:` on `develop` bumps from the latest stable → `v0.2.0-alpha.1` (a `fix:` → `v0.1.1-alpha.1`). The alpha base climbs only once a stable is cut.

## Documented solutions

`docs/solutions/` — past contract-evolution learnings (cross-stack drift, the
`optional`-plus-default pattern, multi-repo orchestration) with YAML frontmatter
(`module`, `tags`, `problem_type`). Read the relevant one before amending the
contract or debugging app↔firmware divergence. `docs/brainstorms/` and
`docs/plans/` hold requirements and plans behind the current shape.
