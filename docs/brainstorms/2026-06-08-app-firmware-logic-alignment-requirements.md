---
date: 2026-06-08
topic: app-firmware-logic-alignment
---

# App ⇄ Firmware Logic Alignment — Contract (proto) Slice

## Summary

Amend the proto contract (`bluetooth.proto`, `overlay-rendering.md`, `README.md`) so it is the single binding truth for the app↔firmware behaviors that an audit found diverging — closing the cases where the contract is silent or wrong, and making proto3 default semantics unambiguous so consumers cannot drift.

---

## Problem Frame

The app and firmware pin the same proto commit and speak the same wire format, but an audit (2026-06-08) found their runtime behavior diverges in several places. A subset of those divergences are not consumer bugs — they trace to the contract itself: rules that no renderer implements (text `fill_color` background box), an ordering constraint firmware enforces that the contract never states (WiFi Direct before session config), commands the app uses that the contract defines but firmware treats as unsupported, and proto3 non-optional fields (`visible`, `opacity`) whose unset-default semantics silently invert meaning across the two stacks.

This slice covers the proto repo. The app code fixes and firmware code fixes are scoped in sibling docs (`sst-cam-app`, `sst-cam-firmware` `docs/brainstorms/2026-06-08-app-firmware-logic-alignment-requirements.md`). Because every consumer pins proto via submodule, contract changes here propagate by lockstep re-bump.

---

## Requirements

**Overlay rendering semantics (`overlay-rendering.md`)**
- R1. Make element default semantics explicit and safe: specify that an element with `visible` unset renders (default visible) and `opacity` unset renders fully opaque (default 1.0), and state in the contract how senders/receivers must treat the proto3 non-optional defaults so the firmware default-inversion class of bug cannot recur.
- R2. Resolve the text `fill_color` background-box rule (currently neither consumer implements it): either keep it and require both renderers to paint it, or drop it from the contract. (See Outstanding Questions.)
- R3. State the uniform aspect-preserving scale as a hard MUST (single scale factor, not independent x/y), so a consumer cannot non-uniformly stretch the canvas.
- R4. State text-height clipping to `bounds` as a hard MUST.
- R5. Clarify the first-line baseline rule and the metric-comparable font requirement enough that two independent rasterizers stay inside the stated tolerance.

**Command surface (`bluetooth.proto`)**
- R6. Decide the disposition of `get_match_state` and `thumbnail` — both defined in the contract and used by the app, but unsupported by firmware: either keep (firmware must implement) or remove from the contract. (See Outstanding Questions.)
- R7. Decide whether the WiFi-Direct-before-session-config ordering firmware enforces is a real contract dependency to document in the §11 design flow, or an over-constraint to drop. (See Outstanding Questions.)
- R8. State that consumers MUST read and check `DeviceInfoResponse.protocol_version` and define the expected behavior on a version mismatch, so wire-format skew surfaces as a clean error rather than silent default-reads.

**Framing / chunking (`README.md`)**
- R9. Make the `ChunkedPayload` / `ChunkAck` flow-control contract precise and symmetric: specify that inbound (app→camera) command chunks are acknowledged per chunk, not only firmware→app response chunks, so neither side can implement one direction and stall the other.

---

## Success Criteria

- Every audited divergence that traced to the contract has a corresponding amended rule, and the amended `overlay-rendering.md` / `bluetooth.proto` / `README.md` read as an unambiguous single source both consumers can implement against.
- The app and firmware slices can each cite a specific contract clause for every behavior they change — no fix relies on unwritten agreement.
- A new proto commit is pushed and both consumers re-bump to it in lockstep (identical pin), preserving the alignment invariant.

---

## Scope Boundaries

- No new wire fields, messages, or features beyond what the audited divergences require.
- No app or firmware code changes in this slice — they live in the sibling docs.
- The mutually-absent commands (`set_wifi_config`, `set_streaming_config`, `factory_reset`, `firmware_update`) are not addressed: app never sends them and firmware reports unsupported — already consistent.
- No conformance harness / golden-image fixtures (explicitly excluded; `overlay-rendering.md` keeps the no-golden-reference stance).

---

## Key Decisions

- Contract is the binding arbiter; amend it where silent or wrong. Rationale: keeps a single source of truth instead of letting current behavior become an implicit contract.
- Changes propagate by lockstep submodule re-bump to app + firmware. Rationale: the existing alignment mechanism; identical pin both sides is the safety property.
- Coordination happens from the workspace root, not via in-repo cross-repo handoff docs (that practice was removed). Rationale: a single root session now has cross-repo read/write.
- Verification is per-repo unit tests in each consumer's dev container, one per audited finding — not live round-trip or render-tolerance harness this pass.

---

## Dependencies / Assumptions

- App slice: `sst-cam-app/docs/brainstorms/2026-06-08-app-firmware-logic-alignment-requirements.md`.
- Firmware slice: `sst-cam-firmware/docs/brainstorms/2026-06-08-app-firmware-logic-alignment-requirements.md`.
- The R2 / R6 / R7 contract-direction decisions gate the corresponding app and firmware requirements; resolve them before per-repo planning so both sides implement the same choice.

---

## Outstanding Questions

### Resolve Before Planning

- [Affects R2][User decision] Text `fill_color` background box: drop from the contract (simpler; matches what both renderers already do), or keep and require both to paint it? Recommendation: drop, unless a styled text-chip background is a real design need.
- [Affects R6][User decision] `get_match_state` + `thumbnail`: firmware implements them (contract-is-law), or remove from the contract and stop the app sending them? Recommendation: implement — the app already polls/requests them, so they are live product surface.
- [Affects R7][User decision] WiFi-Direct-before-session-config ordering: document it as a real dependency in §11, or drop the firmware constraint? Recommendation: document it if session config legitimately needs the group up first; otherwise drop.
