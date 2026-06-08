---
title: "Folding a git submodule conversion onto in-development feature branches"
date: 2026-06-05
category: docs/solutions/workflow-issues/
module: sst-cam-proto
problem_type: workflow_issue
component: development_workflow
severity: medium
applies_when:
  - "Switching between a branch with proto/ as a submodule and one tracking it as plain files"
  - "Cherry-picking a submodule-add commit onto an existing feature branch"
  - "A leftover untracked submodule directory exists on disk before checkout or cherry-pick"
  - "Preserving uncommitted WIP across a branch switch"
  - "Pinning the same submodule commit across multiple consuming repos"
root_cause: missing_workflow_step
resolution_type: workflow_improvement
related_components:
  - tooling
  - documentation
tags:
  - git-submodule
  - cherry-pick
  - branch-folding
  - submodule-deinit
  - git-stash
  - cross-repo-consistency
  - development-workflow
---

# Folding a git submodule conversion onto in-development feature branches

## Context

A shared wire-contract lives in its own repo (`sst-cam-proto`: `bluetooth.proto`, `wifi.proto`, `README.md`) and must be consumed by multiple downstream repos via a git submodule mounted at `proto/`, pinned to the **same** proto commit in every consumer for cross-repo consistency. The complication is that the consumers already have live, in-development feature branches — and they start from inconsistent states:

- `sst-cam-app` (Flutter/Dart) already tracked `proto/` as plain checked-in files.
- `sst-cam-firmware` (C++/CMake) had no proto at all, but a leftover untracked `proto/` clone sitting on disk.

The goal: each feature branch ends with a single "add proto submodule" commit (replacing any tracked plain files), without losing uncommitted WIP and without merge-conflict noise. The submodule work was done first on a throwaway `refactor/proto-submodule` branch, then folded into the real feature branch via cherry-pick.

The friction is entirely git mechanics: switching between a branch where `proto/` is a live submodule and one where it is tracked files, cherry-picking onto a dirty or wrong branch, and leftover submodule artifacts on disk blocking operations.

## Guidance

Use this when folding a shared submodule onto an existing feature branch that may already track the same path as plain files.

**Pre-flight (do every time, in order):**

1. Confirm where you are: `git branch --show-current`. Never cherry-pick or switch blind — a failed checkout can silently leave you on the wrong branch.
2. Preserve WIP narrowly, scoped to the affected file(s), so the branch dance can't touch it:
   ```
   git stash push -m "wip preserve during proto fold-in" -- <path/to/file>
   ```
3. Resolve the `proto/` path state before switching branches. The directory must be in a state the target branch can write into:
   - Leaving a branch where `proto/` is a **live submodule**, switching to one that tracks it as files → deinit first:
     ```
     git submodule deinit -f proto
     ```
   - A leftover **untracked** `proto/` clone on disk (no tracked files on target) → remove the working tree, keep the reusable metadata:
     ```
     rm -rf proto        # .git/modules/proto persists and is reused on re-init
     ```

**The fold-in (reusable recipe):**

```
git branch --show-current                     # MUST be the feature branch
git cherry-pick <submodule-add-commit>        # rm tracked proto files + add .gitmodules + gitlink
git submodule update --init proto             # populate working files (status shows '-<sha>' until done)
git branch -D refactor/proto-submodule        # drop the throwaway branch
git push origin feat/<feature-branch>
```

If WIP was stashed, `git stash pop` after `submodule update --init` and before deleting the branch.

**Pin and verify:**

- Pin every consumer to the **same** proto commit. After init, `git submodule status` must show an identical sha in each repo, with a **leading space** (initialized/checked-out), not a leading `-` (uninitialized):
  ```
   31ecaca proto (heads/main)
  ```
- Fresh clones of any consumer need `git submodule update --init` to populate `proto/`.
- If codegen reads from `proto/` (e.g. `protoc -I proto proto/*.proto`), regenerated output is byte-identical when the relocated protos are byte-identical and the command is unchanged — but verify in the real toolchain environment, not on a host that may lack `protoc`/the task runner.

**Recovery (when an operation aborts):**

- `error: untracked working tree files would be overwritten by checkout` on `proto/*` → `git submodule deinit -f proto`, then retry the checkout.
- `You are currently cherry-picking commit ... nothing to commit` (you cherry-picked the current HEAD) → `git cherry-pick --abort`, then re-check `git branch --show-current`.
- Cherry-pick of the submodule-add commit blocked by an existing `proto/` → `rm -rf proto`, cherry-pick, then `git submodule update --init proto`.

## Why This Matters

- A bad branch switch or cherry-pick fails loudly but leaves you in a surprising state (wrong branch, mid-cherry-pick). Without the pre-flight `git branch --show-current` and the narrow stash, those surprises silently compound — the "cherry-pick the current HEAD" error happened precisely because a failed checkout left the wrong branch checked out.
- Submodule working trees and their `.git/modules/<name>` metadata are separate. Knowing that `rm -rf proto` discards only the working tree (metadata is reused on re-init) versus `git submodule deinit -f proto` is the difference between an operation that proceeds and one that aborts with untracked-file errors.
- Pinning all consumers to one proto sha and verifying with `git submodule status` (leading space vs `-`) is what makes "the contract is the same everywhere" a checkable fact rather than an assumption.
- A single cherry-picked "add submodule" commit keeps each feature branch's history clean and the migration atomic and reviewable, instead of interleaving the refactor with feature work.

## When to Apply

Apply when:

- Introducing a shared git submodule into one or more repos that have active, unmerged feature branches.
- Migrating a path from tracked plain files to a submodule at the same location.
- You must keep multiple repos pinned to the same submodule commit (shared wire contract, shared schema, shared tooling).
- You hit any of: untracked-working-tree-files-would-be-overwritten on the submodule path, an unexpected mid-cherry-pick state, or a leftover submodule clone blocking git operations.

Do **not** need this when:

- Adding a submodule to a fresh repo or a branch with no prior occupant at that path (a plain `git submodule add` suffices).
- The path was never tracked as files and no stale clone exists on disk.

## Examples

Before/after, each error to its fix.

**ERROR 1** — switching to a branch that tracks `proto/` as files while the working tree still has the live submodule:

```
error: The following untracked working tree files would be overwritten by checkout:
	proto/README.md
	proto/bluetooth.proto
	proto/wifi.proto
Please move or remove them before you switch branches.
Aborting
```

Fix:

```
git submodule deinit -f proto   # "Cleared directory 'proto'"
git checkout <target-branch>    # now succeeds; tracked proto files restored
```

**ERROR 2** — cherry-picking the commit that is already HEAD (a prior failed checkout left the wrong branch checked out):

```
You are currently cherry-picking commit 9f7c87e.
nothing to commit, working tree clean
```

Fix:

```
git cherry-pick --abort
git branch --show-current        # always confirm the branch BEFORE cherry-pick
```

**ERROR 3** — a leftover untracked `proto/` clone blocks the cherry-pick of the submodule-add commit:

```
rm -rf proto                     # remove working tree; .git/modules/proto persists and is reused
git cherry-pick <submodule-add-commit>
git submodule update --init proto
```

**Full clean fold-in** (app: had tracked plain proto files):

```
git submodule deinit -f proto                 # leaving a branch where proto is a live submodule
git checkout feat/<feature-branch>            # back on the real working branch
git cherry-pick <submodule-add-commit>        # rm tracked proto files + add .gitmodules + gitlink
git submodule update --init proto             # populate working files (status was '-<sha> proto')
git branch -D refactor/proto-submodule        # drop the throwaway branch
git push origin feat/<feature-branch>
```

**Firmware variant** (no tracked proto files, only a leftover untracked clone, plus WIP to preserve):

```
git stash push -m "wip preserve during proto fold-in" -- <path/to/file>
rm -rf proto
git cherry-pick <submodule-add-commit>
git submodule update --init proto
git stash pop
git branch -D refactor/proto-submodule
git push origin feat/<feature-branch>
```

**Verification:**

```
git submodule status
#  31ecaca proto (heads/main)   <- SAME sha in every consumer; leading space = initialized
```

Both feature branches ended pushed (app `47b7eb5`, firmware `efdbff9`), each pinning proto commit `31ecaca`. Fresh clones must run `git submodule update --init` to populate `proto/`.

> **Codegen note:** the app's Dart codegen `just gen-proto` (`protoc --dart_out=lib/models/proto -I proto proto/*.proto`) should produce byte-identical output after the move because the relocated protos are byte-identical and the command is unchanged — confirm in the devcontainer, since the host lacked `just`/`protoc`.

## Related

- [docs/plans/2026-06-04-001-refactor-centralize-proto-submodule-plan.md](../../plans/2026-06-04-001-refactor-centralize-proto-submodule-plan.md) — the implementation plan this learning executed; source of truth for the procedure.
- [docs/brainstorms/centralize-proto-contracts-requirements.md](../../brainstorms/centralize-proto-contracts-requirements.md) — upstream rationale for centralizing the proto contracts.
