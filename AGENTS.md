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
  the automated classifier and the commit type must match it: the `breaking`
  check (`scripts/ci/breaking-gate.sh`) passes a wire break only when the PR
  title declares it (`type!:` / `type(scope)!:`).

## Branch model

`feat/* → development → release/X.Y.Z → main` (Git Flow; levels are tags, not
branches). `development` is the default branch and the target for
`feat/*`/`fix/*`. `release/X.Y.Z` is cut from `development` at feature freeze
and takes fixes only; `main` takes only `release/X.Y.Z` (and `hotfix/*`). One
release branch open at a time; same branch names across proto, firmware and
app. `main` and `release/*` are PR-only.

## Maturity ladder & tags

| Rung | Trigger | Tag | What it means |
| ---- | ------- | --- | ------------- |
| alpha | push to `development` | `vX.Y.Z-alpha.N` | `buf lint`+`buf breaking`+`buf build` pass in isolation |
| beta | push to `release/X.Y.Z` | `vX.Y.Z-beta.N` | feature freeze; proven against real consumers (firmware + app) |
| rc | `promote-rc` (hardware OK), then pushes to `release/X.Y.Z` | `vX.Y.Z-rc.N` | hardware-validated candidate |
| stable | merge `release/X.Y.Z` to `main` | `vX.Y.Z` | last rc promoted — no build, no asset |

## Workflows

The PR gate checks (`lint`, `breaking`, `build`) are folded into the alpha/beta
workflows, gated to `pull_request`; keep the job names byte-identical (rulesets).

- `release-alpha.yml` — owns `development`: PR gate; on push →
  `resolve-version` (`mode: alpha`) → `publish-release` → alpha prerelease.
- `release-beta.yml` — owns `release/**`: PR gate; on push →
  `resolve-version` (`mode: release`) → beta.N or rc.N prerelease.
- `promote-rc.yml` — dispatch on `release/X.Y.Z`: newest beta → `rc.1`.
- `release.yml` — owns `main`: `promote` (`to: stable`) last rc → `vX.Y.Z`.

Version math lives in the shared actions of `ScoutSportTechnology/.github`
(`resolve-version`, `publish-release`, `promote`, pinned `@v1.1.0`): alpha base
= max(Conventional-Commit bump from the last stable, release floor while a
`release/X.Y.Z` is open); breaking bumps the minor while major is 0. All
workflows use the default `GITHUB_TOKEN`.

## One-time maintainer runbooks (not run by CI)

- `docs/ci/rulesets.md` — branch + tag rulesets (`development`/`main`/`release/*`,
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
