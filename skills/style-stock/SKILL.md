---
name: style-stock
description: Curated library of decomposed visual style directions (style cards) for video, lyric and motion work — each card holds a real-world reference lineage plus execution-grade tokens (palette hex, type system, composition coordinates, motion grammar, EffectCraft recipes). Use with the video-director skill when starting a new video: pick a card, follow its tokens. Use when the user names a style, or when adding a new reference (from YouTube links etc.) to the stock as a new card.
---

# Style Stock — decomposed reference library

The antidote to freehand design: **never design from zero**. Pick a style
card from `styles/`, apply its tokens literally, and only deviate where the
card says deviation is allowed. If the user provides reference videos/links,
decompose them into a NEW card using the card template below, then follow it.

## Dependencies

No external dependencies. Style cards are self-contained markdown files.

## Workflow

1. **Pick** — match the brief to a card (`styles/*.md`). Present the user
   with 2-3 candidate cards, each with one line: what it looks like and what
   it communicates.
2. **Decompose (if user gave references)** — for each reference: palette
   (sample dominant + accent hex), type system (family role, scale, tracking,
   alignment), composition (margins, grid, where the subject sits), motion
   grammar (entrance/exit/transition timing in ms or beats, easing feel),
   pacing (cut lengths). Write it as a new card. Name it.
3. **Express** — build in EffectCraft using the card's EffectCraft recipe
   section. The card's tokens are law; content (copy, photos) is the only
   free variable.
4. **Review against the card** — frame review asks "does this frame obey the
   card?" not "do I like it?". Any deviation needs a reason written in the
   delivery report.

## Card template (for adding new stock)

```markdown
# <style name>
Reference lineage: <named works, studios, movements>
## Palette (tokens)
bg / surface / type / accent — exact hex, usage ratios (e.g. 70/20/8/2)
## Type system
families + roles, display size range, tracking, alignment rules
## Composition patterns
2-4 named patterns with 1920x1080 coordinates
## Motion grammar
entrance / exit / transition / hold behaviors, durations, easing
## Sound
how cuts relate to music, narration rules
## EffectCraft recipe
the exact effects/solids/blends that produce the look
## Anti-patterns
what instantly breaks the style
## Best for
```

## Card index

### Real stock (specific works, decomposed)

| Card | Work | Teaches |
|---|---|---|
| `styles/real/linear-releases.md` | Linear release films (2022-24) | dark panels, aurora, calm product beats |
| `styles/real/spotify-wrapped.md` | Spotify Wrapped (2016-24) | color blocks, giant numerals, hard cuts on beat |
| `styles/real/zkai-copy-cm.md` | Z会「わたしたちをこえてゆけ」(2009) | copy-as-only-visual, restraint, JP CM grammar |
| `styles/real/dylan-cue-cards.md` | Bob Dylan "Subterranean Homesick Blues" (1965) | the original lyric video: cards drop ON the word |

### Genre distillations (fallback when no specific work fits)

| Card | Look | Communicates |
|---|---|---|
| `styles/dark-gradient-tech.md` | dark mode, mesh gradients, mono labels | modern SaaS / precision tech |
| `styles/kinetic-lyric.md` | beat-synced full-frame type, texture flashes | energy, music, youth |
| `styles/jp-cm-copy.md` | Japanese CM copy grammar, calm beauty shots | trust, craftsmanship |
| `styles/apple-film.md` | black stage, centered hero, light sweeps | premium, confidence |
| `styles/cinematic-flythrough.md` | dark 3D space, fog, depth, camera travel | scale, future |

Prefer **real stock** when a card matches the brief. Genre cards are
fallbacks — they describe families, not masterpieces.

Use with: **video-director** (pipeline), **effectcraft** (execution),
**sttts-say** (narration).
