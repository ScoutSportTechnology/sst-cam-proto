---
title: "Cross-stack semantic drift on a shared proto/BLE contract"
date: 2026-06-09
category: docs/solutions/architecture-patterns/
module: ble-proto-contract
problem_type: architecture_pattern
component: tooling
severity: high
applies_when:
  - "Two consumers (Flutter app encoder, C++ firmware decoder) share one proto/BLE wire contract"
  - "Adding or changing a field that both an encoder and a decoder must agree on"
  - "A field's default, unit, or routing key is implied in code rather than stated in the contract"
root_cause: inadequate_documentation
resolution_type: documentation_update
related_components:
  - development_workflow
  - documentation
tags:
  - proto3
  - ble
  - wire-contract
  - cross-stack
  - app-firmware
  - conformance
  - semantic-drift
---

# Cross-stack semantic drift on a shared proto/BLE contract

## Context

The app (`sst-cam-app`, Dart/Flutter) and firmware (`sst-cam-firmware`, C++) share one wire contract (`sst-cam-proto`) via submodule. They serialize identical bytes — the wire format never diverges. Yet a multi-agent review of the `feat/logic-alignment` work found a recurring failure class: the two stacks agreed on the **bytes** but disagreed on the **meaning** of those bytes. These bugs are invisible to each repo's own unit tests (each side passes against its own assumptions) and only surface when a real app talks to a real firmware — which, with no hardware-free path, was never.

This is the pattern worth remembering: **on a contract-mediated two-consumer system, the dangerous drift is semantic, not syntactic, and per-repo testing structurally cannot catch it.**

## Guidance

When a field crosses the contract, the contract — not either implementation — must pin every property a consumer could assume differently: **default, unit, presence semantics, and any routing/identity key.** If it's only in code on one side, the other side will eventually assume something else.

Concretely:

1. **Make defaults explicit and detectable.** Proto3 non-optional scalars can't distinguish "unset" from "zero". Declare fields `optional` so consumers branch on `has_*()`, and state the documented default in the contract prose.
2. **State units on every numeric field that isn't self-describing.** Timestamps especially — name the epoch and the unit (`// Unix epoch milliseconds`), and make sure both sides use a wall-clock source, not a monotonic one.
3. **Identity/routing keys must be the same value on both ends.** If one side routes by a UUID, the other side must *send* that UUID, not a display label that happens to look similar.
4. **Conventions that live in code belong in the contract.** A demux trick like "an ack is a frame with `total_chunks == 0`" must be documented in the `.proto` (and the field reserved) so a third consumer can't break it.
5. **Add cross-stack conformance coverage.** Per-repo unit tests prove a stack matches its own assumptions; only a shared conformance check (golden byte vectors, or an emulator that runs both stacks together) proves the assumptions match each other. See [[../../../sst-cam-emulator]] brainstorm.

## Why This Matters

Each instance below looked like "app passes, firmware passes" in isolation and would have shipped silently:

- **Proto3 default inversion.** `visible`/`opacity` were non-optional; the firmware read an unset field as `false`/`0.0`, so an element the app intended to show rendered hidden or fully transparent — a blank camera frame where the preview showed an overlay. Fix: proto3 `optional` + documented defaults + `has_*()` mapping.
- **Timestamp clock-source mismatch.** Firmware filled `updated_at`/`capture_timestamp` from `steady_clock` (monotonic, boot-relative) while the app decoded them as Unix-epoch ms — and multiplied one by 1000. The value was never a valid wall-clock time under any reading. Fix: `system_clock` epoch-ms on the firmware, drop the `*1000`, document the unit in the `.proto`.
- **Identity routing mismatch.** The app sent `ScoreUpdateCommand.team_id` as a display name; the firmware routed by the session-config team UUID. Every goal was dropped as "unknown team". Fix: send the configured id on both the session-config and the score path.
- **Convention-not-contract.** `ChunkAck` was demuxed from a real payload by `total_chunks == 0`, a rule that existed only in both implementations' comments. A future field at that number would silently break both. Fix: document the convention in the `.proto` and `reserved 3`.

The common thread: the contract was *silent or ambiguous* on a semantic property, each side filled the gap independently, and the gap was only observable end-to-end.

## When to Apply

- Before adding or changing any field in `bluetooth.proto` that an encoder sets and a decoder reads.
- When reviewing app↔firmware changes: check each touched field for default, unit, presence, and identity-key agreement against the contract, not against the other implementation.
- When a behavior "works in the app preview / mock" but is unverified against real firmware — treat that as an untested semantic assumption, not a passing test.

## Examples

Default made explicit and detectable:

```proto
// before — firmware reads unset as false/0.0 (element vanishes)
bool  visible = 6;
float opacity = 3;

// after — consumers branch on presence; default documented in overlay-rendering.md
optional bool  visible = 6;  // absent => true (renders)
optional float opacity = 3;  // absent => 1.0 (opaque)
```

Convention promoted into the contract:

```proto
message ChunkAck {
  string correlation_id = 1;
  uint32 chunk_index    = 2;
  // An ack decodes as a ChunkedPayload with total_chunks (field 3) absent => 0.
  // Receivers demux by total_chunks == 0. Reserved so it can't be reused.
  reserved 3;
}
```

## Related

- `docs/plans/2026-06-09-001-feat-logic-alignment-contract-plan.md` — the contract amendments that fixed the instances above (authoritative fix-action).
- `docs/brainstorms/2026-06-08-app-firmware-logic-alignment-requirements.md` — the original audit / problem frame.
- `sst-cam-app/docs/plans/2026-06-09-016-feat-logic-alignment-app-plan.md` — app-side conformance.
- `sst-cam-app/docs/solutions/architecture-patterns/app-source-of-truth-drift-sqlite-2026-05-06.md` — the data-ownership foundation; this doc extends it (ownership clear, contract still silent on semantics).
- `docs/solutions/workflow-issues/overnight-autonomous-multi-repo-orchestration-2026-06-09.md` — the workflow that executed and reviewed these fixes.
- `sst-cam-emulator` — the planned hardware-free cross-stack harness that would catch this drift end-to-end.
