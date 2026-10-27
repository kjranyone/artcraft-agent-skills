# EffectCraft recipes (verified on 0.17.0, Windows, 2026-10-27)

Every block below was run against the real engine (headless unless marked
**bridge**) and the result is what the engine returned. Times are **seconds**
(floats; no tick math). CLI form shown; MCP `command_run {id, params}` is
equivalent, `batch`/`command_batch` wrap several steps in one undo.

## 1. New project → comp → styled text → save

```sh
effectcraft-cli --empty --save-as /tmp/t.ecproj run \
  file.newProject '{}' \
  comp.new '{"name":"Test","width":1920,"height":1080,"frameRate":30,"duration":5}' \
  layer.newText '{"text":"Hello EffectCraft","size":120,"fill":"#ff5533","position":[960,540]}' \
  --json
```

```jsonc
[{"command":"file.newProject","result":null},
 {"command":"comp.new","result":{"comp":1}},          // and comp 1 is now active
 {"command":"layer.newText","result":{"layer":2}}]    // layer ids are project-wide, not per comp
// + {"saved":"C:/…/t.ecproj"} when --save-as is given
```

`comp.new` also takes `background:"#000000"|[r,g,b]`, `renderer:
"classic3D"|"advanced3D"`, `startTimecode:"00:00:02:00"`, `open:true`.
`layer.newText` styling params: `font, style, size, fill, stroke,
strokeWidth, tracking, leading, justify, fauxBold, fauxItalic, allCaps,
box:[x,y,w,h]` (paragraph text), `vertical:true` … (full list:
`describe_command layer.newText`).

## 2. Keyframes + easing + read-back

```sh
effectcraft-cli --project /tmp/t.ecproj run \
  prop.addKey '{"layer":2,"path":"transform.position","time":0,"value":[200,540]}' \
  prop.addKey '{"layer":2,"path":"transform.position","time":3,"value":[1700,540]}' \
  keys.setEase '{"layer":2,"path":"transform.position","time":0,"side":"out","influence":66}' \
  prop.get     '{"layer":2,"path":"transform.position","time":1.5}' \
  --json
```

```jsonc
{"command":"prop.addKey","result":1}                  // key index
{"command":"prop.get","result":{
  "animated":true,"expression":null,
  "keys":[{"compTime":0.0,"in":"Linear","layerTime":0.0,"out":"Bezier","time":0.0,"value":[200.0,540.0,0.0]},
          {"compTime":3.0,"in":"Linear","layerTime":3.0,"out":"Linear","time":3.0,"value":[1700.0,540.0,0.0]}],
  "layer":2,"match":"position","name":"Position","time":1.5,"type":"vec3","uid":23,
  "value":[949.9999999999906,540.0,0.0]}}             // interpolated at t=1.5 → x=950
```

Notes: `time` on write commands is **layer seconds** by default
(`timeBase:"comp"` switches); `prop.get`'s `time` is comp seconds. Paths:
`transform.position` ≡ `Transform/Position`; bare `position` →
*no property `position`*.

## 3. Effects: apply, set params, registry

```sh
effectcraft-cli --project /tmp/t.ecproj run \
  effect.apply '{"effect":"Gaussian Blur","layers":[2]}' \
  --json
```

```jsonc
{"effect":"ec.blur.gaussian","effects":[41],"paths":["effects/#1"]}
```

- Address the effect by registry id (`ec.blur.gaussian`) or AE name
  (`"Gaussian Blur"`); `layers:[ids]` avoids needing a selection (the command
  is disabled with nothing selected).
- Parameters are properties under the returned path:
  `prop.set {"layer":2,"path":"effects/#1/Blurriness","value":12}`.
- Registry: MCP `list_effects` → 307 entries
  `{"category":"3D Channel","float":true,"gpu":true,"id":"ec.3d.channelextract",
    "name":"3D Channel Extract","params":[{"default":0,…}]}`; narrow with
  `category`/`filter` args.

## 4. Shapes, solids, nulls, precomps

```jsonc
{"id":"layer.newShape","params":{"kind":"star","size":[400,400],"fill":"#2266ff","position":[960,540]}}
{"id":"layer.newSolid","params":{"name":"BG","color":"#101418","width":1920,"height":1080}}
{"id":"layer.newNull","params":{"name":"Controller"}}          // parent things to it
{"id":"layer.addItem","params":{"item":41,"time":0}}           // existing project item into the active comp
{"id":"layer.setTransform","params":{"layers":[2],"prop":"scale","value":[80,80]}}
{"id":"layer.setText","params":{"layer":2,"size":96,"fill":"#ffffff","tracking":50}}
{"id":"layer.moveLater","params":{"layers":[2]}}               // down the stack; moveEarlier = up
```

Shape `kind`: `rect|rounded|ellipse|star|polygon|none`. Text animators:
`layer.addTextAnimator`, selectors `text.addSelector`.

## 5. Expressions (AE JavaScript)

```sh
effectcraft-cli --project /tmp/t.ecproj run \
  prop.setExpression '{"layer":2,"path":"transform.position","expression":"wiggle(2, 30)","enabled":true}' \
  prop.convertExpressionToKeyframes '{"layer":2,"path":"transform.position"}' \
  expr.errors '{}' \
  --json
```

`prop.pickWhip {layer, path, target:{layer, path, dimension}}` writes an AE
reference expression between properties. `expr.errors {comp}` lists current
expression errors.

## 6. ExtendScript (After Effects object model)

```sh
effectcraft-cli --project /tmp/t.ecproj script --eval \
  'app.project.activeItem.name + " / " + app.project.items.length + " items"'
# → "Test / 1 items"

effectcraft-cli --project /tmp/t.ecproj script --eval \
  'var l = app.project.activeItem.layer(1);
   l.property("Transform").property("Position").setValueAtTime(4, [960, 540]); "ok"'
# → "ok"
```

MCP `run_script {code}` → `{"error":null,"ok":true,"output":"","result":8}`.
`.jsx` files: `script file.jsx [project.ecproj]`; errors exit 1 with
`file:line:col`. Mind AE method surface — e.g. `Property.key(n)` does not
exist here (`TypeError: not a callable function`); use `keyValue(n)`.

## 7. Render frame / export

```sh
# one PNG (any time; --transparent for RGBA, --max-side to downscale)
effectcraft-cli --project /tmp/t.ecproj render-frame --out /tmp/f.png --time 1.5 --max-side 480
# rendered 480x270 at 1.500s in 3.7 ms -> C:/…/f.png

# H.264 (formats: h264|hevc|av1|prores|uncompressed|webm|png|jpeg|tiff|exr|gif|wav|aiff)
effectcraft-cli --project /tmp/t.ecproj render --out /tmp/t.mp4 --format h264 --start 0 --end 3
# Test → C:/…/t.mp4 (1920×1080, 90 frames, H.264 - Match Render Settings - 15 Mbps)
# done: Test → C:/…/t.mp4 in 1.10s
```

Via commands: `renderQueue.add {comp, format:"h264", output:"/tmp/t.mp4",
timeSpan:"workArea"|"comp"|"custom", start, end, …}` then
`renderQueue.render {wait:true}`. Image sequences: `--format png` with a
`--out` pattern. Templates: `render --template t.ectemplate --values v.json`.
Absolute `--out` always — relative goes to the process cwd.

## 8. Demo project (what's in it)

```sh
effectcraft-cli --demo info
```

```text
734 commands, 307 effects
item 92  Composition  Lower Third
item 502 Composition  EffectCraft Intro   ← active, 1920x1080 @ 29.97, 10.01 s
item 879 Composition  3D Showcase
  #1 Composition Lower Third  #2 Text EFFECTCRAFT  #3 Text Tagline
  #4 Shape Accent Line  #5 Shape Tick Burst  #6 Shape Orbit Rings
  #7 Null Controller  #8 Solid Background
```

Good for effect/animation experiments and `render-frame` targets; layers are
addressed by id (362, 438, …), `#n`, or name.

## 9. Live GUI bridge (verified on the desktop)

```powershell
# start (visible desktop window) — scripts/launch.ps1 wraps this
& "C:\Program Files\EffectCraft\effectcraft.exe" --control 50052
# or persist the port: [Environment]::SetEnvironmentVariable('EFFECTCRAFT_CONTROL_PORT','50051','User')

effectcraft-cli --bridge 50052 info      # EffectCraft 0.17.0 (bridge), 734 commands, 307 effects
```

- No control token is required (verified plain connection; no
  `EFFECTCRAFT_CONTROL_TOKEN` exists in the binaries — unlike FilmCraft).
- Bridge MCP exposes 36 tools: the headless 27 plus `ui_inspect`,
  `ui_elements`, `ui_click`, `ui_drag`, `ui_key`, `ui_set`, `ui_type`,
  `screenshot`, `control`, `script_ui`.
- `ui_inspect` → `{"activeComp":null,"dialog":null,"elements":108,"fps":108.6,
  "keyboardFocus":null,"pixelsPerPoint":1.75,"playing":false,"selectedKeys":0,
  "selectedLayers":[],"time":0.0,"ui":{…full panel state…}}`
- `screenshot {}` → image content block (PNG, window-size) + text
  `{"height":971,"path":null,"width":1600}`.
- Clean shutdown: `command_run {"id":"app.quit"}` (verified: process count 0).

## 10. Fonts

MCP `list_fonts` → `{"added":[…],"count":…,"families":[
{"family":"Arial","origin":"system","styles":["Narrow","Regular","Bold",…]},…]}`
— 149 families on the reference machine. `origin` is `system` or `bundled`;
pass `font` + `style` to `layer.newText`/`layer.setText`.
