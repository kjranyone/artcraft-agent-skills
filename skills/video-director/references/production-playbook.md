# Production playbook — video-director

Distilled from the GRAND2 30 s teaser project (2026-10-27): four full builds
(2D slide show → kinetic slam → photo glitch teaser → 3D camera journey) and
one user rejection that reset the process. Every rule in SKILL.md exists
because one of these failures happened.

## Case study: how the rejection happened

| Build | What it was | Why it was rejected |
|---|---|---|
| v1 | Clean slides, fades only | **No point of view.** Safe defaults = generic. Rejected as "表現力ゼロ" |
| v2 | Kinetic slams, RGB split, impact flashes | **Noise, not design.** Effects applied everywhere; nothing anchored the brand |
| v3 | Site photos + tritone + glitch | **Stock-photo mush.** 446 px portraits blown to 500% = blur; smiling-suit cliché; scanline/grain/gritch all at once; text overlap left in |
| v4 | advanced3D camera flight through photo corridor | **Right ambition, unmanaged risk.** Renderer memory leak forced 40 min of segmented rendering; composition still had face crops and edge-cut type; silent |

The rejection was correct at every stage. Root causes, in order of impact:

1. **No approval gate.** Four full builds were made before taste was checked
   once. Boards cost minutes; builds cost hours.
2. **No sound plan.** A teaser is 50% sound. Building picture first and
   "adding audio later" guarantees cuts that sync to nothing.
3. **Asset audit skipped.** The site's photos are web-sized (400–1100 px).
   Designing 1080 p full-frame pans around them was doomed before the first
   keyframe.
4. **Effects as compensation.** When the design felt weak, the reflex was to
   add glow/particles/glitch. It never makes weak composition strong; it
   makes weak composition loud.
5. **Director blind spots.** The agent verified frames technically (colors,
   text presence) but not editorially (would this pass on a company site?).
   Self-review must be editorial first, technical second.

## Board spec (P1)

- Built **in the production tool** (EffectCraft), full 1920×1080 — an
  approved board is then the production layout; the animation pass only adds
  keys to approved geometry.
- One message per board. If a board needs two sentences to explain, split it.
- Include: timecode range, verbatim copy, motion intent (one line), asset
  name + how it is cropped.
- Present a 2×4 contact sheet plus individual full-res links. Ask approval on
  **copy wording, asset usage, narration/BGM, and any faces shown** — those
  are the client's calls, not the director's.
- Known layout traps (verified): multi-logo strips contain repeated logo sets
  — compute the offset so ONE full set sits centered and the repeat set is
  off-frame; portrait photos crop faces unless position-y is tuned per photo;
  a text layer's static value shows before its first keyframe (gate + plateau
  keys — see EffectCraft bugs).

## Animatic (P2)

Minimum: the timing table (timecode × copy × motion) written in the message —
it exposes dead seconds and wall-to-wall text for free. Better: a real
preview render at reduced resolution/quality. Check: no two adjacent scenes
with the same motion grammar; silence beat present; end card ≥ 2.5 s.

## Sound (P4)

- User BGM: get the file, mark beat grid, snap scene boundaries to beats.
  Cut on beat, land the payoff on the drop.
- Narration (sttts-say): `narrator` voice for corporate tone; write the
  script first, approve it as text, then synthesize; keep per-line WAVs so
  timing can be nudged.
- Silence: only with explicit user acceptance, and say "silent cut" in the
  delivery report.

## Self-review (P5) — editorial first

1. Describe every 2 s span in one plain sentence, as a stranger would see it.
2. Flag: two adjacent scenes with identical grammar; any text overlap; any
   effect visible in every scene (it stopped being an accent); any face or
   logo cropped; any sentence a client would not sign.
3. Only then technical QC: exact duration, codec, ftyp/mvhd validation, first
   and last frame, audio loudness not clipping.

## Postmortem (P6)

Append new tool defects to the app skill's `bugs-and-workarounds.md` (e.g.
advanced3D render leak → segment renders; `layer.timing` ignored; CC Particle
World native paths; static-before-first-keyframe; 3D primitives take no
effects). Append design/process failures to this playbook. A rejection that
produces no rule change will repeat.
