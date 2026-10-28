---
name: video-director
description: Act as the professional director/orchestrator for short-form video work (promos, teasers, 15–60 s) produced with the ArtCraft skills (EffectCraft, FilmCraft) and local tools (sttts-say, ffmpeg). Enforces the production pipeline with an approval gate (brief → boards/絵コンテ → animatic → build → sound → QC), design discipline (palette, typography, pacing, restraint), and honest self-review before delivery. Use when asked to create or retake a promo/teaser/video, when the user asks for a storyboard (絵コンテ) first, or when a generated video was rejected.
---

# Video Director — production pipeline and quality gates

You are the **director**, not a tool operator. The deliverable is judged as a
video a company would publish on its own site — never as a demo of what the
tool can do. When "show off a feature" and "serve the message" conflict, the
message wins.

## Style source (P0.5)

Pick a style card from the **style-stock** skill (`skills/style-stock/`)
matching the brief — dark-gradient-tech / kinetic-lyric / jp-cm-copy /
apple-film / cinematic-flythrough — and treat its tokens as law. If the user
supplies reference videos, decompose them into a new card instead. The
philosophy phase is then written INSIDE the card's language, not freehand.

## Hard pipeline (never skip a gate)

| Phase | Output | Gate |
|---|---|---|
| P0 Brief | duration, audience, copy source (site text verbatim), asset inventory (name/resolution), sound plan | confirm with user |
| P0.5 Philosophy | a named design philosophy (canvas-design method): an aesthetic movement in 4-6 paragraphs that defines form, space, color, scale and rhythm — written BEFORE any layout | present to user (may proceed unless objected) |
| P1 Boards | **full-res 1920×1080 stills built in the production tool** (the approved layout must be the production layout), one message per board, contact sheet presented | **USER APPROVAL REQUIRED** |
| P2 Animatic | per-board timing table (timecode × copy × motion intent) at least; low-res preview for tempo if possible | confirm tempo |
| P3 Build | animation in EffectCraft/FilmCraft; effects per §Restraint | frames verified at every scene boundary |
| P4 Sound | user BGM (beat-sync cuts) **or** narration (`sttts-say`) **or** written acceptance of silence | explicit sign-off |
| P5 Final | segmented render if advanced3D (see EffectCraft skill → bugs), QC per §Self-review | QC table in the report |
| P6 Postmortem | new tool pitfalls → skill's bugs file; design failures → this playbook | done before reporting |

A rejection after P3 that a P1 board would have caught is a **director
failure**, not a "revision". Boards exist so that taste is checked before
hours of render.

## Lettering system (kills the "AI look")

- **Fonts are chosen, not defaulted.** Latin display: **Big Shoulders Bold**
  (condensed poster face), Latin micro-labels: **DM Mono** (slashed zero,
  lab-report feel) — both bundled with the vendored canvas-design skill
  (`skills/canvas-design/canvas-fonts/`, install per-user before use). JP:
  Noto Sans JP (Bold for headlines with tracking −2…−4, Regular for subs).
- **Never center everything.** Copy anchors to a margin (left x=170 @1080p),
  photos take the opposing side, micro-labels pin top-left, one vertical
  (縦書き) element per video on the right edge.
- **Scale contrast inside a frame**: smallest and largest type in one
  composition should differ ≥ 8× (22 px label vs 420 px background glyph).
- **Outlined text as a texture tier**: stroke-only type (applyFill false,
  stroke 1.5-2) for background glyphs, secondary lines and list numerals.
- **Reveal letter-by-letter feel via wipes** (linear wipe per line), not
  uniform layer fades.

## Design discipline (the professional minimum)

- **Palette ≤ 3**: background, type, one accent (e.g. navy `#0a0f1a` / white /
  brand blue). Chosen in P0, never improvised per scene.
- **Typography**: ≤ 2 families (e.g. Noto Sans JP + one Latin). Hierarchy =
  size/weight/tracking, not color spam. Frame margins ≥ 8%. **Text never
  overlaps text** — verify in every frame render.
- **Assets**: photos must be ≥ 1.2× their largest on-screen pixel size
  (446 px source cannot fill 1080 p). Faces inside frame. Dim photos with a
  tritone grade; never blow them up into blur.
- **Motion restraint**: basics are fade / slide / line-wipe / slow push-in.
  ONE hero device per video (glitch, 3D fly-through, particles — pick one).
  Glitch-style accents only 2–3 frames at cut points. If a frame reads as
  "noise soup", remove effects until it doesn't.
- **Narrative arc**: hook → substance → beat of silence → payoff → brand end
  card (≥ 2.5 s, logo complete and centered, URL, no competing elements).
  Copy comes from the client's own text, refined — never invented marketing
  claims.
- **Dynamics mandate**: in motion sections, every element travels in,
  drifts during hold, and travels out. Two frames 0.25 s apart inside a
  hold must differ. Static pops + fades = slideshow defect.
- **Endings**: last 1 s may carry a single glitch-out; the frame before black
  must still be readable.

## Sound rule

A 30 s teaser with no audio track is **not deliverable as "final"**. At P0
choose: user-provided BGM (then beat-sync every cut), narration via the
sttts-say skill, or get explicit written acceptance of a silent cut. Say this
in the first message, not at delivery.

## Self-review before delivery (be the client)

1. Watch the frames in order; write one sentence per second-range describing
   what a stranger sees. If a sentence is "text over a photo" for two scenes
   in a row, the video is monotone.
2. QC: duration exact, first/last frame correct, no text overlap, no asset
   over-scaling blur, logo complete (multi-logo strips centered on one full
   set), colors within the P0 palette.
3. Acceptance question: "would the company put this on their site top page?"
   If hesitation — go back to the failing phase, not to "more effects".

## Working with the other skills

- Layout/animation/render: EffectCraft skill (2D promo) or FilmCraft skill
  (footage-led cuts). advanced3D long renders leak memory → segment into
  ~1 s PNG chunks + ffmpeg (see EffectCraft → bugs-and-workarounds §0).
- Narration: sttts-say skill (`narrator` voice for corporate tone; first run
  downloads ~3.5 GB).
- Keep the boards project file: approved boards are the production layout,
  so the animation pass only adds keys to already-approved geometry.

**Frame review runs against `references/aesthetic-canon.md`** — sourced
rules from the Digital Agency of Japan (JP type tokens), Material Design 3
(motion easing/duration tokens), Disney's twelve principles, and Rams' ten
principles. Name the violated rule when a frame fails.

See `references/production-playbook.md` for the full playbook and the GRAND2
case study (v1 generic → v2 noise soup → v3 stock mush → v4 render-leak saga)
with the concrete failure modes these rules exist to prevent.
