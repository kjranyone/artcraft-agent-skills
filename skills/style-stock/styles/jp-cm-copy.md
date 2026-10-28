# JP CM Copy (日本のCMコピースタイル)

Reference lineage: Japanese TVCM grammar (電通/博報堂系15秒・30秒スポット) —
コピー主役 (the copy IS the star), beauty shots, calm narration, 6-second
copy-hold rule, product last.

## Palette (tokens)

| Token | Hex | Usage |
|---|---|---|
| washi | `#f7f5f0` | warm paper background (light style) |
| sumi | `#1a1a1e` | JP copy, thin rules |
| ai | `#00368f` | one brand-colored word or rule |
| photo | full color, graded warm | beauty shots, no tint |

Two directions only: **light (washi)** or **deep (sumi on dark)** — never
the tech-navy look.

## Type system

- Copy: **JP mincho (Noto Serif JP) or Gothic Bold**, 64–96 px, tracking
  +2…+8 (JP copy breathes WIDER than display type), line length ≤ 20 chars.
- Furigana-scale sub: 28–32 px, tracking +10, below the copy.
- Company/logo: never over the copy — separate zone.

## Composition patterns

1. **一行コピー** — one line, centered, washi field, 2-second hold. Nothing
   else. The copy alone is the frame.
2. **写真+添え書き** — beauty photo full-frame, copy in the calmest area
   (usually lower third) in sumi or white with 0.2 scrim.
3. **商品最後** — final 5 s: logo + URL + one line, generous margins.

## Motion grammar

- Copy: **fade only** (0.5 s), maybe a 10 px rise. No slides, no pops, no
  glitch. The stillness IS the craft.
- Photo: slow 100→104% push over 4 s (breathing).
- Cuts: at natural phrase ends, 15-frame cross-dissolve or hard cut on
  narration pause.
- Minimum copy hold: **2.0 s** (6-second rule for readability of a 12-char
  line; add 0.2 s per extra character).

## Sound

Narration (calm, slow, sttts-say narrator) reads the copy verbatim + one
supporting sentence. Copy appears 0.3 s BEFORE narration starts each phrase.
Piano/strings bed. Ambient silence is allowed and powerful.

## EffectCraft recipe

- Light field: solid `#f7f5f0` + `Gradient Ramp` #ffffff→#efeadf (soft
  directional light).
- Copy: text + `Drop Shadow` (soft 20/25%) only over photos.
- Beauty grade: `Brightness & Contrast` +8, warm `Photo Filter` 10%.

## Anti-patterns

- Glitch, strobe, heavy motion (this style is calm).
- Dark navy + neon (that is dark-gradient-tech, not this).
- Copy over busy photo areas without scrim.
- More than 2 copy lines per frame.

## Best for

craftsmanship, trust, regional/family business, 15-30 s TVCM-style spots.
