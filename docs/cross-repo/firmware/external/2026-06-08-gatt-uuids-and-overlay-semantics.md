---
date: 2026-06-08
target_repo: proto
source_repo: firmware
status: resolved
resolved_date: 2026-06-08
kind: question
related: docs/plans/2026-06-08-001-refactor-app-source-of-truth-firmware-plan.md
---

# Placeholder GATT UUIDs + (maybe) an overlay-rendering-semantics appendix

## Context (firmware side)

The firmware refactor implements the GATT layout from `proto/README.md`:

- SST-Cam Service `A1B2C3D4-0001-0000-8000-00805F9B34FB`
- Command Write `A1B2C3D4-0011-...` (Write Without Response)
- Command Response `A1B2C3D4-0012-...` (Notify)
- Device name `sst-cam-NNNN`, service UUID advertised for the app's scan filter.

`proto/README.md` explicitly marks these UUIDs as **placeholders** ("Replace with officially registered UUIDs before production. The layout must not change without updating both this document and the firmware.").

## What firmware assumes / decided

The firmware will hard-code the placeholder UUIDs above for now (they're the agreed values today). Both the app's scan filter and the firmware's advertising use the same constants, so development works — but production needs the real registered UUIDs in **one** place (the contract repo) so neither side drifts.

## Ask for the proto repo

1. **UUID registration:** when official UUIDs are registered, update `proto/README.md` (the GATT Service Layout table) as the single source of truth, and notify both firmware and app to pick up the change in lockstep. Is there a planned date / owner for registration?
2. **Optional — overlay rendering-semantics appendix:** the overlay model in `bluetooth.proto` (coords, anchors, `text_align`, `font_size` units, wrapping, `corner_radius`, circle-from-bounds) is specified mostly in field comments. Pixel-parity between the app (Flutter) and firmware (Cairo/Pango) would be more robust if the contract carried a short, explicit "rendering semantics" section. Worth adding to the contract repo, or keep it as an app↔firmware agreement? (See the matching app-repo handoff on pixel-parity.)

## Acceptance / what "aligned" looks like

- A clear plan/owner for replacing placeholder UUIDs, with the contract repo as the authoritative source both sides track.
- A decision on whether overlay rendering semantics live in the contract repo or as an app/firmware-side agreement.

## Response (from the proto session, 2026-06-08)

### Summary

Proto repo answers both asks. **UUIDs:** the placeholders aren't just unregistered —
they're malformed; replace them with proper random 128-bit vendor UUIDs (no SIG
registration needed), contract repo as the single source. **Overlay:** add a
*normative* rendering-semantics doc to the contract that targets
visual-equivalence-within-tolerance, since true pixel-parity across Flutter and
Cairo/Pango is not achievable; must-match rules live here, authoring guidance
stays in the app's `firmware-spec.md`.

### 1. UUIDs — regenerate as random 128-bit vendor UUIDs

**Decision: generate fresh random 128-bit UUIDs. Do NOT register with the Bluetooth SIG.**

Reasoning:

- The current placeholders (`A1B2C3D4-XXXX-0000-8000-00805F9B34FB`) reuse the
  **Bluetooth SIG base UUID** suffix `...-8000-00805F9B34FB`. That base is
  reserved for SIG-assigned values — using it for a private vendor service is
  incorrect, not merely "unregistered." So this is a correctness fix, not just a
  pre-production swap.
- A private app↔camera link does **not** need SIG registration. SIG registration
  buys a 16-bit short UUID for *public* interoperability and costs SIG
  membership/fees — overkill here.
- The right move is a random 128-bit UUID per role (service, command-write,
  command-response), generated once (`uuidgen`) and recorded in the contract.

Process (answers the firmware's "single source + lockstep" ask):

- The **contract repo's `README.md` GATT Service Layout table is the single
  source of truth.** Both app scan-filter constants and firmware advertising
  constants derive from it.
- Replacing the values is a coordinated change: bump the consuming repos'
  `proto/` submodule to the new commit; app + firmware update their hard-coded
  constants in lockstep at the same proto sha. (See
  [`../coordination.md`](../coordination.md).)
- **Owner / target date: TBD** — org decision, not a contract decision. Trigger
  is *before the first production / regulatory build*. Until then the current
  placeholders remain the agreed dev values, so firmware hard-coding them now is
  fine.

### 2. Overlay rendering semantics — yes, add to the contract (normative, split)

**Decision: the contract repo carries a normative overlay rendering-semantics doc.**

The guarantee is reframed: `bluetooth.proto`'s "pixel-accurate sync" claim is not
achievable across two independent rasterizers (Flutter/Skia vs Cairo/Pango differ
in text metrics, line-height, wrapping, hinting, anti-aliasing). The contract
targets **visual equivalence within a stated tolerance**, backed by **shared
reference fixtures** (input layout → expected rendering), which both stacks
validate against.

Location — **split by reader need:**

| Lives in | Content |
| -------- | ------- |
| **Contract repo** (this repo) | The *must-match* rules: coordinate→output mapping, `font_size` unit, baseline/line-height model, text wrapping rule, `text_align` behavior, circle-from-bounds (ellipse inscribed in bounds), `corner_radius`, color/opacity compositing, the tolerance, and the reference fixtures. |
| **App repo `firmware-spec.md`** | Overlay *authoring / UX* guidance (how the app designs layouts) — stays where it is. |

Rationale: anything both sides must render identically is, like the wire format,
shared contract — and the contract repo is the only artifact both consumers pin to
the same sha. The current `README.md` line that routes all overlay rendering to
the app repo gets a one-line pointer fix to reflect this split.

### Follow-up work (not done in this session)

This session records decisions only. Open implementation tasks for the proto repo:

1. Generate the 3 random 128-bit UUIDs and replace the placeholders in
   `README.md`'s GATT table (when the owner/date trigger fires).
2. Author `overlay-rendering.md` (filename/structure TBD by ce-plan): rules +
   tolerance + reference fixtures.
3. One-line `README.md` edit pointing overlay rendering semantics to the new
   contract doc and noting the split with `firmware-spec.md`.
4. Reword `bluetooth.proto`'s "pixel-accurate sync" comment to
   "visual equivalence within tolerance."

### What "aligned" now looks like

- ✅ UUID path decided (random 128-bit, no SIG), single source = contract README,
  lockstep process documented. Owner/date = firmware/app teams to set before
  production.
- ✅ Overlay semantics decided: normative, in the contract repo, split from app
  authoring guidance, visual-equivalence-within-tolerance + fixtures.
