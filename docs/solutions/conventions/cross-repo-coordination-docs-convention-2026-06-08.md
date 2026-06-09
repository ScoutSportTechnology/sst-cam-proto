---
title: "Cross-repo coordination docs for a shared wire-contract repo (context / coordination / inbound / outbound)"
date: "2026-06-08"
category: docs/solutions/conventions/
module: docs/cross-repo
problem_type: convention
component: documentation
severity: medium
applies_when:
  - "A repo is the single source of truth for a contract (Protobuf/IDL/OpenAPI/schema) consumed by 2+ other repos"
  - "Consumers are separate checkouts (git submodule or package), so the contract repo cannot see their code"
  - "Deciding whether a contract change is additive (backward-compatible) or breaking (lockstep release)"
  - "A handoff or question arrives from a consumer repo, or one must be sent to a consumer repo"
  - "A new repo begins consuming the contract"
resolution_type: documentation_update
related_components:
  - development_workflow
  - tooling
tags:
  - cross-repo
  - coordination
  - submodule
  - wire-contract
  - protobuf
  - handoff
  - inbound-outbound
  - convention
---

# Cross-repo coordination docs for a shared wire-contract repo (context / coordination / inbound / outbound)

## Context

`sst-cam-proto` is a Protocol Buffers wire-contract repo — the single source of truth — consumed as a git submodule (mounted at `proto/`) by two separate repos: `sst-cam-app` (Flutter/Dart, BLE initiator) and `sst-cam-firmware` (C++/CMake, BLE responder). The consuming repos are separate checkouts; **their code is not visible from the contract repo.**

That creates an information-asymmetry problem. The contract author can read the `.proto` files but cannot `grep` the consumers to see which fields are load-bearing, which enums get pattern-matched, or what each side must do when the schema changes. Without a durable home, that knowledge lives only in the heads of whoever happened to work on both sides — and a breaking change can merge here while consumers drift silently behind it.

The convention below was created to give that cross-repo knowledge a structured, in-repo home, plus a routing system for handoffs between the repos.

## Guidance

Create one folder per connected repo under `docs/cross-repo/<repo>/`, each containing:

- **`context.md`** — who that repo is (stack, build), how it consumes `proto/` (e.g. the app's `just gen-proto` → `protoc --dart_out`), and the standing assumptions the contract repo relies on but **cannot verify** from its own checkout. Tag each unverifiable assumption explicitly (e.g. *"verify before relying"*) so a reader knows it is a bet, not a fact.

- **`coordination.md`** — what a contract change forces in that consumer. Distinguish two classes:
  - **Additive** (add an optional field, a new message, an enum value at the end) → backward-compatible; consumers adopt at their own pace, no lockstep.
  - **Breaking** (remove / rename / renumber a field, change an enum's integer value, or shift a field's meaning) → bump the protocol version (here `DeviceInfoResponse.protocol_version`), pin every consumer to the **same** submodule sha, and ship together.
  - Include a per-repo **impact map** table: *"change touches X → that repo must do Y."*

- **`inbound/`** — handoffs/questions that came **from** that repo or an external session (inbound to the contract repo). Each inbound doc has a blank **Response** section the contract repo fills before closing it.

- **`outbound/`** — handoffs the contract repo **authored and sends to** that repo.

Plus:

- **`docs/cross-repo/README.md`** — indexes the folders and states the direction convention.
- Every handoff doc carries `source_repo:` / `target_repo:` frontmatter, so direction is unambiguous regardless of which folder it sits in.

**Naming note:** the inbound folder was first called `external/`, then renamed to `inbound/` to pair symmetrically with `outbound/`. Symmetric `inbound` / `outbound` is self-evident from the tree; `external` / `outbound` is not — pick names that read as a matched pair.

**Operating workflow:**
1. Before editing any `.proto`, read both `coordination.md` files.
2. Classify the change as additive or breaking; if breaking, plan the lockstep release and open an **outbound** handoff to each affected repo.
3. If a consumer has an open **inbound** question, answer it in its Response section before merging.
4. A new wire feature lands in three places at once — schema here, responder in firmware, initiator in app — so the coordination docs say what each side must do and consumers develop **alongside**, not after.
5. New connected repo → add `docs/cross-repo/<repo>/` (`context.md` + `coordination.md`) and a row in the README.

## Why This Matters

- **Records the unverifiable.** Assumptions the contract repo structurally cannot check from its own checkout get written down and flagged, instead of living only in shared memory.
- **Makes blast radius legible.** Any contributor — not just the original author — can judge whether a proto edit is additive or breaking without reading two other codebases.
- **Creates an audit trail.** An answered inbound is a record of what was agreed; an unanswered inbound is a visible open question. Outbound docs record what the contract repo asked of each consumer.
- **Prevents silent drift.** The common failure mode — contract merges a breaking change, consumers lag for days, the protocol diverges — becomes a tracked, lockstep release instead.

## When to Apply

- A repo is the canonical source of a shared contract (Protobuf, OpenAPI, Avro, IDL, GraphQL, JSON Schema) consumed by 2+ repos.
- Consumers span different stacks/languages (so no single language's idioms can be silently assumed).
- Consumers mount the contract via submodule or package — there is no shared CI to catch cross-repo breakage automatically.
- The team wants consumers built alongside contract changes, not after.

Skip or simplify when all consumers live in the **same monorepo** — there, the build graph and linting can enforce coordination automatically, and a docs convention adds little.

## Examples

Live in `sst-cam-proto`:

- **Folder layout**
  ```
  docs/cross-repo/<repo>/
    ├── context.md       # who the repo is, how it consumes proto/, assumptions
    ├── coordination.md  # what a proto change forces downstream
    ├── inbound/         # handoffs that came FROM that repo/session
    └── outbound/        # handoffs authored here, sent TO that repo
  ```

- **Inbound handoff (firmware → proto):** `docs/cross-repo/firmware/inbound/2026-06-08-gatt-uuids-and-overlay-semantics.md` — firmware asked the contract repo to resolve placeholder GATT UUIDs and decide where overlay rendering semantics live. Frontmatter `source_repo: firmware`, `target_repo: proto`. The contract repo filled the Response section with the decisions (regenerate UUIDs as random 128-bit; add a normative overlay-rendering doc to the contract).

- **Outbound handoff (proto → app):** `docs/cross-repo/app/outbound/2026-06-07-overlay-rendering-split-and-tolerance.md` — the contract repo telling the app to carve rendering rules out of its `firmware-spec.md`, conform its Flutter renderer to the tolerance, and bump the submodule.

- **Inbound response (app → proto):** `docs/cross-repo/app/inbound/2026-06-09-overlay-rendering-response.md` — the app's reply to that outbound handoff, which then drove the contract repo's next decisions.

- **Impact map (representative `coordination.md` row, app):**

  | Change touches | App work it forces |
  | -------------- | ------------------ |
  | Add optional field to a message | Regenerate Dart bindings; field ignored until the app reads it (additive) |
  | Remove / rename / renumber a field | Bump `protocol_version`; pin same submodule sha across repos; release together (breaking) |
  | Any enum | Audit the app's switch/case over that enum |

## Related

- [docs/cross-repo/README.md](../../cross-repo/README.md) — the **living convention** this learning documents; source of truth for the folder structure and direction rule.
- [docs/solutions/workflow-issues/folding-git-submodule-onto-feature-branches-2026-06-05.md](../workflow-issues/folding-git-submodule-onto-feature-branches-2026-06-05.md) — the one-time submodule-adoption mechanics that preceded (and motivated) this ongoing-coordination convention.
- [docs/brainstorms/centralize-proto-contracts-requirements.md](../../brainstorms/centralize-proto-contracts-requirements.md) and [docs/plans/2026-06-04-001-refactor-centralize-proto-submodule-plan.md](../../plans/2026-06-04-001-refactor-centralize-proto-submodule-plan.md) — the upstream decision trail for centralizing the proto contract.
