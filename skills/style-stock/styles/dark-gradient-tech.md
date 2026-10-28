# Dark Gradient Tech

Reference lineage: Linear, Vercel, Stripe marketing films; the "dark-mode-first
SaaS" aesthetic — animated mesh gradients, blueprint grids, precise technical
micro-typography, restrained micro-interactions.

## Palette (tokens)

| Token | Hex | Usage |
|---|---|---|
| bg-deep | `#05070d` | base, 60% of frame |
| bg-lift | `#101a2e` | gradient end / panels |
| type | `#e6edf6` | headlines |
| type-dim | `#8b98ab` | body, labels |
| accent | `#4c8dff` | ONE accent: underlines, numbers, key word |
| glow | `#2a4a8f` | atmosphere orbs (Screen blend) |

Accent appears ≤ 2 places per frame. White never at 100% pure — `#e6edf6`.

## Type system

- Display (Latin): **Big Shoulders Bold**, 180–460 px, tracking −4…0, may
  bleed off frame edge ≥ 40% (intentional crop reads as scale).
- Labels (Latin): **DM Mono Regular**, 22–28 px, tracking +12…+22, format
  `NN / SECTION`, color type-dim, pinned to (170, 120).
- JP: **Noto Sans JP Bold**, display 80–100 px tracking **0**, sub 28–34 px
  Regular tracking +6, color type / type-dim.
- Never more than 2 text blocks visible per frame.

## Composition patterns

1. **Wordmark banner** — display Latin word, left x=830, optically centered
   vertically, slight right-edge bleed; label at (170,120).
2. **Split 40/60** — photo bleeds off right edge (60%), copy block left
   x=170, vertical label right edge x=1760.
3. **Index list** — header center-top, 4 rows: mono number x=545 + name
   x=700 left-aligned, hairline rules `#1c2c47`.

## Motion grammar

- Beat grid: all entrances on 0.5 s multiples (120 BPM).
- Entrance: opacity 0→100 in 1 frame + scale 112→97→100 overshoot over
  0.2 s, ease-out influence 75.
- Exit: fade 0.2 s, or slide 40 px in travel direction while fading.
- Holds: never static — drift position ±1.5% over the hold (moving hold).
- Transitions: a 5 px brand-color vertical line sweeps the frame in 0.43 s
  at each scene cut; old scene fades as it passes.
- Orb scale pulse ±18% on section boundaries.

## Sound

Cuts land on beats. Whoosh (soft) on sweeps, impact on entrances of display
words. Narration: male calm, sentences end before cuts.

## EffectCraft recipe

- BG: solid `#0a1322` + `Gradient Ramp` linear (#04060c→#0e1a30, shape
  radial from upper-left) + two blurred (blur 300-360) `Screen` orbs
  `#1e3a6e`/`#12305c` at 18-26%.
- Vignette: black solid + radial `Gradient Ramp` center alpha 0 → edge
  alpha 0.45-0.6, over everything.
- Grain: white solid + `Noise` 1.6% + layer opacity 4, topmost.
- Photos: `Tritone` grade (mid `#0a1228` family) + blurred navy scrim panel
  (Gaussian Blur 150) behind copy zones.
- Sweeps: 5×1080 brand solid, position −60→1990 over 0.43 s, opacity
  0→65→0.

## Anti-patterns

- Pure `#ffffff` text; rainbow accents; >1 glow orb per corner.
- Centered-only layouts (kills the grid tension).
- Glitch effects (this style is precise, not distressed).
- Static holds longer than 1.5 s without drift.

## Best for

SaaS, IT companies, DX messaging, B2B trust. GRAND2 primary style.
