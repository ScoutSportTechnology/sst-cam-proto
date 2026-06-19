---
date: 2026-06-17
topic: cicd-workflow-standard
---

# Git + CI/CD Workflow Standard — sst-cam-proto

## Summary

Refactor this repo's branching, CI/CD, versioning, and docs to the org-wide SST workflow standard: `feat/* → develop → release/X.Y.Z → main`, a maturity ladder adapted for a contract repo (alpha = codegen + contract tests in isolation, beta = the contract proven against real consumers in integration, stable = shipped), SemVer tags built before merge so `main` never runs a failable job, and a clean version reset to the `0.1.0-alpha` line. As the **wire contract**, this repo's version is the canonical source of "breaking change" for firmware and app.

---

## Problem Frame

`main` runs `release.yml` that auto-cuts on every push — a failable post-merge job, so `main` can hold code whose release broke. No integration branch, no prerelease ladder. The single `v0.1.0` tag was auto-cut by the old flow and corresponds to no real, intentional contract release. As the contract every other repo consumes, sloppy versioning here propagates: consumers can't tell a breaking proto change from a safe one.

---

## Actors

- A1. **Contributor** — `feat/*`/`fix/*` branches, PRs into `develop`.
- A2. **Maintainer/admin** (you) — cuts release branches, signs off the contract, merges the release gate, manages rulesets/tags.
- A3. **CI** — codegen + contract checks on PRs; tagged SDK/package artifacts.
- A4. **Consumers** — `sst-cam-firmware` (submodule) and `sst-cam-app` consume the generated contract; they are the integration counterparts for beta.

---

## The Workflow Standard (shared across all four SST repos)

**Branches**
- `feat/*`, `fix/*` — off `develop`. Free: no CI/CD while working.
- `develop` — always-green integration trunk (enforced by the PR gate).
- `release/X.Y.Z` — short-lived, cut from `develop`, deleted after merge to `main`.
- `main` — final released code only; nothing builds here, it promotes the signed-off artifact.
- `hotfix/*` — off the `main` tag for urgent fixes.

**Maturity ladder (by test fidelity)**
- **alpha** — validated in *isolation, automatically*.
- **beta** — validated in *integration, by hand* (proven against real consumers).
- **stable** — beta signed off and shipped.

**Versions & tags (SemVer 2.0)**
- Semantic version `X.Y.Z[-alpha.N|-beta.N]` (no `v`); git tag = version with a `v` prefix (tag-name convention only).
- `vX.Y.Z-alpha.N` on `develop` (auto) → `vX.Y.Z-beta.N` on `release/X.Y.Z` (gated/manual) → `vX.Y.Z` on `main` (stable). Order: `-alpha.N` < `-beta.N` < stable.
- Pre-1.0 (`0.MINOR.PATCH`): minor = new contract surface (new message/field/RPC), patch = non-breaking edits/docs, no stability guarantee. `1.0.0` = first stable contract. Post-1.0: **major = any wire-incompatible change** (removed/renamed field, changed tag number, changed semantics), minor = backward-compatible addition, patch = comment/tooling-only.

**The two non-negotiable rules**
- **Build-in-PR / tag-on-merge.** Codegen + contract checks run before a merge; a merge only tags/promotes already-validated code. `main` never builds.
- **`main`'s checks are gates, not re-runs** — promotion requires the release branch's checks green; they ran upstream.

**Flow**
```
feat/* ─PR: codegen + contract/roundtrip tests + lint─► develop ─auto─► tag vX.Y.Z-alpha.N (alpha SDK/package)
develop ─cut─► release/X.Y.Z ─build SDK + tag vX.Y.Z-beta.N─► consumers integrate (firmware+app) → sign-off
release/X.Y.Z ─PR (beta checks green)─► main ─► tag vX.Y.Z + publish SDK ; delete release branch ; merge back to develop
hotfix: off main tag → fix → vX.Y.(Z+1) → main → back to develop
```

**Release trigger** — automated bump from Conventional Commits + one human gate. Because this is the contract, the maintainer explicitly classifies breaking vs additive at release time (the bump must reflect wire compatibility).

---

## This repo's specifics

- **Artifact:** the generated SDK / contract package (the `.proto` definitions + generated code), consumed by firmware (as a submodule) and the app.
- **No hardware.** The maturity ladder is about *contract* fidelity:
  - **alpha** = codegen succeeds + contract/roundtrip + compatibility-lint tests pass, in isolation. Automated.
  - **beta** = the candidate contract **consumed by real firmware + app in integration** — the proof that the contract change actually works end-to-end with its consumers. Maintainer sign-off.
- **This repo defines "breaking" for the whole org.** A proto **major** bump forces a major in firmware and app. Backward-compatible additions (new optional field) are minor.

---

## Key Flows

- F1. **Feature → develop (alpha).** PR `feat/x → develop` → CI runs codegen + contract/roundtrip + compatibility lint → green + review → merge → tag `vX.Y.Z-alpha.N` + publish alpha SDK. Covers: R1, R4, R5.
- F2. **Cut release candidate (beta).** Maintainer cuts `release/X.Y.Z`; CI builds the SDK + tags `vX.Y.Z-beta.N`; firmware + app integrate the candidate; sign-off when both consume it cleanly. Covers: R3, R6, R9.
- F3. **Promote to stable.** PR `release/X.Y.Z → main` (beta checks green) → tag `vX.Y.Z` + publish SDK; delete release branch; merge back to develop. Covers: R3, R7.

---

## Requirements

**Branch model & protection**
- R1. Create a long-lived `develop` branch; default target for `feat/*`/`fix/*`.
- R2. Rulesets: `develop` requires PR + green checks; `main` requires PR + green required-status-checks + no direct push (admin/hotfix bypass only); `release/*` requires the release checks.
- R3. `main` runs **no failable build/publish job**.

**CI/CD pipelines**
- R4. Rework `ci.yml` to run codegen + contract/roundtrip + compatibility-lint checks on PRs into `develop` (and `release/*`).
- R5. On merge to `develop`, auto-build + tag `vX.Y.Z-alpha.N` and publish the alpha SDK/package (build-in-PR).
- R6. On `release/X.Y.Z`, build the SDK + tag `vX.Y.Z-beta.N`; betas iterate on the branch.
- R7. Replace `release.yml`'s auto-cut-on-push-to-`main` with the release-branch→main promotion: tag `vX.Y.Z` + publish the already-built SDK, no rebuild on `main`.
- R8. Adopt Conventional Commits; the bump **must encode wire compatibility** (breaking → major once past 1.0; additive → minor; non-breaking → patch).

**Versioning reset**
- R9. Delete the bogus `v0.1.0` tag + release; re-establish the clean scheme at the `0.1.0-alpha` line.
- R10. Consolidate the contract work done under `0.1.0-alpha.N`; immediate target `0.1.0-beta.1` (consumed by the joint firmware+app beta). `1.0.0` = first stable contract.

**Documentation**
- R11. Update `CLAUDE.md`/`AGENTS.md`, `README` to the new model, ladder, tag/version convention, flow, and the breaking-change classification rule. Document how consumers pin a proto version.

---

## Acceptance Examples

- AE1. *When a PR is opened into `develop`*, codegen + contract/roundtrip + compatibility-lint run and must be green before merge. Covers: R1, R4.
- AE2. *When a commit merges to `develop`*, CI tags `vX.Y.Z-alpha.N` and publishes the alpha SDK. Covers: R5, R3.
- AE3. *When a change removes or renumbers a field post-1.0*, the bump is classified **major**. Covers: R8.
- AE4. *When a `release/X.Y.Z → main` PR has red beta checks*, the merge is blocked. Covers: R2, R3.
- AE5. *When the release PR merges to `main`*, `vX.Y.Z` is tagged and the already-built SDK is published — no build runs on `main`. Covers: R7, R3.

---

## Success Criteria

- `main` has zero failable build/publish jobs.
- Every proto version's bump correctly reflects wire compatibility, so consumers can pin safely.
- Clean SemVer tags/releases; `0.1.0-beta.1` cut and consumed by the firmware+app beta.
- Same branch/ladder/tag model as firmware, app, emulator.

---

## Scope Boundaries

- No external-tester cohorts; no nightly.
- No maintenance branches / backporting (latest-only-supported) — but note: because this is the contract, consumers must move to the latest; old proto majors are not maintained.
- Not cutting `1.0.0`.
- Implementation specifics (workflow YAML, ruleset JSON, bump-tool config, package registry choice) → plan.

---

## Key Decisions

- Build-in-PR / tag-on-merge; `main` never builds.
- Short-lived `release/X.Y.Z` branch so `develop` keeps flowing.
- alpha = codegen+contract tests in isolation; beta = proven against real consumers.
- Bump encodes wire compatibility — this repo is the org's source of "breaking."
- SemVer version `X.Y.Z`; git tag `vX.Y.Z`. Reset existing tags/releases; start at `0.1.0-alpha`.

---

## Dependencies / Cross-repo Coordination

- **firmware** and **app** consume this contract; a proto major forces majors there. The proto plan likely runs **hand-in-hand** with firmware+app when the `0.1.0-beta.1` contract is exercised in their joint hardware test.
- The emulator also speaks the contract (emulated firmware data) and must track proto versions.

---

## Outstanding Questions

- Where the generated SDK/package is published (GitHub release asset vs a package registry) — plan-time.
- Whether compatibility-lint (e.g., buf breaking-change detection) is adopted as the automated breaking-change classifier.
