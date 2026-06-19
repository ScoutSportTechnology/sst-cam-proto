---
title: "feat: Git + CI/CD workflow standard — sst-cam-proto"
type: feat
status: active
date: 2026-06-17
origin: docs/brainstorms/2026-06-17-cicd-workflow-standard-requirements.md
---

# feat: Git + CI/CD workflow standard — sst-cam-proto

## Summary

Refactor this contract repo into the org-wide SST branch model (`feat/* → develop → release/X.Y.Z → main`) with a maturity ladder adapted for a contract repo (alpha = `buf lint` + `buf breaking` + `buf build` compile-smoke in isolation, beta = the candidate contract proven against real consumers — firmware + app — in integration, stable = shipped). Add SemVer prerelease tags (`vX.Y.Z-alpha.N` on `develop`, `vX.Y.Z-beta.N` on `release/*`, `vX.Y.Z` on `main`), keep the bump **encoding wire compatibility** (this repo is the org's source of "breaking"), and reset the bogus `v0.1.0` tag to a clean `0.1.0-alpha` line. The repo stays **artifact-free** — the tag *is* the release; consumers vendor the submodule and pin a tag's commit. Because there is no build artifact, "`main` never builds" is satisfied structurally; the work is branch model + prerelease tagging + the required-checks split.

---

## Problem Frame

`main` runs `release.yml` that auto-cuts a release on every push — a failable post-merge job, so `main` can hold a contract whose release step broke. There is no integration branch and no prerelease ladder. The single `v0.1.0` tag was auto-cut by the old flow and corresponds to no real, intentional contract release. As the contract every other repo consumes, sloppy versioning here propagates: consumers can't tell a breaking proto change from a safe one. (see origin: docs/brainstorms/2026-06-17-cicd-workflow-standard-requirements.md)

---

## Requirements

- R1. Create a long-lived `develop` branch; default target for `feat/*`/`fix/*`.
- R2. Rulesets: `develop` PR + green checks; `main` PR + green required checks + no direct push (admin/hotfix bypass); `release/*` requires the release checks.
- R3. `main` runs **no failable build/publish job**.
- R4. Rework `ci.yml` to run the contract checks on PRs into `develop` (and `release/*`): `buf lint` + `buf breaking` (compatibility) + `buf build` (codegen-compile smoke). Full contract/roundtrip conformance is *not* run here — it lives in the emulator's shared conformance vectors (see Scope Boundaries). [Origin R4 said "codegen + contract/roundtrip + compatibility-lint"; the roundtrip portion is delegated to the emulator vectors, not dropped.]
- R5. On merge to `develop`, auto-tag `vX.Y.Z-alpha.N` and create a prerelease GitHub Release — **no asset** (artifact-free; the alpha *is* the validated contract at that tag's commit). "Publish" here = the prerelease tag + Release, not an SDK/package upload.
- R6. On `release/X.Y.Z`, tag `vX.Y.Z-beta.N`; betas iterate on the branch.
- R7. Replace `release.yml`'s auto-cut-on-push-to-`main` with the release-branch→main promotion: tag `vX.Y.Z`, no rebuild on `main`.
- R8. Adopt Conventional Commits; the bump **must encode wire compatibility** (breaking → major once past 1.0; additive → minor; non-breaking → patch).
- R9. Delete the bogus `v0.1.0` tag + release; re-establish the clean scheme at `0.1.0-alpha`.
- R10. Consolidate contract work under `0.1.0-alpha.N`; immediate target `0.1.0-beta.1` (consumed by the joint firmware+app beta). `1.0.0` = first stable contract.
- R11. Update `CLAUDE.md`/`AGENTS.md`, `README` to the new model, ladder, tag/version convention, flow, and the breaking-change classification rule. Document how consumers pin a proto version.

**Origin actors:** A1 Contributor, A2 Maintainer/admin, A3 CI, A4 Consumers (firmware submodule + app).
**Origin flows:** F1 Feature→develop (alpha), F2 Cut release candidate (beta), F3 Promote to stable.
**Origin acceptance examples:** AE1 (R1,R4), AE2 (R5,R3), AE3 (R8 — breaking classification), AE4 (R2,R3), AE5 (R7,R3).

---

## Scope Boundaries

- No external-tester cohorts; no nightly.
- No maintenance/backport branches — and because this is the contract, consumers must move to the latest; old proto majors are not maintained.
- Not cutting `1.0.0`.
- **No generated SDK/package artifact** — the repo stays schemas + specs + version tag (see Key Decisions; this resolves the origin doc's "publish SDK" language against the landed submodule-only model).

### Deferred to Follow-Up Work

- Full contract/roundtrip conformance tests: owned by the **emulator** repo's shared conformance vectors (golden proto exchanges both stacks validate against), per `sst-cam-emulator/CLAUDE.md`. Proto CI does the compile-smoke + compatibility-lint; the cross-stack roundtrip lives with the vectors. Not this plan.
- `0.1.0-beta.1` consumer integration sign-off: runs hand-in-hand with the firmware+app beta.

---

## Context & Research

### Relevant Code and Patterns

- `.github/workflows/ci.yml` — `lint` (`buf lint`) + `breaking` (`buf breaking` vs `main`), `pull_request` (all branches). Job names `lint`/`breaking` are wired required checks — keep stable. Retarget triggers; add a `build` (buf compile) job.
- `.github/workflows/release.yml` — `push: [main]` + dispatch; hand-rolled conventional-commit bump → `gh release create` (tag only, no asset). The bump bash (lines 45–91) is the pattern to extract.
- `CLAUDE.md` "CI/CD & releasing" + "How consumers pin a version (submodule)" — the doc surface to update; confirms artifact-free + submodule pinning.

### Institutional Learnings

- **Dart SDK was dropped 2026-06-15**: proto removed `gen/dart/`, `buf.gen.yaml`, the `codegen-drift` CI job; proto is **submodule-only**, both consumers generate their own bindings, and "the tag IS the release." This is the binding precedent — do not reintroduce an SDK artifact. (memory: cicd-pipeline-plan)
- Bump tool = hand-rolled bash (release-please removed). Default `GITHUB_TOKEN`; "Release Tags" ruleset permits compliant tag creation. (memory: cicd-pipeline-plan)
- `buf` runs via `bufbuild/buf-action@v1` with `pr_comment: false` (org blocks Actions PR comments). (ci.yml)

### External References

- SemVer 2.0 prerelease precedence; `git tag --sort=-v:refname`.
- `buf breaking` is the automated wire-compatibility classifier; `buf build` compiles the schema into a FileDescriptorSet (the cheapest "schemas still compile" smoke, no language toolchain).

---

## Key Technical Decisions

- **Stay artifact-free; resolve the "SDK" language against the landed model.** The origin doc speaks of "publish alpha SDK/package," but the SDK was deliberately dropped 2026-06-15 — proto ships only `.proto` + a tag, consumers vendor the submodule. This plan keeps it artifact-free: alpha/beta/stable "publish" = a (pre)release tag + GitHub Release with **no asset**. The beta tag's commit is what firmware+app vendor for integration. (Maintainer-confirmed 2026-06-17: nothing to build or package — proto is tag-only. Settled, not open.)
- **`main` never builds is structural and trivial here.** No build artifact has ever existed; `promote.yml` on `main` only creates the stable tag+Release from the beta-validated commit. Tagging is `contents: write`, not a failable build/publish job.
- **alpha checks = `buf lint` + `buf breaking` + `buf build`.** Keep `lint`/`breaking` job names (wired required checks); add a `build` job (`buf build`) as the "codegen compiles" smoke. `buf breaking` (vs `main`, the last released contract) is the wire-compat classifier behind AE3 — a removed/renumbered field surfaces as breaking, and the commit must be typed `feat!:`/`BREAKING CHANGE` to bump major.
- **Extract `scripts/ci/resolve-version.sh`** (alpha/beta/stable) — same contract as the app/firmware/emulator plans; the prerelease counter math is the one tricky bit.
- **Roundtrip/conformance lives in the emulator's shared vectors**, not proto CI — avoids re-introducing a language runtime here and matches the emulator repo's owned surface.
- **Version reset = one-time maintainer runbook** deleting `v0.1.0` and seeding `0.1.0-alpha`.

---

## Open Questions

### Resolved During Planning

- Where is the SDK/package published? → **Nowhere — confirmed by maintainer 2026-06-17.** There is nothing to build or package; proto is tag-only. The tag *is* the release; consumers vendor the submodule and generate their own bindings (extends the 2026-06-15 SDK-drop decision). The origin doc's "publish SDK/package" language is superseded.
- Is compatibility-lint adopted as the breaking classifier? → Yes, `buf breaking` (already present) is it; the commit type must match (AE3).
- What plays the "codegen succeeds" role without an SDK? → `buf build` compile-smoke.

### Deferred to Implementation

- Whether `promote.yml` automates "delete release branch + merge back to develop" or documents it as a maintainer action.
- `buf breaking` baseline during the alpha cycle: diff against `main` (last released contract) is the default; confirm at implementation whether a develop-relative diff is also wanted.
- Test harness wiring for `resolve-version.sh`.

---

## High-Level Technical Design

> *This illustrates the intended approach and is directional guidance for review, not implementation specification. The implementing agent should treat it as context, not code to reproduce.*

```
feat/* ──PR──► ci.yml [lint · breaking · build(buf)] ──green+review──► develop
develop ──push──► alpha.yml ──► resolve-version.sh alpha ──► tag vX.Y.Z-alpha.N (prerelease Release, NO asset)
develop ──cut──► release/X.Y.Z ──push──► release-beta.yml ──► tag vX.Y.Z-beta.N (prerelease Release, NO asset)
                                            │
                                  firmware + app vendor the beta tag and integrate ──► sign-off
                                            │
release/X.Y.Z ──PR (beta checks green)──► main ──push──► promote.yml ──► tag vX.Y.Z (stable Release, NO asset, NO build)
```

The tag is the deliverable at every rung — consumers pin it via the submodule (`cd proto && git checkout vX.Y.Z && cd .. && git add proto && commit`).

---

## Implementation Units

- U0. **Bootstrap the branch model (prerequisite — do before all other units)**

**Goal:** Create `develop` and make it the default branch so the retargeted workflows and rulesets have a branch to key off.

**Requirements:** R1

**Dependencies:** None — first step; U2, U3, U4, U6, U7 depend on it.

**Files:**
- None (one-time `git` + `gh` operations; documented in `docs/ci/rulesets.md`)

**Approach:**
- Cut `develop` from `main` and push: `git switch -c develop main && git push -u origin develop`.
- Land the new/retargeted workflow files on `develop` first.
- Open one throwaway PR into `develop` so `ci.yml` emits its `lint`/`breaking`/`build` check runs **once** — capture the exact names for U6's `required_status_checks` wiring.
- Flip the GitHub default branch: `gh api repos/:owner/:repo -X PATCH -f default_branch=develop`.
- Strict ordering: bootstrap → first CI run (capture names) → apply rulesets (U6 last).

**Test scenarios:**
- Test expectation: none (one-time git/gh setup) — verification below.

**Verification:** `develop` exists, is the repo default, and a PR into it triggers `lint`/`breaking`/`build`; rulesets applied only after the first run captured check names.

---

- U1. **Add `scripts/ci/resolve-version.sh` + tests (version math)**

**Goal:** One tested script for next alpha/beta/stable tag, encoding wire-compat bump rules.

**Requirements:** R5, R6, R7, R8

**Dependencies:** None

**Files:**
- Create: `scripts/ci/resolve-version.sh`
- Create: `scripts/ci/resolve-version-test.sh` (or `.bats`)

**Approach:** Same contract as the sibling plans — modes `alpha|beta|stable`, conventional-commit base bump from the latest stable tag (`feat!:`/`BREAKING` → major, `feat:` → minor, `fix:`/`perf:` → patch), numeric prerelease counter. Reuse the existing `release.yml` bump bash. Carry forward `release.yml`'s `IN_VERSION`/`IN_BUMP` override inputs so the first post-reset alpha can be seeded deterministically (sidesteps the "No releasable since v0.0.0" full-history-scan anomaly); with no tags + no override, `alpha` bumps from implicit `v0.0.0`.

**Execution note:** Test-first — deterministic given a tag list.

**Patterns to follow:** `release.yml` lines 45–91; `sst-cam-app` U1.

**Test scenarios:**
- Happy path: no stable tags (post-reset) + `feat:`, mode `alpha` → `v0.1.0-alpha.1`. Covers AE2.
- Happy path: `[v0.1.0-alpha.1]` + `feat:` → `v0.1.0-alpha.2`.
- Happy path: mode `beta v0.1.0` → `v0.1.0-beta.1`; with `[v0.1.0-beta.1]` → `v0.1.0-beta.2`.
- Happy path: mode `stable v0.1.0` → `v0.1.0`.
- Edge case: `feat!:`/`BREAKING CHANGE` → major bump base (wire-incompatible). Covers AE3.
- Edge case: docs/chore-only → `released=false` (skip).
- Edge case: numeric precedence `-alpha.10` > `-alpha.9` → `.11`.
- Error path: invalid mode/base → non-zero exit.

**Verification:** Test suite green; correct tag per fixture, including the breaking→major case.

---

- U2. **Retarget `ci.yml` to `develop`/`release/*`; add the `buf build` compile-smoke**

**Goal:** lint + breaking + build gate PRs into the new branches.

**Requirements:** R3, R4

**Dependencies:** U0

**Files:**
- Modify: `.github/workflows/ci.yml`

**Approach:** Scope `on.pull_request.branches` to `[develop, release/**, main]`. **Keep `main` in the PR triggers** (unlike app/firmware): the buf checks are fast and build nothing, so re-running `lint`/`breaking`/`build` directly on the `release/*→main` PR is the simplest way to realize `main`'s required-status-check and AE4 (no "main never builds" tension, since proto has no build artifact). Keep `lint` and `breaking` job names stable (wired required checks); add a `build` job running `buf build` (compile-smoke); `pr_comment: false` retained. `breaking_against` stays the hardcoded `#branch=main` (last released contract) — note this is a git ref, so flipping the *default* branch to `develop` does NOT change the baseline. This means `develop`-PR breaking is checked vs `main` (correct: vs last release), but the cumulative `develop→main` breaking diff is only re-evaluated at the `release/*→main` PR — which the kept `main` trigger now covers.

**Patterns to follow:** existing `ci.yml` buf-action jobs.

**Test scenarios:**
- Happy path: PR `feat/x → develop` → lint + breaking + build run and gate merge. Covers AE1.
- Happy path: PR into `release/0.1.0` → same checks.
- Edge case: PR removing/renumbering a field → `breaking` fails (or, if intended, requires a `feat!:` commit + major bump). Covers AE3.
- Happy path: a `release/*→main` PR triggers `lint`/`breaking`/`build`, directly realizing `main`'s required checks (AE4) with no build artifact involved.

**Verification:** `develop`/`release/*` PRs run lint+breaking+build; `main` PRs don't.

---

- U3. **Add `alpha.yml` — tag + publish alpha on push to `develop`**

**Goal:** Merge to `develop` auto-tags `vX.Y.Z-alpha.N` + creates a prerelease Release (no asset).

**Requirements:** R5, R3, R8

**Dependencies:** U0, U1

**Files:**
- Create: `.github/workflows/alpha.yml`

**Approach:** `on.push.branches: [develop]` + `workflow_dispatch`. `resolve-version.sh alpha`; if `released=true`, `gh release create vX.Y.Z-alpha.N --prerelease --generate-notes` (no asset). `permissions: contents: write`.

**Patterns to follow:** `release.yml` `tag-release` job; add `--prerelease`.

**Test scenarios:**
- Happy path: `feat:` merge to `develop` → `v0.1.0-alpha.1` prerelease tag. Covers AE2.
- Edge case: docs/chore-only merge → skip, green.
- Edge case: second `feat:` merge → `v0.1.0-alpha.2`.
- Integration: no build/asset step exists — confirms R3 (artifact-free).

**Verification:** A `feat:` merge yields a `-alpha.N` prerelease tag; non-releasable merges produce none.

---

- U4. **Add `release-beta.yml` — tag + publish beta on `release/*`**

**Goal:** Pushes to `release/X.Y.Z` tag `vX.Y.Z-beta.N` (prerelease Release, no asset) — the commit firmware+app vendor for integration.

**Requirements:** R6, R3

**Dependencies:** U0, U1

**Files:**
- Create: `.github/workflows/release-beta.yml`

**Approach:** `on.push.branches: [release/**]` + `workflow_dispatch`. Base `X.Y.Z` from branch name; `resolve-version.sh beta X.Y.Z`; `gh release create vX.Y.Z-beta.N --prerelease` (no asset).

**Patterns to follow:** `release.yml` `tag-release` job.

**Test scenarios:**
- Happy path: push to `release/0.1.0` → `v0.1.0-beta.1` prerelease tag. Covers F2.
- Happy path: another push → `v0.1.0-beta.2`.
- Edge case: branch name not matching `release/X.Y.Z` → fail fast.
- Integration: consumers can `git checkout v0.1.0-beta.1` in the submodule.

**Verification:** A `release/0.1.0` push produces a `v0.1.0-beta.N` prerelease tag.

---

- U5. **Add `promote.yml` — tag stable on push to `main` (no build); delete `release.yml`**

**Goal:** `release/X.Y.Z → main` tags `vX.Y.Z` and creates the stable Release — no build, no asset.

**Requirements:** R7, R3

**Dependencies:** U4

**Files:**
- Create: `.github/workflows/promote.yml`
- Delete: `.github/workflows/release.yml`

**Approach:** `on.push.branches: [main]` + `workflow_dispatch`. Derive `X.Y.Z` from the merged `release/X.Y.Z` branch name; assert a `vX.Y.Z-beta.*` tag exists pointing at an ancestor of `$GITHUB_SHA` (the sign-off-approved candidate) and fail fast if none. `resolve-version.sh stable X.Y.Z`; `gh release create vX.Y.Z --generate-notes`. No build, no asset. Document deleting the release branch + merge-back to develop; emit a run-summary reminder if merge-back isn't automated.

**Patterns to follow:** `release.yml` `gh release create`.

**Test scenarios:**
- Happy path: merge `release/0.1.0 → main` → `v0.1.0` stable Release tagged. Covers AE5.
- Edge case: no matching beta tag for the version → fail fast.
- Edge case: workflow contains no build/asset step — assert by inspection. Covers R3.

**Verification:** `main` has zero failable build jobs; stable tag created from the beta-validated commit.

---

- U6. **Branch + tag rulesets for `develop`, `main`, `release/*`**

**Goal:** Enforce the branch model and required checks.

**Requirements:** R1, R2, R3

**Dependencies:** U0, U2, U3, U4, U5

**Files:**
- Modify/Create: `docs/ci/rulesets.md` (intent + `gh api` commands/JSON)

**Approach:** `develop`: PR + green `lint`/`breaking`/`build` (default-branch flip is U0). `main`: PR + green `lint`/`breaking`/`build` (these now run on the `release/*→main` PR because U2 keeps `main` in the triggers — directly realizing AE4) + block direct push/force/delete, admin/hotfix bypass. `release/*`: require the release checks. Keep the immutable "Release Tags" ruleset; confirm it permits `-alpha.N`/`-beta.N`/stable names. Wire `required_status_checks` (add `build` to the existing `lint`/`breaking`) only after U0/U2–U5 run once.

**Execution note:** Capture exact check names from a real run before wiring.

**Test scenarios:**
- Test expectation: none (GitHub config) — verification operational below.

**Verification:** Direct push to `main` rejected; a `release/* → main` PR with red checks blocked (AE4); `develop` is the default branch.

---

- U7. **Version reset to the `0.1.0-alpha` line (runbook)**

**Goal:** Delete the bogus `v0.1.0` tag + release; seed the clean `0.1.0-alpha` line.

**Requirements:** R9, R10

**Dependencies:** U0, U3

**Files:**
- Create: `docs/ci/version-reset-runbook.md`

**Approach:** One-time maintainer steps (admin only). The "Release Tags" ruleset blocks tag deletion, so the bypass is **mandatory, not "if needed"**: (1) admin temporarily disables the "Release Tags" ruleset (or adds self to its bypass list) via the GitHub UI; (2) `gh release delete v0.1.0 --yes --cleanup-tag`; (3) verify `git tag -l 'v*'` shows no `v0.1.0` and no other bogus tags; (4) **re-enable the ruleset immediately**. Precondition (high blast radius — this is the contract repo): confirm no consumer superproject (firmware/app submodule) currently pins `v0.1.0`'s commit before deleting. Then let the first `feat:` develop merge mint `v0.1.0-alpha.1` (or seed via `alpha.yml` dispatch using the `IN_VERSION`/`IN_BUMP` override — see U1). Document `0.1.0-beta.1` (consumed by the joint firmware+app beta) and `1.0.0` as the first stable contract.

**Test scenarios:**
- Test expectation: none (operational runbook) — verification below.

**Verification:** `git tag -l` shows no `v0.1.0`; first develop alpha is `v0.1.0-alpha.1`.

---

- U8. **Docs: rewrite CI/CD section in `CLAUDE.md`, `AGENTS.md`, `README`**

**Goal:** Docs match the new branch model, ladder, tag scheme, flow, and the breaking-change rule; consumer pinning stays documented.

**Requirements:** R11

**Dependencies:** U2, U3, U4, U5, U6

**Files:**
- Modify: `CLAUDE.md` ("CI/CD & releasing", "Changing the schema (versioning)", "Branch + commit + tag rules", "Releasing", "How consumers pin a version")
- Create/Modify: `AGENTS.md`
- Modify: `README.md`

**Approach:** Replace the two-workflow description with the four-workflow model; document the contract ladder (alpha = lint+breaking+build in isolation; beta = proven against real consumers; stable shipped), the `vX.Y.Z[-alpha.N|-beta.N]` scheme, the `feat/* → develop → release/X.Y.Z → main` flow, the two non-negotiables, and the bump-encodes-wire-compat rule (this repo is the org's source of "breaking"). Keep the artifact-free + submodule-pinning guidance; update the pin example to reference the new ladder (consumers can pin a `-beta.N` for integration, a stable for release).

**Test scenarios:**
- Test expectation: none (documentation) — verification below.

**Verification:** Docs describe four workflows, the ladder, the tag scheme, the breaking rule, and consumer pinning with no remaining "push to main auto-cuts a release" claim.

---

## System-Wide Impact

- **Interaction graph:** `ci.yml` retarget changes which PRs gate; `release.yml` deletion removes the only main-side post-merge job. Consumers (A4) — firmware (submodule) and app — vendor proto tags; a proto **major** forces majors in both. Emulator also speaks the contract and tracks proto versions.
- **Error propagation:** lint/breaking/build failures land before merge or on `develop`/`release/*`; promotion fails loudly if the beta tag is missing.
- **State lifecycle risks:** Tag immutability prevents re-tagging; the breaking classifier (`buf breaking` + commit type) must stay accurate so consumers pin safely.
- **API surface parity:** Same branch/ladder/tag model as app, firmware, emulator (proto is artifact-free; the others ship binaries/APKs).
- **Unchanged invariants:** Submodule-only consumption ("tag IS the release"), `buf lint`/`breaking` check names, the pull-model/chunking wire invariants, and the schema files themselves are unchanged.

---

## Risks & Dependencies

| Risk | Mitigation |
|------|------------|
| "SDK" expectation in the origin doc silently dropped | Resolved to artifact-free; maintainer-confirmed 2026-06-17 (tag-only, nothing to build/package). |
| Retarget breaks wired required-check names (`lint`/`breaking`) | Names kept identical; `build` added; re-confirm ruleset after first develop run. |
| `develop` not created → `develop`/`release/*` triggers reference a missing branch | U0 bootstraps `develop` + default flip before any retarget. |
| `main`'s required check unrealizable (AE4) | U2 keeps `main` in the buf PR triggers (cheap, no build), so `lint`/`breaking`/`build` run on the `release/*→main` PR directly. |
| Breaking change mis-classified → consumers pin an unsafe version | `buf breaking` vs `main` enforces it; commit type must match (AE3); maintainer classifies at release. |
| Prerelease counter math wrong | U1 numeric-precedence + breaking→major tests. |
| Version reset misses a bogus tag | U7 deletes `v0.1.0`; verify `git tag -l` after. |
| Cross-repo drift | Plans authored together; same version contract documented in each. |

---

## Documentation / Operational Notes

- Two one-time operational runbooks: version reset (U7) and ruleset application (U6) via `gh`.
- `0.1.0-beta.1` is the contract consumed by the joint firmware+app beta — coordinate timing.
- Roundtrip/conformance testing is tracked with the emulator's shared vectors, not here.

---

## Sources & References

- **Origin document:** [docs/brainstorms/2026-06-17-cicd-workflow-standard-requirements.md](docs/brainstorms/2026-06-17-cicd-workflow-standard-requirements.md)
- Related code: `.github/workflows/ci.yml`, `.github/workflows/release.yml`
- Prior CI/CD work: memory `cicd-pipeline-plan` (SDK-dropped decision); `docs/plans/2026-06-10-001-feat-ci-cd-release-pipeline-plan.md`
- Sibling plans: `sst-cam-app`, `sst-cam-firmware`, `sst-cam-emulator` `docs/plans/2026-06-17-001-feat-cicd-workflow-standard-plan.md`
