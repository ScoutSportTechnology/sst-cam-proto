---
date: 2026-06-09
target_repo: sst-cam-proto
source_repo: app
status: resolved
kind: response
related:
  - docs/cross-repo/proto/inbound/2026-06-07-overlay-rendering-split-and-tolerance.md
---

# Response: overlay rendering semantics split + tolerance

In response to `2026-06-07-overlay-rendering-split-and-tolerance.md`.

## Our decisions

### 1. Reference fixtures — no canonical PNG needed

We do not want a golden-image / reference-PNG fixture system. The layout is
simple shapes and x/y coordinates; the JSON spec + the tolerance values in
`overlay-rendering.md` are sufficient as the contract. Both stacks render
independently and are expected to stay within tolerance by following the spec.
No canonical PNG needs to be generated, stored, or validated against.

**Ask for proto:** No fixture infrastructure needed from the contract repo.
The tolerance table in `overlay-rendering.md` stands as-is.

### 2. Submodule bump — waiting on PR #1 sha

We will bump the app's `proto/` submodule to the PR #1 commit once it is
merged to `sst-cam-proto` main. Please share the sha or tag when it lands.
We will then regenerate Dart bindings and verify `flutter analyze`.

### 3. firmware-spec.md carve-out — confirmed

We will trim the rendering rules from `docs/firmware-spec.md` §9 and replace
them with a reference to `proto/overlay-rendering.md`. Only overlay
authoring/UX guidance (bindings, templates, the example layout JSON) stays
app-side.

### 4. Renderer conformance — known gaps to raise

After reviewing `overlay-rendering.md`'s summary in the inbound doc, we
identify two likely gaps in our Flutter/Skia renderer to raise against the
spec:

**Gap A — Z-order not sorted:** Our renderer draws elements in array order
from `OverlayLayout.elements`. If a layout sends elements out of `z` order
the render will be wrong. We will fix this (sort by `z` before drawing).

**Gap B — `SHAPE_CIRCLE` renders a circle, not an ellipse:** Flutter's
`BoxShape.circle` inscribes a circle in the bounding box. The spec says
"ellipse inscribed in `bounds`". If `x2-x1 ≠ y2-y1` the output differs.
We will fix this by using `BoxShape.rectangle` + `BorderRadius.circular`
with the shorter half-dimension, or `CustomPainter` with an oval path.

**Gap C — Text layout is scale-down, not word-wrap:** We use
`FittedBox(BoxFit.scaleDown)` which shrinks text to fit bounds rather than
wrapping it. The spec says word-wrap at bounds. For scoreboard use the
difference is invisible (single numbers/names fit easily), but it will
diverge for long static text. Please confirm whether `scaleDown` is an
acceptable deviation or whether the spec requires true word-wrap.

We will flag any further gaps after reading the full `overlay-rendering.md`
once the submodule is bumped.

---

## Resolution (proto)

Decided 2026-06-09.

### 1. Reference fixtures — agreed, PNG requirement dropped

Accepted. `overlay-rendering.md` §Conformance amended: **no canonical/golden
PNG**. The geometry is simple shapes at explicit coordinates; the spec + the
tolerance table are the full contract. Conformance is now defined as the two
stacks' **own outputs compared side-by-side within tolerance** (same thresholds:
±2 px geometry, ≤4/255 color, SSIM ≥0.98 frame / ≥0.95 text), not validated
against a stored reference image. No fixture infrastructure required.

### 2. Submodule bump — sha provided

Contract `overlay-rendering.md` landed in **PR #1 = `a5b1d26`** and is unchanged
through repo HEAD. The PNG-drop amendment above is a **new commit on top** — bump
to the latest `sst-cam-proto` main (see outbound
`2026-06-09-overlay-rendering-png-drop-and-conformance.md` for the exact sha).
App + firmware submodules already bumped to `8a158d1`; re-bump once the amendment
merges.

### 3. firmware-spec.md carve-out — confirmed, proceed

No proto action. Trim `firmware-spec.md` §9 rendering rules → reference
`proto/overlay-rendering.md`; keep overlay authoring/UX app-side.

### 4. Renderer conformance

- **Gap A (z-order)** — confirmed correct; spec sorts by `z`, equal `z` = array
  order. *Already implemented* in `overlay_renderer.dart` (`..sort` by `bounds.z`).
- **Gap B (circle = ellipse)** — confirmed; "ellipse inscribed in `bounds`".
  *Already implemented* via `_OvalPainter` (`canvas.drawOval`).
- **Gap C (scale-down vs word-wrap)** — **not an acceptable deviation.** §Text is
  normative: word-wrap at `bounds` width, top-aligned, clipped to `bounds` height,
  explicit "no shrink-to-fit". `FittedBox(scaleDown)` violates it. **Fixed
  app-side**: replaced with a word-wrapping, top-aligned, clip-to-bounds `Text`.
  Also corrected a related deviation — text was vertically *centered*; spec
  requires top-aligned.
