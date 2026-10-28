# Apple Film (製品映画スタイル)

Reference lineage: Apple product films / keynote videos — black stage,
centered hero, slow reveals, light sweeps, orchestral pacing, claims as
short sentences.

## Palette (tokens)

| Token | Hex | Usage |
|---|---|---|
| stage | `#000000` | true black stage |
| type | `#f5f5f7` | claims |
| metal | `#a1a1a6` | secondary text |
| sweep | `#ffffff` | light sweep accents |

No accent color in the environment — color enters only through the product
/photos.

## Type system

- Claims: **SF-style sans** (use Noto Sans JP Bold for JP / Arial-Helvetica
  class for Latin), 72–96 px, tracking 0, sentence case, centered, max 2
  lines. One claim per card, held 2.5–3 s.
- Micro: 26 px metal, tracking +8, below the claim.

## Composition patterns

1. **Claim card** — black, one sentence centered, fade, hold, fade.
2. **Hero reveal** — product/photo rises from below center with a light
   sweep across it.
3. **Detail macro** — extreme close crop drifting slowly.

## Motion grammar

- Reveals: opacity + slow scale 104→100 over 1.2 s (large duration tier,
  400-500 ms motion then hold).
- Sweep: 300 px soft white band (blurred solid, opacity 25) crossing the
  hero once per reveal, 0.8 s.
- Cuts: slow dissolves 0.5 s between chapters; hard cut only at the drop.
- Rhythm: claim → hero → claim → hero; every claim 2.5-3 s exactly.

## Sound

Orchestral/piano build; narration speaks the claims verbatim; the drop
coincides with the hero.

## EffectCraft recipe

- Stage: pure black comp background (no gradient — true black is the look).
- Sweep: white solid 300×1080, Gaussian Blur 200, opacity 25, position keys
  crossing the hero over 0.8 s.
- Photos: minimal grade, contrast +10, no tritone (product color is the
  color).

## Anti-patterns

- Busy backgrounds, patterns, grain heavier than 2%.
- Multiple claims per card. Colors in the environment.
- Fast cuts (min 2.5 s per card).

## Best for

premium products, keynotes, flagship announcements.
