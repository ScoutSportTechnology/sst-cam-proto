---
title: "CI/CD release pipeline: conventional-commit auto-release on GITHUB_TOKEN (proto)"
date: 2026-06-15
category: tooling-decisions
module: ci-cd
problem_type: tooling_decision
component: tooling
severity: medium
applies_when:
  - "Setting up or changing GitHub Actions CI/CD for this repo"
  - "An org policy blocks Actions from creating/approving PRs"
  - "Deciding how proto is versioned and consumed by app + firmware"
tags: [ci-cd, github-actions, release, conventional-commits, buf, submodule, protobuf]
related_components: [development_workflow, tooling]
---

# CI/CD release pipeline: conventional-commit auto-release on GITHUB_TOKEN (proto)

## Context

We stood up CI/CD across the three SST Cam repos (proto, app, firmware). The original plan used **release-please** under a **GitHub App** token. Two hard constraints killed that path and shaped the final design — they recur for anyone touching these workflows:

1. The **org disables "Allow GitHub Actions to create and approve pull requests"** org-wide. Changing it needs the `admin:org` scope (our `gh` token lacks it). So `GITHUB_TOKEN` cannot open release-please's release PR — release-please is unusable here.
2. A **GitHub App** was attempted (manifest-flow via a local server) but the manifest flow failed repeatedly and the App buys nothing at this scale. Abandoned.

This doc captures the resulting proto pipeline + the cross-cutting decisions. (The same CI/CD section lives in each repo's `CLAUDE.md`; this is the first systematic capture in `docs/solutions/`.)

## Guidance

**Two workflows, one job per phase. No release-please, no GitHub App, no PAT — default `GITHUB_TOKEN` only.**

- `.github/workflows/ci.yml` — triggers on **`pull_request` only** (not `push: main`, which would double-run). proto's required status checks: `lint` (`buf lint`) + `breaking` (`buf breaking` vs `main`). No codegen in CI — proto ships only the `.proto` contract.
- `.github/workflows/release.yml` — triggers on **`push: main`** (a merge) + `workflow_dispatch` (manual override). A `tag-release` job scans Conventional Commits since the last `vX.Y.Z` tag and bumps: `feat:` → minor, `fix:`/`perf:` → patch, `BREAKING CHANGE`/`type!:` → major, docs/chore/ci/test/refactor-only → **skip (no release)**. It creates the tag + GitHub Release with `gh release create --generate-notes`. proto ships **no build artifact — the tag IS the release.**

**Why GITHUB_TOKEN is enough:** creating a tag/release is `contents:write` (allowed). The "Release Tags" ruleset only blocks `deletion`/`update`/`non_fast_forward` and enforces the `v*` semver name — it does **not** block *creating* a compliant tag. So no bypass actor / App is needed. The recursion guard (GITHUB_TOKEN-created events don't trigger other workflows) is sidestepped by **chaining** the build into the release workflow (gated on the bump decision) rather than a separate `release:`-triggered workflow.

**proto is submodule-only.** Both app and firmware vendor proto as a git submodule at `proto/` and generate their own bindings (Dart via protoc, C++ via CMake). We explored publishing a Dart SDK (committed `gen/dart`) but **dropped it** — neither consumer used it, so it was dead weight. Pin the submodule to a tag's commit deliberately:

```bash
cd proto && git fetch --tags && git checkout v0.2.0 && cd ..
git add proto && git commit -m "chore(proto): bump contract to v0.2.0"
```

## Why This Matters

- **release-please is the obvious default and it does not work in this org.** Anyone who reaches for it will burn time rediscovering the create-PR block. The GITHUB_TOKEN + conventional-commit-scan approach is the working alternative.
- **The squash-merge subject is load-bearing.** `release.yml` reads commits since the last tag to choose the bump; a non-conventional squash subject cuts **no release**. Keep PR squash subjects conventional (`feat:`/`fix:`).
- **Dropping the SDK** keeps proto a pure contract repo: lint + breaking gate the schema, the tag marks versions, consumers own codegen. Less to maintain, no drift between a published package and the source.

## When to Apply

- Editing any of the three repos' `ci.yml` / `release.yml`.
- Wondering why there's no release-please / GitHub App (don't re-add them).
- Bumping the proto contract version in a consumer (use the submodule+tag recipe above).

## Examples

**First-release anomaly (real, will recur):** with **no baseline tag**, the conventional scan ran over full repo history and decided "nothing releasable" → skipped. Worked around by forcing the first release manually:

```bash
gh workflow run release.yml -R ScoutSportTechnology/sst-cam-proto -f bump=minor
```

Once a `v0.1.0` tag exists, the scan range becomes `v0.1.0..HEAD` (just the new squash commit) and auto-detect works normally. So: **seed the first tag manually, then auto-release takes over.**

**Manual release anytime:** `gh workflow run release.yml -f bump=minor` (or `-f version=vX.Y.Z`).

## Related

- `docs/solutions/workflow-issues/overnight-autonomous-multi-repo-orchestration-2026-06-09.md` — submodule coordination + devcontainer testing across the 3 repos (the pipeline that gates those flows).
- `docs/solutions/workflow-issues/folding-git-submodule-onto-feature-branches-2026-06-05.md` — submodule mechanics.
- Sibling captures: `sst-cam-app` and `sst-cam-firmware` each have a repo-specific version of this doc under `docs/solutions/tooling-decisions/`.
- `CLAUDE.md` → "CI/CD & releasing" section (per-repo quick reference).
