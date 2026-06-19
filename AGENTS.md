# AGENTS.md

Agent-facing guide for **sst-cam-proto** — the single source of truth for the
SST Cam wire contract (proto3 schemas + normative rendering semantics), consumed
as a git submodule (`proto/`) by `sst-cam-app` and `sst-cam-firmware`.
See `CLAUDE.md` for the full contract invariants; this file is the
CI/CD + workflow quick-reference.

## Non-negotiables

- **Artifact-free.** There is no build output. The **tag IS the release**;
  consumers vendor the submodule and pin a tag's commit. Never reintroduce an
  SDK/package artifact (the Dart SDK was deliberately dropped).
- **The bump encodes wire compatibility.** This repo is the org's source of
  "breaking": breaking (remove/rename/renumber a field) → `feat!:`/`BREAKING
  CHANGE` → **major** (past `1.0.0`); additive → `feat:` → **minor**;
  non-breaking fix → `fix:`/`perf:` → **patch**. `buf breaking` (vs `main`) is
  the automated classifier and the commit type must match it.

## Branch model

`feat/* → develop → release/X.Y.Z → main`. `develop` is the default branch and
the target for `feat/*`/`fix/*`. `main` and `release/*` are PR-only (no direct
push; green `lint`/`breaking`/`build`; admin/hotfix bypass on `main`).

## Maturity ladder & tags

| Rung | Trigger | Tag | What it means |
| ---- | ------- | --- | ------------- |
| alpha | push to `develop` | `vX.Y.Z-alpha.N` | `buf lint`+`buf breaking`+`buf build` pass in isolation |
| beta | push to `release/X.Y.Z` | `vX.Y.Z-beta.N` | proven against real consumers (firmware + app) |
| stable | merge to `main` | `vX.Y.Z` | shipped — no build, no asset |

## Workflows

Three branch-scoped workflows; there is no standalone `ci.yml` — the PR gate
checks (`lint`, `breaking`, `build`) are folded into the alpha/beta workflows,
gated to `pull_request`. Same job names, so rulesets are unchanged.

- `release-alpha.yml` (name `release-alpha`) — owns `develop`. On
  `pull_request:[develop]` runs `lint`/`breaking`/`build`. On `push:[develop]`
  (+ dispatch) → `resolve-version.sh alpha` → `vX.Y.Z-alpha.N` prerelease, no
  asset.
- `release-beta.yml` (name `release-beta`) — owns `release/**`. On
  `pull_request` into `release/*` runs the same gate. On `push:[release/**]`
  (+ dispatch) → base from branch name → `vX.Y.Z-beta.N` prerelease, no asset.
- `release.yml` (name `release`) — owns `main`. On `push:[main]` (+ dispatch) →
  assert a `vX.Y.Z-beta.*` exists → `vX.Y.Z` stable, no checks, no build, no
  asset. **Push to `main` does NOT auto-cut a fresh release** — it only
  promotes a beta-validated candidate. `main` never builds.

Version math: `scripts/ci/resolve-version.sh` (modes `alpha|beta|stable`),
tested by `scripts/ci/resolve-version-test.sh`. All workflows use the default
`GITHUB_TOKEN`.

## One-time maintainer runbooks (not run by CI)

- `docs/ci/rulesets.md` — branch + tag rulesets (`develop`/`main`/`release/*`,
  immutable `v*` tags).
- `docs/ci/version-reset-runbook.md` — delete the bogus `v0.1.0`, seed
  `0.1.0-alpha`; `0.1.0-beta.1` is the joint firmware+app beta target; `1.0.0`
  is the first stable contract.

## Consumer pinning

```bash
cd proto && git fetch --tags && git checkout v0.1.0-beta.1 && cd ..
git add proto && git commit -m "chore(proto): pin contract to v0.1.0-beta.1"
```

Pin a `-beta.N` for integration, a stable `vX.Y.Z` for release. A proto major
forces a major in both consumers.
