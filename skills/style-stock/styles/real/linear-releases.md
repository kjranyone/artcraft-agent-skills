# REAL STOCK: Linear — Release films (2022-2024)

**Work**: Linear (project tracker) — product release/changelog films and the
brand language around them. Creators: Linear in-house design team.
**Provenance**: ⚠️ decomposed from documented brand language (Medium "The
Rise of Linear Style Design", linear.app design blog "A calmer interface for
a product in motion") + general knowledge of the films. Shot-level scrub not
performed. Confidence: high on tokens, medium on timing.

**Why this work matters**: it defined the 2022-23 "Linear style" copycat wave
— dark UI panels floating in dark space, aurora gradients, mono labels. The
severe, calm, "working software" mood.

## Decomposition

**Structure (typical 60-90 s release film)**: voiceover opens with the
problem (3-5 s) → UI panel rises into frame with the feature → 3-5 feature
beats, each 4-6 s → calm outro on logo. NO music drops; continuous calm
score; every beat is a feature, not a claim.

**Tokens**:
- bg: near-black `#08090a`, panels `#101012` with 1px `#232326` borders
- gradient: aurora (blue/violet) at ≤ 15% opacity, blurred 300+, slow drift
- type: Inter-class sans; UI labels 12-14 px mono; headlines 40-48 px,
  tracking −1; body 16-18 px `#8a8f98`
- accent: one hue (Linear: violet-blue) used ONLY on interactive-looking
  elements and progress
- motion: panels rise 20-30 px with fade over 0.4 s; UI content types/cycles
  inside panels; camera never moves — the PANELS move
- pacing: one feature per 4-6 s; no flash, no glitch, no strobe

**The grammar**: "the software is alive and calm". Every animation could be
a screen-recording of the real product. Nothing happens that the product
can't do.

## EffectCraft recipe

- Panels: solid `#101012` 1 px border via a second slightly larger solid
  `#232326` behind it; content = cropped screenshot footage layers.
- Aurora: 2 blurred `Screen` solids, opacity ≤ 15, drifting 30 s loops.
- Voiceover: sttts-say, calm male, script = feature-first sentences.
- Render: 2D only — no segmenting needed.

## Anti-patterns

- Aurora gradient over 20% opacity (becomes a lava lamp).
- Type that is not product copy (marketing superlatives break the honesty).
- Fast cuts (< 2 s per panel).

## Best for

B2B product trust, SaaS, DX tools. GRAND2: fits a TAS-CHA product section.
