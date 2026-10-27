# EffectCraft MCP and control channel (verified on 0.17.0, Windows)

## Starting the server

| Mode | Command | Tools |
|---|---|---|
| Headless | `effectcraft-cli mcp [--demo | --project p.ecproj | --empty] [--autosave] [--automation-read-root DIR] [--automation-write-root DIR]` | 27 |
| Bridge | `effectcraft --control 50052` then `effectcraft-cli mcp --bridge 50052` | 36 |

JSON-RPC over stdio, one message per line. Initialize with
`{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{…}}}`,
send `notifications/initialized`, then `tools/list` / `tools/call` /
`resources/list`.

- Server info: `effectcraft 0.17.0`, protocol `2025-06-18`, capabilities
  `tools`, `resources`.
- Resources: `effectcraft://document` (project + active comp),
  `effectcraft://commands` (catalog). No prompts.
- Tool arguments are strict; tool results return `content[0].text` JSON unless
  noted (`screenshot` adds an image block first).

## The 27 headless tools

Friendly and FilmCraft-style aliases exist side by side — either works:

| Friendly | Alias | Purpose |
|---|---|---|
| `list_commands` | `command_list` | every command (`filter`, `enabled_only`) |
| `describe_command` | — | one command + JSON Schema of its params |
| `execute_command` | `command_run` | run `{id, params}` (undoable) |
| `batch` | `command_batch` | several commands as ONE undo step; later steps can use earlier ids |
| — | `doc_inspect` | project overview + active comp in one call |
| `get_project` | — | items, dirty flag, active comp |
| `get_comp` | — | one comp: size, fps, duration, work area, layers |
| `get_layer` | — | a layer's property tree (transform, effects, masks, text…) |
| `get_property` | — | one property: value at `time`, keys, expression |
| `set_property` | — | write a value (or a key when animated / `time` given) |
| `add_keyframe` | — | keys for a property (stopwatch on) |
| `add_effect` | — | apply an effect + set params in one call |
| `list_effects` | — | registry: id, AE name, category, GPU/32-bpc, params |
| `list_fonts` | — | families + styles + origin |
| `run_script` | — | ExtendScript (`app.project` object model) |
| `render_frame` | `render_preview` | comp frame as PNG image block |
| `open_project` | — | `path` / `demo:true` / `empty:true` |
| `save_project` | — | save (or Save As to `path`) |
| `get_state` | — | active comp, time, selection, playback, panels |
| `undo` / `redo` / `history` | — | branching undo history |
| `script_ui` | — | drive ScriptUI dialogs/palettes scripts opened |

## The 9 bridge-only UI tools

`ui_inspect` (window state, element count, selection, playback, fps),
`ui_elements` (on-screen elements with id/label/rect), `ui_click`, `ui_drag`,
`ui_key`, `ui_set`, `ui_type`, `screenshot` (PNG image block + `{width,height}`
text), `control` (any control method). Note the names differ from FilmCraft's
`ui_screenshot`/`ui_control` — here they are `screenshot` and `control`.

`screenshot` result shape:

```jsonc
{"content":[{"type":"image","data":"<base64 PNG>"},
            {"type":"text","text":"{\"height\":971,\"path\":null,\"width\":1600}"}]}
```

## Control channel (app bridge)

- Start the app with `effectcraft --control <port>` or persist
  `EFFECTCRAFT_CONTROL_PORT` (User scope). Any free loopback port works
  (50051/50052 verified).
- **No token.** Plain `--bridge PORT` connects (verified). There is no
  `EFFECTCRAFT_CONTROL_TOKEN` in either binary — unlike FilmCraft, which
  requires a 64-char token. Prefer a non-default port if that matters to you.
- Quick check: `effectcraft-cli --bridge 50052 info` →
  `EffectCraft 0.17.0 (bridge), 734 commands, 307 effects`.
- Clean shutdown over the bridge: `command_run {"id":"app.quit"}`.

## Error shapes

| Failure | Response / stderr |
|---|---|
| Unknown command id | `{"error":"<id>: unknown command `<id>`"}` |
| Unknown parameter | `{"error":"<id>: invalid parameters for `<id>`: unknown parameter(s) `x`; accepted: name, width, … (doc: {…})"}` |
| Bad property path | `{"error":"prop.get: invalid parameters for `prop.get`: no property `position`"`} |
| No comp open | `effectcraft-cli render-frame: no active composition: create one (execute_command comp.new) or open a project` (exit 1) |
| Script error | exit 1, `file.jsx:LINE:COL: <message>`; MCP `run_script` → `{"error":…,"ok":false}` |

The parameter error **includes the accepted key list and the param doc** —
treat it as live documentation and fix the call in one round trip.

## Registering with agent clients

```powershell
# Claude Code (Windows)
claude mcp add effectcraft -- "C:\Program Files\EffectCraft\effectcraft-cli.exe" mcp
# …or bridge to a running app:
claude mcp add effectcraft -- "C:\Program Files\EffectCraft\effectcraft-cli.exe" mcp --bridge 50052
```
