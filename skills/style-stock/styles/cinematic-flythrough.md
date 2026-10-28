# Cinematic Flythrough

Reference lineage: dark 3D environment flythroughs — advanced3D camera
travel through fog and depth (verified in EffectCraft: 48-photo Z-corridor
builds; render in ~1 s segments due to the memory leak — see EffectCraft
bugs §0).

## Palette (tokens)

| Token | Hex | Usage |
|---|---|---|
| void | `#04060c` | comp background |
| fog | `#0b1526` | Fog3D / atmosphere tint |
| light | `#2f7bff` | key lights, edge rim |
| card-grade | teal-orange tritone | photo cards |

## Type system

- In-world text planes: JP Bold 120 px on `layer.newText` + 3D switch,
  rotationY ±15-28°, positioned x ±430-560 in the corridor.
- Overlay copy: 2D, left-anchored x=170.

## Composition patterns

1. **Corridor** — 8 photo cards alternating x ±430-560, z −1400…−4300,
   rotationY ∓15-22°, camera flies −1180→−4750 over 5 s.
2. **Hero island** — torus/sphere primitives (radius 240/105) slowly
   rotating, lit by Ambient 95, in the void before the corridor.
3. **Numbers as architecture** — giant service words as 3D text planes
   between cards.

## Motion grammar

- Camera: one continuous flight per scene; keyframes on z only (x wobble
  ±30), ease-out at starts, ease-in at ends; NO cuts mid-flight.
- Photo cards: pop visibility with hard opacity cuts (2 frames), drift
  scale ±8% during their window.
- DOF: camera `dof: false` (leak-prone); fake depth with per-layer opacity
  distance steps instead.

## Sound

Continuous drone/build across the flight; impacts only at card passes;
silence the beat before the drop.

## EffectCraft recipe

- comp `renderer: "advanced3D"`; `layer.newCamera` oneNode 35mm `dof:false`.
- `layer.new3dPrimitive` torus/sphere; NO effects on primitives (unsupported
  — fake glow with blurred 2D solid).
- Corridor photos: `layer.addItem {index:2}` immediately after init (before
  any solids), `layer.setSwitch threeD true`.
- **Render in ~1 s segments to PNG + ffmpeg mux** — long advanced3D renders
  leak memory ( EffectCraft bugs §0 ).

## Anti-patterns

- Flat 2D slides inside the 3D comp; static camera; cuts mid-flight.
- Applying effects to 3D primitives (fails).

## Best for

scale/future messaging, game/tech openers, flagship brand moments. Highest
render cost — use for 1-2 hero sequences, not whole videos.
