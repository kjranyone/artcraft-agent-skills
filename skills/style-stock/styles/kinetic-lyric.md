# Kinetic Lyric

Reference lineage: official lyric videos on YouTube, kinetic typography
 tradition (beat-synced full-frame type, texture flashes, duotone footage
 flashes, word-by-word punches on the downbeat).

## Palette (tokens)

| Token | Hex | Usage |
|---|---|---|
| bg | `#0b0e16`→`#1a2f55` radial | base (gradient, pulsing) |
| type-fill | `#f5f7fa` | primary words |
| type-line | `none` + stroke `#f5f7fa` 1.8 | alternate lines (texture tier) |
| num | `#2f7bff` stroke-only | giant background numerals |
| flash | `#ffffff` at 10-22% | 1-3 frame beat accents |

Contrast rule: consecutive lines alternate **filled ↔ outlined**.

## Type system

- Numerals/words as GRAPHICS: **Big Shoulders Bold** 640–900 px, stroke-only,
  bleeding off frame ≥ 40%, one per section (1 → 20 → 2,000 …).
- Lyric lines: **Noto Sans JP Bold** 80–100 px tracking 0, split into word
  groups, each group its own layer for beat-staggered punches.
- Micro-labels: **DM Mono** 24 px `NN / SECTION`.

## Composition patterns

1. **Number slam** — giant numeral enters at 112%→100% ON the downbeat,
   background gradient pulses ±10% with it.
2. **Word cascade** — word groups land on successive beats at offset
   positions (x 860/1060, y 470/610), diagonal reading flow.
3. **Photo flash** — duotone photo pops in for exactly one 2 s phrase at
   reduced saturation, hidden again.

## Motion grammar

- Grid: 120 BPM. Every event ON a beat (0.5 s multiples). NO events between.
- Punch: opacity 0→100 in 1 frame (hold-keyframe pop), scale 112→97→100
  (0.2 s), settle y +14→0.
- Exit: hard cut off OR 0.2 s fade. Never long dissolves — rhythm dies.
- Silence beat: one 2-3 s gap with a single small line, then the drop.
- Glitch: amplitude ≤ 26, ≤ 3 frames, only on section-first words.

## Sound

Everything IS the sound: flash on kick, word on snare/vocal, number slam on
the drop. If BGM is 120 BPM the timeline syncs as-built; other BPMs need
proportional retime before render.

## EffectCraft recipe

- Numerals: text layer, applyFill false / applyStroke true, stroke 3.
- Photos: `Tritone` (Mid `#12233f`) + blurred navy scrim + 1-frame pops.
- Flash: white solid, opacity keys 0→amp→0 over 0.13 s at beat −1 frame.
- Orb pulse: scale 100→118→100 on the drop.

## Anti-patterns

- Whole-line fades (kills the beat relationship).
- Two words landing on the same beat (word groups split per beat).
- Photos visible longer than 2.5 s (they are flashes, not scenes).
- Numerals fully readable and small — they are graphics, crop them.

## Best for

Lyric videos, music-synced brand teasers, event openers, youth-oriented
messaging.
