# EffectCraft bugs and workarounds (0.17.0, Windows, verified 2026-10-27)

No hanging or corrupting defect reproduced so far. These are the behaviors
that *look* like bugs, bite agents, and have verified workarounds — keep the
reproductions, they double as regression tests.

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

## Doc-vs-binary deltas (keep honest)

| Doc/help claim | Observed |
|---|---|
| `--help` documents `run --args-file F` | not exercised here; JSONL-per-line semantics assumed from help text |
| `render --template T.ectemplate` | flag verified in help; no template job run in this pass |
| `bench --ops` | not exercised |
| bridge "36 tools" | counted via `tools/list` over `--bridge 50052`, GUI running |
