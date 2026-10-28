# EffectCraft bugs and workarounds (0.17.0, Windows, verified 2026-10-27)

No hanging or corrupting defect reproduced so far. These are the behaviors
that *look* like bugs, bite agents, and have verified workarounds — keep the
reproductions, they double as regression tests.

## 0. Long advanced3D renders leak memory — segment them (verified)

A 30 s / 900-frame render with `renderer: "advanced3D"` (3D layers, CC
Particle World, many Glows) dies with `memory allocation of ~1–2.3 GB failed`
after ~4–6 s of timeline, even with 30 GB free (allocation grows per frame;
`--gpu` does not help; PNG-sequence output does not help). Single
`render-frame` calls always succeed.

**Workaround:** render in ~1 s segments (each a fresh process — memory
resets) into PNG sequences, then unify numbering and encode with ffmpeg:

```sh
effectcraft-cli --project p.ecproj render --out "segNN/f_%04d.png" --format png --start 0 --end 1
# …per segment, then:
ffmpeg -framerate 30 -i all/FR_%06d.png -c:v libx264 -b:v 15M -pix_fmt yuv420p out.mp4
```

Segment PNGs embed the `--out` pattern literal in the filename. 2D-only
comps of the same length render fine in one go.

## 0b. `layer.timing` does not gate layers headless (verified)

`layer.timing {layers, in, out}` windows were silently ignored on image
layers (the layer kept rendering outside the window). **Workaround:** gate
with hard `transform.opacity` keys (`t_in-1frame: 0 → t_in: 100 →
t_out-1frame: 100 → t_out: 0`) — frame-accurate and reliable.

## 0c. CC Particle World uses native AE paths, not registry names (verified)

`list_effects` flattens names ("Velocity", "Birth Size"), but `prop.set`
needs the real tree: `physics/velocity`, `physics/gravity`,
`particle/birthSize`, `particle/birthColor`, `producer/radiusX`, `birthRate`,
`longevity`. Get truth with `props - <layer> --flat`.

## 0d. 3D primitives take no effects (verified)

`effect.apply` on a `layer.new3dPrimitive` layer errors with "this layer type
has no effects". Fake glow with a blurred 2D solid.

## 0e. Before the first keyframe, layers show their STATIC value (verified)

A layer whose first `transform.opacity` key sits at t=19.6 (value 100) renders
at opacity 100 for 0–19.6 s. Gate every appearing layer with a `t=0: 0` key
**and** add a plateau key just before its entrance (`t_in-1frame: 0`), else
opacity ramps linearly from the gate key (ghosting through every scene).

## 1. Write/read time bases are asymmetric (verified)

**Repro**

```sh
effectcraft-cli --empty run \
  file.newProject '{}' \
  comp.new '{"name":"T","width":640,"height":360,"frameRate":30,"duration":10}' \
  layer.newSolid '{"name":"S","color":"#ff0000","width":640,"height":360}' \
  'layer.timing' '{"layers":["S"],"start":2}' \
  'prop.addKey' '{"layer":"S","path":"transform.scale","time":0,"value":[10,10]}' \
  'prop.get'     '{"layer":"S","path":"transform.scale","time":5}' \
  --json
```

The key added with `time:0` lands at `"compTime":2.0, "layerTime":0.0` —
write commands default to **layer** seconds (`timeBase:"layer"`), while
`prop.get`'s `time` is **comp** seconds.

**Workaround:** pass `timeBase:"comp"` on every `prop.addKey` / `keys.set` /
`prop.set` that touches a layer that doesn't start at 0, or convert by hand.
`prop.get` always reports both `compTime` and `layerTime` per key — trust that
over mental math.

## 2. Layer ids are project item ids and skip numbers (verified)

`comp.new` → `{comp:1}`, `layer.newText` → `{layer:2}`, but `layer.newSolid`
→ `{layer:4}`: a solid also creates a Solid footage item, consuming ids.
Guessing "the next id" fails with *no layer 2 (use a layer id, "#n" or a name
from comp.info)*.

**Workaround:** always capture the returned id, or address by name / `#n`
stack index. The error message itself suggests `comp.info` for valid ids.

## 3. Selection-dependent commands appear "missing" (verified)

With nothing selected, `prop.set`, `effect.apply`, `keys.easyEase`,
`layer.transform`, `anim.applyPreset` … report `enabled:false` in
`command_list` (295 of 734 in a fresh headless context: roto, puppet, paint,
track, mask-editing, per-key ops …). They run fine when the context exists.

**Workaround:** pass explicit `layer`/`layers`/`keys` params (verified:
`effect.apply {"effect":"Gaussian Blur","layers":[2]}` works headless with no
selection), or `layer.select` / `keys.select` first, or `comp.open` the comp.
Don't filter the catalog to `--enabled` only — you'd hide half the surface.

## 4. Strict parameter validation (opposite of FilmCraft)

`comp.new {"bogusParam":123}` →
`invalid parameters for 'comp.new': unknown parameter(s) 'bogusParam';
accepted: name, width, … (doc: {…})` — hard error, run stops.

**Workaround:** none needed — this is a feature. Read the accepted list from
the error, fix the call. But it also means `run` sequences stop at the first
bad command; use `batch` (one undo step) or `run --args-file` and re-run the
tail. Note MCP *tool* args and command *params* are both strict here.

## 5. Property paths need the group (verified)

`prop.get {"path":"position"}` → *no property `position`*. Both
`transform.position` and `Transform/Position` work.

**Workaround:** dump real paths with `props <comp> <layer> --flat` or
`get_layer`; `prop.get`'s `match:"position"` shows the canonical leaf name.

## 6. `render-frame` before any comp exists (verified)

Fresh `--empty` session, no `comp.new`:
`effectcraft-cli render-frame: no active composition: create one
(execute_command comp.new) or open a project` — exit 1, no output file.

**Workaround:** create/open a comp in the same session first (each CLI
invocation is its own session — build and render in one `run`, or save and
re-open with `--project`).

## 7. ExtendScript surface is AE-like, not AE-exact (verified)

`Property.key(n)` (which real AE does not have either) → `TypeError: not a
callable function`. `keyValue`, `setValueAtTime`, `app.project.activeItem` all
work.

**Workaround:** stick to classic AE scripting APIs; on error the CLI prints
`file:line:col` — fix and re-run. `expr.errors {comp}` lists expression
errors inside the project.

## 8. Relative `--out` resolves against the process cwd

From `--help`: "a relative --out is relative to the working directory". An
agent's cwd is often not where the user expects media.

**Workaround:** always pass absolute paths for `--out`, `--save-as`,
`--project`, and `file.import`'s `paths`.

## 9. `layer.moveEarlier/moveLater` move TIME, not stacking order (verified)

Calling them on a footage layer changed nothing visually — they shift the
layer's timeline position, not the stacking index. **There is no stacking
reorder command.** The stacking order = creation order. Design the build
script's creation sequence (background solids first, photos, texts on top),
or delete and re-add the layer at the right time.

## 10. `--save` flag can abort a `--empty` session (verified)

`effectcraft-cli --empty --save-as F run <cmds> --save` errors with
`file.save: no path` (--empty has no in-place path) and the run's changes
are lost. `--save-as` alone persists correctly. For sessions opened with
`--project F`, prefer an explicit trailing engine command
`file.saveAs {"path": F}` in the args file over the `--save` flag.

## Doc-vs-binary deltas (keep honest)

| Doc/help claim | Observed |
|---|---|
| `--help` documents `run --args-file F` | not exercised here; JSONL-per-line semantics assumed from help text |
| `render --template T.ectemplate` | flag verified in help; no template job run in this pass |
| `bench --ops` | not exercised |
| bridge "36 tools" | counted via `tools/list` over `--bridge 50052`, GUI running |
