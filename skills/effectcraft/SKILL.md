---
name: EffectCraft
description: Use whenever working with EffectCraft on this machine — the Rust motion-graphics / VFX compositor and After Effects alternative — including launching the app with control port ("EffectCraftを起動", "EffectCraftを立ち上げて", "launch EffectCraft"), creating or editing compositions, layers, keyframes, masks, tracking, rotoscoping, effects and text (.ecproj, MP4/MOV/WebM/ProRes/EXR/PNG sequences, .ectemplate, .ecpreset, ExtendScript/.jsx), driving the running desktop window, or using its MCP server, effectcraft-cli or control channel. Triggers on "EffectCraft", "effectcraft-cli", "effectcraft mcp", "EffectCraft MCP", "EffectCraftを起動", "EffectCraft立ち上げて", "EffectCraft開いて", "make a motion graphic", "animate this text", "add an effect", "track this shot", "rotoscope", "export to MP4/ProRes/EXR", "take an EffectCraft screenshot", and requests to automate motion graphics, VFX or EffectCraft itself. Invoke with @effectcraft.
---

# EffectCraft — agent operation

EffectCraft is a native Rust motion-graphics / VFX compositor (After
Effects-class) whose agent interface is built in: **every action is a command
with an id**. The GUI, menus, the CLI, the control channel and the MCP server
all drive one engine. Verified against **0.17.0** on Windows.

## Setup (agent: run before first use)

Check that EffectCraft CLI is installed and compatible:

```bash
effectcraft-cli --version   # expect 0.17.x
```

- If command not found: tell the user "EffectCraft is not installed. Download from https://getartcraft.com/apps/effectcraft"
- If version < 0.17: warn about API differences (see bugs-and-workarounds.md)
- If version ≥ 0.18: check bugs-and-workarounds.md for breaking changes

## Machine & environment paths

| Platform | Binary | CLI | Default Data Dir |
|---|---|---|---|
| **Windows** | `C:\Program Files\EffectCraft\effectcraft.exe` | `C:\Program Files\EffectCraft\effectcraft-cli.exe` | `%LOCALAPPDATA%\EffectCraft` (Disk Cache) |
| **Linux** | `/usr/bin/effectcraft` | `/usr/bin/effectcraft-cli` | `~/.local/share/effectcraft` |

- **Control port:** `--control <port>` or `EFFECTCRAFT_CONTROL_PORT` (no token — the bridge accepts plain loopback connections, unlike FilmCraft)
- **Commands:** **734 in 55 namespaces** (439 enabled in a fresh headless context; the rest need a selection / active comp / tool mode)
- **Effects:** **307** in the registry (`list_effects`); **149 font families** (`list_fonts`)

## Mental model

- A **project** (`.ecproj`) holds items: `Composition`, `Folder`, `Solid`,
  `Footage`. `get_project` returns the item tree, the dirty flag and the active
  comp. One comp is **active**; most commands act on it.
- A **comp** is `{width, height, frameRate, duration, startTime, background,
  renderer: classic3D|advanced3D}`. **Times are seconds** (floats, not ticks —
  no tick math here, unlike FilmCraft).
- A **layer** is Text, Shape, Solid, Null, Composition (precomp), Adjustment,
  Light or Camera. Layers stack 1 = top. Address layers by `id`, `#n` (stack
  index) or `name`.
- Every layer has a **property tree**: `Transform` (`anchor, position, scale,
  rotation, opacity`), plus `effects`, `masks`, text or shape `contents`.
  Property paths accept `transform.position` and `Transform/Position` — but a
  bare `position` (no group) is rejected.
- **Animation** = keyframes on properties (`prop.addKey`) or **expressions**
  (`prop.setExpression`, AE JavaScript). `prop.get {time}` returns the
  interpolated value, the key list and the `animated` flag.
- **Parameters are validated strictly**: an unknown parameter name fails the
  command with the accepted-key list; so does an unknown command id. This is
  the *opposite* of FilmCraft's silently-dropped params — read the error, fix
  the call, don't retry blind.
- **Verify by reading back** (`get_state`, `get_project`, `get_comp`,
  `get_layer`, `get_property`) or by rendering (`render_frame` — a PNG catches
  wrong positions, invisible layers and missing effects that no read-back shows).

## Two connection modes

| Mode | Start | Use for |
|---|---|---|
| Headless | `effectcraft-cli mcp --demo` (`--project p.ecproj`, `--empty`, `--autosave`) | no window, batch builds, renders, scripts |
| App bridge | `effectcraft --control 50052` + `effectcraft-cli mcp --bridge 50052` | the real window: UI state, screenshots, clicks, keys, GUI-only commands |

**Each CLI invocation is its own session.** State built in one `run` is gone
when the process exits — finish with `file.saveAs` + `--save-as`, or do
everything (build → render) in a single `render`/`run` invocation.

### Launching EffectCraft on user request ("起動して" / "start EffectCraft")

1. **Check if already running:** `Get-Process effectcraft` / `pgrep effectcraft`.
   If running, test the port: `effectcraft-cli --bridge 50052 info`.
   If running *without* a control port, ask the user to restart it with
   `--control` (unsaved work would be lost otherwise).
2. **Launch with `--control <port>` (default `50052`):**
   - Windows — **use `scripts/launch.ps1`** so the window appears on the
     visible desktop instead of a background session:
     `powershell -File scripts/launch.ps1 -Port 50052`
   - Linux: `./scripts/launch.sh 50052`
3. **Verify:** wait 1–3 s, then `effectcraft-cli --bridge 50052 info` — it
   prints the version, command/effect counts and the open project.

## The MCP tools

Headless exposes **27** tools; the bridge adds **9 UI tools** (`ui_inspect`,
`ui_elements`, `ui_click`, `ui_drag`, `ui_key`, `ui_set`, `ui_type`,
`screenshot`, `control`) plus `script_ui` for ScriptUI dialogs = **36**.

| Tool | Purpose |
|---|---|
| `command_list` / `list_commands` | every command (`--filter`, `--enabled`) |
| `command_run` / `execute_command` | run one `{id, params}` (undoable) |
| `command_batch` / `batch` | several commands, one undo step (`batch`) |
| `describe_command` | one command's schema |
| `doc_inspect` / `get_project` | project tree + active comp in one call |
| `get_comp` | one comp: settings, layers, work area |
| `get_layer` | a layer's full property tree |
| `get_property` / `set_property` | read / write one property (set keys when animated) |
| `add_keyframe` | keyframes for a property (turns the stopwatch on) |
| `add_effect` / `list_effects` | apply an effect (+params in one call) / the 307-effect registry |
| `list_fonts` | 149 font families usable by text layers |
| `run_script` | After Effects-style ExtendScript (`app.project`, comps, layers) |
| `render_frame` / `render_preview` | PNG of the (active) comp at `time` |
| `open_project` / `save_project` | open (`path`, `demo:true`, `empty:true`) / save (+Save As) |
| `undo` / `redo` / `history` | branching undo history |
| `get_state` | active comp, current time, selection, playback |
| `script_ui` | drive ScriptUI dialogs/palettes scripts opened |

Resources: `effectcraft://document` and `effectcraft://commands`.

## Standard workflow

1. **Probe.** `get_state` + `get_project`; headless starts empty unless
   `--demo`/`--project`. `ui_inspect` first in bridge mode.
2. **Build.** `comp.new {name,width,height,frameRate,duration}` →
   `layer.newText/newShape/newSolid/newNull` (styling params inline) →
   `file.import {paths}` for footage → `layer.addItem`-style placement.
3. **Animate.** `prop.addKey {layer,path,time,value}` per key;
   `keys.setEase`, `keys.interpolation`, `prop.setExpression`.
4. **Style.** `effect.apply {effect:"Gaussian Blur", layers:[id]}` +
   param paths under `effects/#1/...`; masks (`mask.new`), text animators,
   shape gradient strokes.
5. **Verify.** `get_property` at telling times; `render_frame` at those times
   and look at the PNGs (position, easing and blur are all visible).
6. **Render.** `render --out file.mp4 --format h264` (CLI), or
   `renderQueue.add` + `renderQueue.render`; `render-frame --transparent` for
   RGBA; `render --template t.ectemplate --values v.json` for template jobs.
7. **Save.** `file.saveAs {path}` (or CLI `--save-as`); re-read
   `get_project` — the dirty flag clears after save.

## Finding commands

`command_list {filter:"mask"}` matches id, label and menu. From a shell:
`effectcraft-cli commands --filter mask`, and `describe_command`/`describe`
for one command's schema. All 734 ids with parameter docs are in
`references/catalog/commands.md`; verified step-by-step JSON is in
`references/recipes.md`.

Start with: `comp.new`, `comp.settings`, `comp.open`, `layer.newText`,
`layer.newShape`, `layer.newSolid`, `layer.newNull`, `layer.select`,
`layer.moveLater`, `layer.setTransform`, `layer.setText`, `prop.get`,
`prop.set`, `prop.addKey`, `keys.setEase`, `keys.interpolation`,
`prop.setExpression`, `effect.apply`, `mask.new`, `time.set`,
`file.import`, `file.saveAs`, `renderQueue.add`, `renderQueue.render`,
`app.quit`.

## Pitfalls that cost time

1. **Strict validation everywhere.** Unknown param → `invalid parameters …
   accepted: name, width, …` with the full key list; unknown command id →
   `unknown command`. Errors are the documentation — but a *valid* param with
   a wrong value type can still misbehave, so read state back.
2. **Layer time vs comp time.** Write commands (`prop.addKey`, `keys.set`,
   `prop.set`) take `time` in **layer seconds** by default
   (`timeBase:"layer"|"comp"` switches); `prop.get` reads `time` in **comp
   seconds**. With a layer starting at 0 they coincide; after `layer.move`
   they don't. Wrong base = keys silently offset by the layer start.
3. **Many commands need a selection.** `prop.set`, `effect.apply`,
   `keys.easyEase` show `enabled:false` with nothing selected (headless starts
   empty). Pass explicit `layer`/`layers` params, or `layer.select` first.
4. **`comp.new` returns `{comp: id}` and makes it the active comp** (verified:
   two `comp.new` calls, a text layer lands in the second). Switch with
   `comp.open {comp: id|name}` and confirm via `get_state` — commands and
   renders that target "the active comp" fail with *no active composition*
   on a fresh `--empty` project before the first `comp.new`.
5. **Property paths need the group**: `transform.position` /
   `Transform/Position` work, bare `position` errors with *no property*.
   Find exact paths with `props <comp> <layer> --flat` or `get_layer`.
6. **Effect params are paths under the effect**, e.g.
   `effects/#1/Blurriness` (index = application order). `effect.apply`
   returns `paths:["effects/#1"]` — use them.
7. **Each CLI invocation is a fresh session** (see above). MCP sessions keep
   state until the server exits.
8. **`render` writes relative `--out` to the process working directory**;
   always pass an absolute path for predictable output.
9. **Text layers take full styling at creation** (`layer.newText
   {size,fill,tracking,…}` — dozens of params). Later restyling goes through
   text source/document properties; check `get_layer` for the exact paths.
10. **GUI-only surface**: `ui_*`, `screenshot`, `control`, `script_ui` exist
    only on the bridge; `window.*`, `view.*` and `help.*` mostly need the GUI.
11. **`mcp --autosave`** persists unsaved headless edits on exit; without it
    they are lost (expected for throwaway runs, surprising for real work).

## Reference map

| File | Contents |
|---|---|
| `references/recipes.md` | verified JSON: build, text, shape, keyframes, easing, expressions, effects, masks, render, export, GUI |
| `references/catalog/commands.md` | all 734 commands grouped by namespace with parameter docs |
| `references/mcp-and-control.md` | the 27+9 tools, error shapes, resources, bridge details |
| `references/cli.md` | `effectcraft-cli` subcommands, render formats, templates, bench |
| `references/bugs-and-workarounds.md` | reproduced defects with minimal reproductions |
| `references/maintenance.md` | re-verify the version, dump commands, refresh this skill |
| `scripts/probe.sh` / `.ps1` | MCP handshake + tool count + version |
| `scripts/dump-commands.sh` / `.ps1` | regenerate the command catalog |
| `scripts/launch.sh` / `.ps1` | start the GUI with a control port (visible desktop) |
| `scripts/smoke-test.sh` / `.ps1` | build → keyframe → render → validate |

Community: <https://discord.gg/artcraft> · <https://getartcraft.com/apps/effectcraft>.
