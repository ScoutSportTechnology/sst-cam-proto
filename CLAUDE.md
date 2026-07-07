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
| `bluetooth.proto` | All BLE control schema — framing (`ChunkedPayload`/`ChunkAck`), `Command`/`CommandResponse` envelopes, telemetry (incl. per-camera health), match events, recording/streaming, session push, session snapshot / reconnect handshake, WiFi Direct handshake |
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
  The reconnect handshake (state-health cycle) is app-initiated and fits the pull
  model: protocol gate → `SetDeviceTime` → `GetSessionSnapshot` → rehydrate →
  reconcile via absolute `SetMatchState`. Canonical order documented in
  `bluetooth.proto` §9b and README — both consumers implement it identically.
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
  the commit type must match what `buf breaking` reports. The `breaking` check
  (`scripts/ci/breaking-gate.sh`) enforces it: a wire break passes only when the
  **PR title** declares it (`type!:` / `type(scope)!:`), because the title is
  what lands on the branch (squash subject or merge-commit body). Editing the
  title re-runs the check.
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
there is no build output to publish). Same model in all three sst-cam repos
(proto, firmware, app); **levels are tags, not branches**:

| Branch | Lives | Receives | Tag minted |
|---|---|---|---|
| `development` | long, default | `feat/*`, `fix/*` PRs | `vX.Y.Z-alpha.N` on each releasable merge |
| `release/X.Y.Z` | until X.Y.Z ships | cut from `development` at feature freeze, then `fix/*` PRs only | `vX.Y.Z-beta.N`; `vX.Y.Z-rc.N` once promoted to rc |
| `main` | long | only `release/X.Y.Z` (and `hotfix/*`) | `vX.Y.Z` by promotion, no rebuild |
| `feat/*`, `fix/*`, `hotfix/*` | short, deleted after merge | | |

Levels:

- **alpha** — construction on `development`; the contract validated by `lint` +
  `breaking` + `build` *in isolation*.
- **beta** — feature freeze for X.Y.Z on `release/X.Y.Z`; fixes only. Firmware +
  app vendor the beta and prove it in integration.
- **rc** — after the hardware test (flash a real Jetson, test end to end with the
  app). `promote-rc.yml` re-tags the newest beta as `vX.Y.Z-rc.1` on the **same
  commit**; later merges to `release/X.Y.Z` mint `rc.N`.
- **stable** — merging `release/X.Y.Z → main` promotes the last rc to `vX.Y.Z`
  (same commit). Then delete `release/X.Y.Z` and PR `main → development`.
- **hotfix** — `hotfix/X.Y.Z+1` from `main` → PR to `main` → `vX.Y.(Z+1)` →
  PR `main → development`.

Version math lives in the shared actions of
[`ScoutSportTechnology/.github`](https://github.com/ScoutSportTechnology/.github)
(`docs/release-actions.md` there), pinned by exact tag (`@v1.1.0`):

- **Alpha base** = the higher of the Conventional-Commit bump from the latest
  stable tag (`v0.0.0` when none) and the **release floor**: while a release
  `X.Y.Z` is open (beta/rc tags, no stable, `release/X.Y.Z` branch exists),
  `development` builds `X.(Y+1).0`.
- **Pre-1.0:** a breaking change bumps the minor while the major is 0; `1.0.0`
  is cut on purpose (dispatch `bump: major`).
- **Breaking** = `type!:`, `type(scope)!:` or a `BREAKING CHANGE:` footer. Write
  `feat(scope)!:`, not `feat!(scope):`.
- **Mint gate:** an alpha is minted only if a `feat`/`fix`/`perf`/breaking commit
  landed since the last tag on `development`; docs/chore-only merges mint nothing.

Workflows (the PR gate checks are folded into the alpha/beta workflows, gated to
`pull_request`):

- `.github/workflows/release-alpha.yml` (name `release-alpha`) — **owns
  `development`**. On `pull_request:[development]` runs the gate: jobs `lint`
  (`buf lint`), `breaking` (`buf breaking` vs `main`, the last released contract),
  `build` (`buf build` compile-smoke). On `push:[development]` (+ dispatch with
  optional `version`/`bump`) → `resolve-version` (`mode: alpha`) →
  `publish-release` → `vX.Y.Z-alpha.N` **prerelease**, **no asset**.
- `.github/workflows/release-beta.yml` (name `release-beta`) — **owns
  `release/**`**. Same gate on PRs. On `push:[release/**]` (+ dispatch) →
  `resolve-version` (`mode: release`, X.Y.Z from the branch name) →
  `vX.Y.Z-beta.N`, or `rc.N` once the rc phase started — **no asset**.
- `.github/workflows/promote-rc.yml` (name `promote-rc`) — `workflow_dispatch`
  on `release/X.Y.Z` after the hardware sign-off: newest beta → `rc.1`.
- `.github/workflows/release.yml` (name `release`) — **owns `main`**. On
  `push:[main]` (+ dispatch) → `promote` (`to: stable`): highest `vX.Y.Z-rc.N` →
  `vX.Y.Z`; fails if there is no rc. No checks, no build, no asset.

The gate job names (`lint`/`breaking`/`build`) are the required status checks of
the branch rulesets — keep them byte-identical. All workflows use the default
`GITHUB_TOKEN` (tagging is `contents: write`; the "Release Tags" ruleset permits
compliant `v*` tags and forbids moving/deleting them). The org blocks
Actions-created PRs, so `pr_comment: false` and no release-please.

Two **one-time maintainer runbooks** (not run by CI): `docs/ci/rulesets.md`
(branch + tag rulesets) and `docs/ci/version-reset-runbook.md` (history of the
`0.1.0-alpha` seed).

### How consumers pin a version (submodule)

Both app and firmware embed this repo as a git submodule at `proto/`. A submodule
records a commit: pin it to a **merged** proto commit (squash merges change the
SHA — never pin a `feat/*` commit), ideally a tag's commit, and bump deliberately.
The app and firmware CI fail if `proto/` is not reachable from the proto branch
with the same name as their PR base (`development` or `release/X.Y.Z`).

```bash
cd proto && git fetch --tags && git checkout v0.1.0-alpha.8 && cd ..
git add proto && git commit -m "chore(proto): pin contract to v0.1.0-alpha.8"
```

A breaking proto change forces the same bump level in both consumers (see the
bump-encodes-wire-compatibility rule above).

### Branch + commit + tag rules

- `development` is the default branch and the target for `feat/*`/`fix/*`.
  `main` and `release/*` are PR-only (no direct push); `main` needs 1 approval
  (admin bypass) and green checks.
- One `release/X.Y.Z` open at a time; cut it from `development` at feature
  freeze. A merge to `development` means "ships in the next cut" — unfinished
  work stays in `feat/*`.
- A cross-repo change uses the **same `feat/<slug>` name** in every repo it
  touches. Order: proto first, then firmware and app re-pin `proto/` to the
  merged proto commit and merge close together.
- Tags `v*` are immutable SemVer (no delete/move/force-push); only workflows
  create them.
- Use Conventional Commits; the squash-merge subject drives the version.

## Release lifecycle

```
development:   alpha.1 → alpha.2 → alpha.3
                                     │ cut release/0.1.0 (feature freeze)
release/0.1.0:                       └► beta.1 → beta.2 ─► promote-rc ─► rc.1 → rc.2
                                                         (hardware OK)          │ merge → main
main:                                                                           └► v0.1.0
```

1. Land `feat:`/`fix:` PRs into `development` → `vX.Y.Z-alpha.N`.
2. Feature freeze: `git switch -c release/X.Y.Z development && git push` (same
   X.Y.Z in all three repos) → `vX.Y.Z-beta.1`; fixes by PR → `beta.N`.
3. Hardware test passes → run `promote-rc` on `release/X.Y.Z` in each repo →
   `rc.1`; further fixes → `rc.N`.
4. PR `release/X.Y.Z → main`, merge → `release.yml` tags `vX.Y.Z` from the last
   rc. Delete `release/X.Y.Z`, PR `main → development`.

After `v0.1.0` stable exists, the next `feat:` on `development` bumps from it →
`v0.2.0-alpha.1` (a `fix:` → `v0.1.1-alpha.1`).

## Documented solutions

`docs/solutions/` — past contract-evolution learnings (cross-stack drift, the
`optional`-plus-default pattern, multi-repo orchestration) with YAML frontmatter
(`module`, `tags`, `problem_type`). Read the relevant one before amending the
contract or debugging app↔firmware divergence. `docs/brainstorms/` and
`docs/plans/` hold requirements and plans behind the current shape.
