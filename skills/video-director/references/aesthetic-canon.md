# Aesthetic canon — After Effects / Premiere production craft

Rules sourced from the After Effects / Premiere Pro / motion-design canon.
When a rendered frame fails review, name the violated source. UI design
systems (Material, design tokens) are **not** authoritative for film.

## Sources

1. **Adobe After Effects documentation — Graph Editor, keyframe velocity**
   <https://helpx.adobe.com/after-effects/using/animation-keyframes-graph-editor.html>
2. **Adobe After Effects documentation — Motion blur, shutter angle**
   <https://helpx.adobe.com/after-effects/using/rendering-order.html> and
   comp settings (shutter angle in degrees of a 360° rotation)
3. **The Animator's Survival Kit** — Richard Williams (moving holds, ease
   in/out, timing scales)
4. **The Illusion of Life** — Thomas & Johnston, the twelve principles
   <https://en.wikipedia.org/wiki/Twelve_basic_principles_of_animation>
5. **Adobe Premiere Pro documentation — Lumetri Color** (grading panel
   order) and editing grammar (J-cuts / L-cuts, cut on action)
6. **SMPTE/EBU title-safe & broadcast-safe conventions** (90%/80% action
   safe, legal luma/chroma ranges)
7. **School of Motion** (Joey Korenman) — graph-editor essays, "ease" as a
   design decision, value-vs-speed curves

## Graph editor (the AE "eye")

- AE's default Easy Ease is **33% influence** — floaty, amateur unless
  intended. Corporate/teaser entrances read professional at **75–90%
  influence on the arriving side** (decelerate: fast arrival, long settle).
- Entrances = **ease-out** (out-influence high); exits = **ease-in**
  (in-influence high); nothing moves at constant velocity.
- **Moving holds**: a held element still drifts (position/scale ±1–2% over
  seconds) — dead-still frames read as slideshow. (Williams: "moving holds".)
- Overshoot lands in three keys: arrive big → undershoot → settle.

## Camera and comp settings

- **180° shutter rule**: motion blur of ~half a frame reads filmic —
  shutterAngle 180, blur samples 8–16. 360° smears; 0° stutters.
- **Title/action safe**: keep text inside 90% width (x 96–1824 @1920) and
  80% height band; micro-labels may sit inside the margin but never outside.
- 23.976/24 fps reads filmic; 30 fps reads video. Hybrid ok if motion blur
  carries it.

## Layers and compositing grammar (AE techniques → EffectCraft API)

| Technique | AE concept | EffectCraft |
|---|---|---|
| Glow bloom | layer glow + Screen/Add | `Glow` effect; duplicates use blend `Screen` |
| Text reveal | linear wipe / track matte per line | `Linear Wipe` on the text layer, hold-keyed slices |
| Global grade | adjustment layer | full-frame scrim solid + `Tritone`/grade on photos |
| Strobe/glitch accents | hold keyframes, 2–3 frames | `keys.interpolation hold` + amplitude spikes |
| Moving holds | drift on held layers | slow position/scale keys during holds |
| Smear frames | echo / directional blur on fast moves | `Directional Blur` length spike during travel |

## Editing grammar (Premiere side)

- **Cut on action**, not on rest. Scene changes mid-drift, not mid-pause.
- **J/L cuts** for narration: audio leads or lags picture by 6–12 frames.
- Grade order in Lumetri: Basic → Creative → Curves → Color Wheels → Vignette.
  One grade pass on the picture, never per-cut random looks — keep ONE grade
  system across the video (e.g. a single tritone family).
- 6-frame minimum for any readable card; flashes ≤ 3 frames.

## Japanese type (from JLREQ / 日本語組版処理の要件, W3C)

- JP display tracking = 0; negative tracking collides 、。and kanji. Latin
  caps may track wide (+15–30%).
- Two weights only (Regular/Bold). No synthetic italics for JP.
- Punctuation spacing is part of the glyph — never squeeze it into neighbors.

## Frame-review rubric (every rendered frame)

1. ONE focal element? (Staging, P3)
2. Arrivals decelerating, exits accelerating? (Graph editor canon)
3. Held layers drifting? Dead-still = slideshow.
4. Motion blur present on fast layers? (180° rule)
5. JP tracking ≥ 0, no glyph collisions? (JLREQ)
6. Any unintentional crop/bleed? (Rams 8: thorough to the last detail)
7. Colors/grade within the single declared system? (Lumetri discipline)
8. Would the client sign this frame? (acceptance)
