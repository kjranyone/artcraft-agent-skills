# Aesthetic canon — sourced rules for video/motion craft

Every rule below is distilled from a named, publicly available text. When a
frame fails review, name the violated source rule. Do not invent rules.

## Sources

1. **デジタル庁デザインシステム β版 — タイポグラフィ** (Digital Agency of Japan,
   DADS) — <https://design.digital.go.jp/dads/foundations/typography/>
2. **Material Design 3 — Motion: easing & duration** (Google) —
   <https://m3.material.io/styles/motion/easing-and-duration>
3. **The Illusion of Life — the Twelve Basic Principles of Animation**
   (Frank Thomas & Ollie Johnston, Disney; summarized at
   <https://en.wikipedia.org/wiki/Twelve_basic_principles_of_animation>)
4. **Dieter Rams — Ten principles for good design** (Vitsœ) —
   <https://www.vitsoe.com/us/about/good-design> (CC-BY-NC-ND; quote briefly)

## Motion (from M3 + Principles 9/6/2)

- **Duration tiers**: micro 100–150 ms / small 200–250 ms / medium 300–350 ms
  / large 400–500 ms. Nothing on screen should take longer than 500 ms to
  arrive unless it is a deliberate hero move.
- **Easing families** (M3 tokens, cubic-bezier):
  - entering → **emphasized decelerate** `cubic-bezier(0.05, 0.7, 0.1, 1)`
    (fast start, long settle)
  - exiting → **emphasized accelerate** `cubic-bezier(0.3, 0, 0.8, 0.15)`
    (slow leave, fast vanish)
  - moving between two on-screen positions → **standard**
    `cubic-bezier(0.2, 0, 0, 1)`
- **Anticipation** (P2): a slam needs a wind-up — 1–2 frames of the element
  slightly *before* its direction, or the previous element twitching first.
- **Follow-through** (P5): overshoot must *settle*, not stop dead: scale
  108 → 98.5 → 100 lands softer than 108 → 92 → 100.
- **Timing** (P9): sync primary changes to a rhythmic grid (e.g. 0.5 s at
  120 bpm 8th notes). Two changes at once need a reason.

## Japanese typography (from DADS)

- **Letter-spacing: JP display = 0.** Negative tracking on Japanese type
  collides glyphs (、and 。included). Latin caps may take +2% or more; JP
  headlines stay at 0.
- **Weights: exactly two** (Regular 400 and Bold 700). No demi/light tiers.
- **Scale ladder** (video = scale the system up): display 48–64 px on web →
  96–230 px at 1080 p for headlines; micro-labels never below 22 px.
- **No italics for Japanese** (synthetic oblique degrades legibility).
- Multi-line body leading: 150% minimum; display lines may sit at 120–140%.

## Staging and restraint (from Rams + Principles 3/10)

- **Staging** (P3): each frame has exactly ONE focal element. If two things
  compete, one is decoration — remove it.
- **Exaggeration with restraint** (P10): exaggerate the ONE hero move; keep
  everything else calm.
- Rams 5: **unobtrusive** — the design serves the message, never performs.
- Rams 8: **thorough down to the last detail** — a cropped-by-accident logo,
  a half-visible glyph bleeding off frame without intent, is a defect, not a
  style. Intentional bleeds crop ≥ 40% of the element so the crop reads.
- Rams 10: **"Less, but better"** — when unsure, remove.

## Frame-review rubric (run on every rendered frame)

1. ONE focal element? (Staging)
2. Any JP tracking below 0? (DADS)
3. Any element cropped unintentionally? (Rams 8)
4. Any motion still moving at hold? Should be drifting, not dead. (P9)
5. Any second effect competing with the hero device? (Rams 10)
6. Colors outside the declared palette? (P0)
7. Would the client sign this frame? (acceptance)
