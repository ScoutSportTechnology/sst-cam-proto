# Overlay Rendering Semantics

> **This document is the normative source for how overlay layouts are rendered.**
> Both consumers implement against it: the app (Flutter / Skia) and the firmware
> (Cairo / Pango). It is part of the wire contract — it lives here, not in either
> consumer, because both must render the *same* `OverlayLayout` identically enough
> that an operator cannot tell the app preview from the camera's stream.
>
> The wire shape of the overlay messages is defined in `bluetooth.proto` §11
> (`PushOverlayLayoutCommand`, `OverlayLayout`, `OverlayElement`, `OverlayRect`,
> `OverlayStyle`, `OverlayShape`, `OverlayBinding`). This document defines what a
> renderer must *do* with those fields. Overlay **authoring** (how the app designs
> layouts, UX, templates) is out of scope here and lives in `docs/firmware-spec.md`
> in the `sst-cam-app` repo.

---

## The guarantee: visual equivalence within tolerance

The app and the firmware use **independent rasterizers** (Skia vs Cairo/Pango).
They differ in text metrics, line breaking, hinting, sub-pixel positioning, and
anti-aliasing. **Byte-identical / pixel-identical output is not achievable** and
is not the contract.

The contract is **perceptual equivalence within a defined tolerance**: a viewer
comparing the app preview and the camera output side by side sees the same
overlay — same layout, same text, same colors — with only sub-perceptual
rasterization differences. Conformance is the two stacks' own outputs compared
within tolerance (see [Conformance](#conformance-tolerance)).

Any earlier "pixel-accurate" wording (e.g. in `bluetooth.proto` comments) is
superseded by this section.

---

## Coordinate space

- All geometry is in **logical canvas pixels**, sized by `OverlayLayout.canvas_width`
  × `OverlayLayout.canvas_height` (e.g. 1920×1080).
- Origin `(0,0)` is **top-left**. `x` increases right; `y` increases down.
- `OverlayRect` is an axis-aligned box: `(x1,y1)` top-left, `(x2,y2)` bottom-right,
  with `x2 ≥ x1` and `y2 ≥ y1`. Width = `x2−x1`, height = `y2−y1`.
- A renderer maps the logical canvas onto its output surface (camera output
  resolution, or app preview surface) with a **uniform scale** that preserves
  aspect ratio. Both stacks use the same canvas spec, so the same layout produces
  the same composition at any output resolution.
- **Every length** — `font_size`, `corner_radius`, and all `OverlayRect` edges —
  is in canvas pixels and scales by the same factor as the canvas. No field is in
  output/device pixels.

### Z-order

| `OverlayRect.z` | Layer |
| --------------- | ----- |
| `0` | Video background — always present, never declared as an element |
| `> 0` | Overlay elements; higher `z` is drawn on top |

Elements with equal `z` are drawn in their array order (`OverlayLayout.elements`,
then template `elements`); later entries draw on top. Templates render above
persistent elements at the same `z`.

---

## Shapes

| `OverlayShape` | Rendering |
| -------------- | --------- |
| `SHAPE_RECT` | Filled rectangle over `bounds`, with `corner_radius` rounding. |
| `SHAPE_TEXT` | Text laid out within `bounds` (see [Text](#text-rendering)). |
| `SHAPE_CIRCLE` | Ellipse **inscribed in `bounds`** (center = box center, radii = half width/height). A square `bounds` yields a circle. |
| `SHAPE_UNKNOWN` | Must not be rendered; renderers skip the element. |

`fill_color` fills `SHAPE_RECT` and `SHAPE_CIRCLE`. For `SHAPE_TEXT`, `fill_color`
(when non-empty) paints the text's background box (`bounds`); `text_color` paints
the glyphs.

---

## Text rendering

- **`font_size`** is the text's **em size in canvas pixels** (the nominal pixel
  size, equivalent to a CSS `font-size` in px), not cap height or line height.
- **`font_family`** is a preferred family. A renderer uses the nearest available
  family if the exact one is absent. To bound divergence, both stacks MUST ship a
  metrically-comparable face for these logical families: `monospace`,
  `sans-serif`, `serif`. Layouts SHOULD use one of these three; any other family
  is best-effort.
- **`font_weight`** (`FontWeight`) maps to the nearest available weight of the
  chosen family (e.g. `NORMAL` → 400, `BOLD` → 700).
- **Baseline & line height:** the first line's baseline sits one ascent below the
  top of `bounds`. Line advance (leading) is the font's natural line height for
  `font_size`; renderers SHOULD NOT add extra leading.
- **Horizontal alignment** (`text_align`): `LEFT` / `CENTER` / `RIGHT` align each
  line within the `bounds` width.
- **Vertical alignment:** text block is **top-aligned** within `bounds`.
- **Wrapping:** `SHAPE_TEXT` wraps on word boundaries at the `bounds` width. A
  single word wider than `bounds` is **not** broken mid-word; it overflows the
  right edge. Text exceeding the `bounds` height is **clipped** to `bounds`
  (no shrink-to-fit, no scroll).
- **Substitution:** `{{param}}` placeholders in `static_text` (template elements)
  are substituted from `BannerEventCommand.params` *before* layout/wrapping.
  Bound text (`OverlayBinding`) is resolved to its current value before layout.

---

## Color & opacity

- `fill_color` and `text_color` are `#RRGGBB` hex in the **sRGB** color space.
  An empty `fill_color` means transparent (no fill drawn).
- `OverlayStyle.opacity` (0.0–1.0, default 1.0) multiplies the element's overall
  alpha, applied to the composited element (fill + text together).
- Compositing is **source-over** (standard alpha blend) onto the layers beneath.
- `corner_radius` is in canvas pixels; `0` = sharp corners. A value larger than
  half the smaller side of `bounds` is clamped to that half (capsule/circle limit).

---

## Conformance: tolerance

There is **no canonical / golden reference image**. The geometry is simple shapes
at explicit x/y coordinates; this document plus the tolerance values below are the
full contract. Each stack renders an `OverlayLayout` independently and is expected
to stay within tolerance by following the spec — no reference PNG is generated,
stored, or validated against.

Conformance is defined as a **side-by-side comparison of the two stacks' own
output** for the same input `OverlayLayout` (plus the event/binding values needed
to populate it). The app preview and the camera output, at a matched output
resolution, must meet **all** of:

| Aspect | Tolerance |
| ------ | --------- |
| **Geometry** (non-text element edges, after scaling) | within **±2 canvas px** between the two stacks |
| **Color** (solid fill / text color regions) | per-channel sRGB delta **≤ 4 / 255** |
| **Overall structural similarity** (full frame) | **SSIM ≥ 0.98** |
| **Text regions** (bounding box of each `SHAPE_TEXT`) | **SSIM ≥ 0.95** — looser, to absorb rasterizer/hinting differences |

These thresholds are the working contract; they may be tightened or relaxed by a
coordinated change to this document (see below) once both stacks report real
results.

---

## Changing this contract

This document is consumed via the `proto/` submodule, pinned to the same commit in
every consumer. A change to these rules or tolerances is a coordinated change: bump
each consumer's submodule to the new commit in lockstep, and re-validate against
the fixtures. See `docs/cross-repo/app/coordination.md` and
`docs/cross-repo/firmware/coordination.md`.
