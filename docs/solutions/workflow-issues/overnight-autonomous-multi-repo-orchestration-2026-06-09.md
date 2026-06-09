---
title: "Running autonomous multi-repo work via background subagents"
date: 2026-06-09
category: docs/solutions/workflow-issues/
module: multi-repo-orchestration
problem_type: workflow_issue
component: development_workflow
severity: medium
applies_when:
  - "Executing coordinated work across the 3 sibling SST repos in one session"
  - "Dispatching background subagents to run long and unattended (e.g. overnight)"
  - "Cross-compiled firmware whose tests only run inside a dev container"
root_cause: missing_workflow_step
resolution_type: workflow_improvement
related_components:
  - tooling
  - testing_framework
tags:
  - subagents
  - background-agents
  - multi-repo
  - dev-container
  - submodule
  - permissions
  - orchestration
---

# Running autonomous multi-repo work via background subagents

## Context

The workspace is three sibling repos (`sst-cam-app`, `sst-cam-firmware`, `sst-cam-proto`) under a root that is **not** a git repo. Executing a coordinated feature (here: the `feat/logic-alignment` work) meant landing changes in all three and running each repo's tests in its own dev container — a good fit for background subagents, one per repo, running unattended. Several operational gotchas cost real time; capture them so the next overnight run is hands-off.

## Guidance

**1. Set permission bypass before leaving agents unattended — or they stall silently.**
Background subagents inherit the session's permission mode. If the session is not in bypass-permissions mode, every tool call the agent makes blocks on a prompt nobody answers, and the agent makes zero progress with no error. You cannot grant this for yourself mid-run. Switch the session to bypass (Shift+Tab to "bypass permissions", or relaunch with `--dangerously-skip-permissions`) **before** dispatching unattended work. If you wake to no progress, this is almost always why.

**2. Sequence by the dependency graph, parallelize the rest.**
`proto` is the shared contract both consumers pin via submodule, so it lands first. Then re-bump the submodule in app + firmware. Only then run app and firmware work — and those two are safe to run **in parallel** because they are separate git repos (separate indexes; no shared working tree). Do not parallelize units that share a git index.

**3. Re-bump the submodule locally — no GitHub round-trip.**
To move a consumer's `proto/` pin to a local proto commit without pushing:
`git -C <consumer>/proto fetch <abs-path-to-proto> <branch> && git -C <consumer>/proto checkout <sha> && git -C <consumer> add proto && git -C <consumer> commit`. Keep all consumers pinned to the same proto sha (`git submodule status` shows an identical leading-space sha). See [[folding-git-submodule-onto-feature-branches-2026-06-05]].

**4. Tests run inside each repo's dev container — verify the toolchain, don't trust the docs.**
- app: `docker exec <app-container> bash -lc 'cd /workspaces/sst-cam-app && flutter test'`. `flutter` is on PATH; `just` and `protoc` were **absent** in the running image despite CLAUDE.md claiming otherwise — verify before relying. Regenerating Dart proto bindings needs `protoc` (absent), but is verification-only for sender-side work.
- firmware: bring the container up (`devcontainer up --workspace-folder ./sst-cam-firmware`), then `cmake --preset test && cmake --build --preset test && ctest --preset test`. The build regenerates the C++ proto and is the first test.

**5. Hardware-bound firmware tests fail by design — establish the baseline.**
IMX477/NVENC/BlueZ/wpa/HTTP/RTMP tests can't pass in-container. Capture the baseline failure set before changing anything, so a *new* failure is distinguishable from the expected six. (This is exactly the gap the planned `sst-cam-emulator` closes.)

**6. Host-side LSP/clang diagnostics are false positives for cross-compiled firmware.**
The host has no Jetson sysroot, so clangd reports "file not found" / "undeclared identifier" on firmware files an agent is editing. Trust the in-container `cmake` build, not the host editor diagnostics.

**7. Hold pushes for human review.**
Land local commits across all repos, but do not `git push` or open PRs unattended — pushing to the shared org remote is outward-facing and should wait for a waking review.

**8. Clean up orphan agent worktrees.**
Prior autonomous runs have left orphan worktree branches containing duplicate/superseded work (e.g. a stray `worktree-agent-*` branch with a commit already on the feature branch). Before relying on a tree, check for and remove these. (session history)

## Why This Matters

The single highest-cost failure is #1: an overnight run that produces nothing because agents silently waited on permission prompts. The rest (sequencing, local rebump, per-repo container commands, baseline failures, host false positives) each individually cost a debugging detour during the run. Encoding them turns a supervised multi-hour run into an unattended one.

## When to Apply

- Before kicking off any unattended multi-repo run, especially overnight.
- When dispatching one background agent per repo for a coordinated feature.
- When a firmware agent reports build/diagnostic errors that don't reproduce in-container.

## Examples

Local submodule rebump after proto lands, keeping all consumers on one sha:

```bash
NEW=$(git -C sst-cam-proto rev-parse HEAD)
for c in sst-cam-app sst-cam-firmware; do
  git -C $c/proto fetch "$PWD/sst-cam-proto" feat/logic-alignment
  git -C $c/proto checkout -q "$NEW"
  git -C $c add proto && git -C $c commit -m "chore(proto): bump submodule"
done
git -C sst-cam-app submodule status proto   # same sha, leading space, in both
git -C sst-cam-firmware submodule status proto
```

## Related

- `docs/solutions/workflow-issues/folding-git-submodule-onto-feature-branches-2026-06-05.md` — the lockstep submodule-pinning mechanics this builds on.
- `docs/plans/2026-06-04-001-refactor-centralize-proto-submodule-plan.md` — why proto is a shared submodule.
- `docs/solutions/architecture-patterns/cross-stack-contract-drift-2026-06-09.md` — the bug class this workflow was executing/reviewing fixes for.
- `sst-cam-emulator` — planned hardware-free harness that removes the "hardware-bound tests fail by design" baseline.
