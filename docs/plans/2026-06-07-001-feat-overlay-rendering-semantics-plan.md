---
title: "feat: Overlay rendering-semantics contract doc + guarantee reframe"
type: feat
status: completed
date: 2026-06-07
origin: docs/cross-repo/firmware/external/2026-06-08-gatt-uuids-and-overlay-semantics.md
---

# feat: Overlay rendering-semantics contract doc + guarantee reframe

## Summary

Add a normative `overlay-rendering.md` to this contract repo that both the app
(Flutter/Skia) and firmware (Cairo/Pango) implement against, targeting
*visual equivalence within a stated tolerance* rather than the unachievable
"pixel-accurate" promise. Point the README at it and reword the matching
`bluetooth.proto` comment. UUID regeneration is deferred (gated on the
production trigger).

---

## Problem Frame

The firmware→proto handoff (see origin) flagged two gaps: placeholder GATT UUIDs,
and overlay rendering semantics that live only in `bluetooth.proto` field
comments. Two independent rasterizers (Skia vs Cairo/Pango) cannot produce
byte-identical output, yet the proto comment promises "pixel-accurate sync" and
the README routes all overlay rendering to the app repo's `firmware-spec.md` —
so the must-match rules aren't in the one artifact both consumers pin (this
repo). This plan closes the overlay gap; the UUID swap is deferred.

---

## Requirements

- R1. The contract repo carries the normative overlay rendering rules both stacks must match (units, coordinate→output mapping, baseline/line-height, wrapping, alignment, circle-from-bounds, corner_radius, color/opacity).
- R2. The stated guarantee is visual equivalence within a defined tolerance, backed by shared reference fixtures — not pixel-identity.
- R3. The README designates the contract doc as the source for overlay rendering semantics, while overlay authoring/UX guidance stays in the app's `firmware-spec.md` (the split).
- R4. `bluetooth.proto`'s overlay-section comment no longer claims "pixel-accurate sync."
- R5. The cross-repo coordination records point at the new contract doc so a future overlay-rule change has a known lockstep path.

---

## Scope Boundaries

- No `bluetooth.proto` schema/field change — overlay messages and enums stay as-is; only a comment is reworded.
- The plan does not fix the actual tolerance *number* or the fixture file format — those are authored inside U1 as the doc's content, not pre-decided here.
- No edits to the app's `firmware-spec.md` or the firmware renderer — separate repos, handled via their own handoffs.

### Deferred to Follow-Up Work

- **GATT UUID regeneration** (random 128-bit vendor UUIDs replacing the SIG-base-derived placeholders in the README GATT table): gated on the production trigger and an assigned owner (see origin §1). Placeholders remain the agreed dev values until then. Separate change when the trigger fires.
- **App-repo overlay authoring guidance** alignment in `firmware-spec.md`: app repo, via the matching app-side handoff.
- **Firmware renderer conformance** to `overlay-rendering.md` + fixtures: firmware repo.

---

## Context & Research

### Relevant Code and Patterns

- `bluetooth.proto` §11 (lines ~392-499) — Overlay layout system: the field comments that are the current (only) spec source. The new doc lifts and makes normative what these describe: `OverlayRect` (x1/y1/x2/y2 + z), `OverlayStyle` (`font_size`, `corner_radius` in canvas px; `fill_color`/`text_color` hex; `opacity`; `text_align`; `font_weight`; `font_family` "nearest available"), `OverlayShape` (RECT / TEXT-wraps / CIRCLE = ellipse inscribed in bounds), coordinate space (logical canvas px, top-left origin), z-order.
- `README.md` — existing structure to mirror: GATT table, "Schema files" table, field-comment-driven docs. The overlay doc should match the README's tone and the existing tables.
- `README.md` lines 7-9 — the `firmware-spec.md` pointer that U2 carves the overlay-rendering carve-out out of.
- `docs/cross-repo/firmware/coordination.md` and `docs/cross-repo/app/coordination.md` — the impact maps (overlay rows already present) that U2 updates to cite the new doc.

### Institutional Learnings

- `docs/solutions/workflow-issues/folding-git-submodule-onto-feature-branches-2026-06-05.md` — consumers pin the same proto sha; a new contract doc lands in `proto/` and propagates only when each consumer bumps its submodule. The new doc inherits that lockstep model (relevant to R5 / coordination wording).

### External References

- None fetched — the work is documentation within a repo already fully in context. The cross-stack parity facts (Skia vs Cairo/Pango differ in text metrics, line-height, wrapping, hinting, AA) are the established premise from the brainstorm.

---

## Key Technical Decisions

- **Separate `overlay-rendering.md`, not a README appendix:** the rules are long and normative for two implementers; a dedicated doc keeps the README a quick-reference and gives both consumers a stable path to pin. (Rationale: matches the repo's "one concern per doc" shape; README stays scannable.)
- **Tolerance + fixtures over pixel-identity:** honest, enforceable guarantee given independent rasterizers. The doc states the goal and the conformance method (reference fixtures: input layout → expected rendering, validated within tolerance).
- **Split ownership (rules here / authoring in app):** anything both sides must render identically is shared contract; authoring/UX is app-only. README encodes the split so neither doc silently owns both.

---

## Open Questions

### Resolved During Planning

- Where do overlay semantics live? → split: normative rules in this repo's `overlay-rendering.md`, authoring in app `firmware-spec.md` (origin §2).
- Register UUIDs with SIG? → no; random 128-bit vendor UUIDs, deferred to production (origin §1).

### Deferred to Implementation

- The concrete tolerance metric and threshold (e.g., per-pixel ΔE, SSIM, or max-pixel-diff %) and the fixture file format: decided while authoring U1 against what both stacks can realistically meet. Recorded as the doc's content, not a blocker.

---

## Implementation Units

- U1. **Author `overlay-rendering.md` (normative rules + tolerance + fixtures)**

**Goal:** Create the contract repo's single normative source for overlay rendering semantics both stacks implement against.

**Requirements:** R1, R2

**Dependencies:** None

**Files:**
- Create: `overlay-rendering.md`

**Approach:**
- Lift the rules currently implied by `bluetooth.proto` §11 comments into explicit, normative statements. Cover: coordinate space + canvas→output mapping; `font_size` unit (canvas px) and the baseline/line-height model; text wrapping rule for `SHAPE_TEXT`; `text_align` + `font_weight` behavior; `font_family` "nearest available" fallback rule; `SHAPE_CIRCLE` = ellipse inscribed in `bounds`; `corner_radius` semantics; `fill_color`/`text_color` hex + `opacity` compositing; z-order.
- State the guarantee: visual equivalence within a defined tolerance (pick the metric + threshold here), explicitly not pixel-identity.
- Define the reference-fixture mechanism: each fixture is an input `OverlayLayout` + expected rendered result; both stacks validate against it within tolerance. Describe the fixture location/shape; actual fixture assets are produced by the consuming repos.
- Match README tone; cross-link `bluetooth.proto` §11 and the app `firmware-spec.md` (authoring).

**Patterns to follow:**
- `README.md` tables + section style; `bluetooth.proto` §11 comment content as the rule source.

**Test scenarios:**
- Test expectation: none — documentation unit, no behavioral change. Validated by Verification below.

**Verification:**
- Every `OverlayStyle` / `OverlayRect` / `OverlayShape` field with rendering-relevant behavior is covered by a normative statement.
- The doc states a concrete tolerance metric + threshold and a fixture mechanism.
- No remaining claim of pixel-identical/byte-identical output.

---

- U2. **README pointer fix + cross-repo coordination references**

**Goal:** Make the README designate `overlay-rendering.md` as the overlay-semantics source and record the split; point the coordination docs at it.

**Requirements:** R3, R5

**Dependencies:** U1 (doc must exist to link)

**Files:**
- Modify: `README.md`
- Modify: `docs/cross-repo/firmware/coordination.md`
- Modify: `docs/cross-repo/app/coordination.md`

**Approach:**
- In `README.md` lines 7-9, carve overlay *rendering semantics* out of the app `firmware-spec.md` pointer: state that the must-match rendering rules live in `overlay-rendering.md` (this repo) while overlay authoring/UX guidance stays in the app `firmware-spec.md`. Add an `overlay-rendering.md` row to the "Schema files" / docs listing.
- In both `coordination.md` files, update the existing overlay impact-map rows to cite `overlay-rendering.md` as the source a change must update, and note the lockstep submodule-bump path.

**Patterns to follow:**
- Existing README "Schema files" table; the coordination.md impact-map table rows already present for overlay.

**Test scenarios:**
- Test expectation: none — documentation unit. Validated by Verification.

**Verification:**
- README no longer implies overlay rendering semantics live solely in the app repo; the split is explicit and links resolve.
- Both coordination docs reference `overlay-rendering.md`.

---

- U3. **Reword `bluetooth.proto` overlay comment**

**Goal:** Remove the unachievable "pixel-accurate sync" claim from the schema.

**Requirements:** R4

**Dependencies:** U1 (so the comment can point at the new doc)

**Files:**
- Modify: `bluetooth.proto`

**Approach:**
- In §11 (line ~397), replace "This guarantees pixel-accurate sync between the app's in-session preview and the camera's live stream + recorded footage." with a statement of visual equivalence within tolerance, referencing `overlay-rendering.md` as the normative source. Comment-only; no field/number/schema change.

**Patterns to follow:**
- Surrounding §11 comment style.

**Test scenarios:**
- Test expectation: none — comment-only change. Codegen output is unaffected (comments don't affect generated bindings).

**Verification:**
- No "pixel-accurate"/"pixel-perfect" wording remains in `bluetooth.proto`.
- The comment points to `overlay-rendering.md`.
- `git diff` shows only comment lines changed (no field/number edits) → regenerated bindings would be byte-identical.

---

## System-Wide Impact

- **Interaction graph:** New contract doc consumed by app + firmware only when each bumps its `proto/` submodule sha. No runtime effect from this repo.
- **API surface parity:** None — no schema change. The "contract" affected is rendering behavior, now documented; enforcement is each consumer's renderer + fixtures.
- **Unchanged invariants:** `bluetooth.proto` overlay messages, enums, and field numbers are unchanged; generated bindings remain byte-identical (U3 touches comments only). The wire format is untouched.

---

## Risks & Dependencies

| Risk | Mitigation |
|------|------------|
| Tolerance/fixture spec written here is unrealistic for one stack | Frame metric + threshold as the doc's working decision; consumers validate against real fixtures and can propose adjustment via a follow-up contract change. |
| Consumers don't pick up the new doc (drift persists) | Coordination docs (U2) record the submodule-bump lockstep path; doc only governs once pinned. |
| README split is ambiguous (readers unsure which doc owns what) | U2 states the split explicitly: rules here, authoring in app. |

---

## Sources & References

- **Origin document:** [docs/cross-repo/firmware/external/2026-06-08-gatt-uuids-and-overlay-semantics.md](../cross-repo/firmware/external/2026-06-08-gatt-uuids-and-overlay-semantics.md)
- Related code: `bluetooth.proto` §11 (overlay layout system); `README.md` lines 7-9
- Related docs: `docs/cross-repo/firmware/coordination.md`, `docs/cross-repo/app/coordination.md`
