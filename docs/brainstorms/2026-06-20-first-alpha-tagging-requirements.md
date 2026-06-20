# First `v0.1.0-alpha.1` Tagging — Requirements

**Date:** 2026-06-20
**Scope:** Cross-repo release-ops (sst-cam-app, sst-cam-proto, sst-cam-firmware)
**Status:** Requirements — ready for execution

## Problem

We want the first `v0.1.0-alpha.1` cut across the three shipping repos and a
changelog to track work toward release. A pre-flight review surfaced that the
release machinery is sound and aligned, but the **content path to a first tag**
is incomplete for app + firmware, and there are stale-tag cleanups to do first.

## Current state (verified 2026-06-20)

| Repo | alpha tags (remote) | `resolve-version.sh` | proto submodule pin |
| --- | --- | --- | --- |
| sst-cam-proto | `alpha.1`–`alpha.4` (on docs commits — seeded) | `717f36f8` | n/a |
| sst-cam-app | none | `717f36f8` (identical) | `b6dc87c` (raw commit) |
| sst-cam-firmware | none | `717f36f8` (identical) | `b6dc87c` (raw commit) |

Aligned + healthy: `resolve-version.sh` is byte-identical across all three (brick
fix present everywhere), all three release workflows present, `development` in
sync with `origin`, clean working trees.

Two repo-local stale tags: app and firmware each carry a **local-only** `v0.1.0`
tag inside their `proto/` submodule checkout (`→ 485eac3`); it is **not** on
proto's remote and is the bogus tag `docs/ci/version-reset-runbook.md` says to
delete. It is why `git submodule status` shows `(v0.1.0~1)`.

## Decisions

- **Changelog form: GitHub per-tag auto release-notes only.** The release
  workflows already cut each tag with `--generate-notes`; that is the record of
  work per release. No committed `CHANGELOG.md`, no changelog tooling.
- **First-alpha mint (app + firmware): seed via `IN_VERSION=v0.1.0`
  `workflow_dispatch`** on `release-alpha`, which deterministically cuts
  `v0.1.0-alpha.1` on a clean repo regardless of the commit scan. Matches how
  proto was seeded.
- **Leave proto's `alpha.1`–`alpha.4` as-is.** Tags are immutable (ruleset: no
  delete/move without admin bypass) and alpha counters are **per-repo
  independent**; the ladder converges at `release/0.1.0 → v0.1.0-beta.1`, the
  joint firmware+app target. proto being counter-ahead is not a real
  misalignment.

## Success criteria

1. app and firmware each have a `v0.1.0-alpha.1` tag + GitHub prerelease, cut by
   their own `release-alpha` workflow.
2. The bogus local `v0.1.0` tag is gone from both `proto/` submodule checkouts.
3. app + firmware `proto/` submodule is pinned to a **released** proto tag
   (`v0.1.0-alpha.4` now; re-pin to `v0.1.0-beta.1` at integration) rather than a
   raw commit.
4. Each seeded prerelease's auto-generated notes render legibly.

## Runbook (execution order)

**A. Pre-flight cleanup (local)**
1. `git -C sst-cam-app/proto tag -d v0.1.0`
2. `git -C sst-cam-firmware/proto tag -d v0.1.0`
   (Local-only deletes; remote is unaffected and already clean.)

**B. Re-pin consumers to a released proto tag** (per repo: app, firmware)
3. `cd proto && git fetch --tags && git checkout v0.1.0-alpha.4 && cd ..`
4. `git add proto && git commit -m "chore(proto): pin contract to v0.1.0-alpha.4"`
   then PR into `development`.

**C. Seed first alpha** (per repo: app, firmware)
5. `workflow_dispatch` `release-alpha` with `IN_VERSION=v0.1.0` →
   cuts `v0.1.0-alpha.1` prerelease.
6. proto: no action — already at `alpha.4`.

**D. Verify**
7. Confirm each `release-alpha` run succeeded, the prerelease exists, the tag is
   on `origin`, and `--generate-notes` output is clean.

## Open questions / risks

- **proto alpha provenance:** `alpha.1`–`alpha.4` point at docs commits, which
  per the ladder rules (`docs/chore → mint nothing`) should not mint. Confirm
  they were intentionally seeded (accept, immutable) vs the resolver minting on
  non-releasable merges (would be a latent bug worth a separate investigation).
- **Seed collision:** app/firmware have no remote alphas, so `alpha.1` is free —
  no collision. The local bogus `v0.1.0` does not affect CI (clean checkout).
- **Ordering:** B (re-pin) lands a `chore:` PR — non-releasable, so it will not
  itself mint an alpha, leaving C's `IN_VERSION` seed deterministic.

## Out of scope

Changelog tooling (git-cliff etc.), resetting proto's alpha line, proto
resolver internals, the `beta.1` joint-integration cut (separate milestone).
