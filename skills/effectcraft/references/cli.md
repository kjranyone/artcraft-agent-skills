# effectcraft-cli reference (verified on 0.17.0, Windows)

Binary: `C:\Program Files\EffectCraft\effectcraft-cli.exe` (Windows) /
`/usr/bin/effectcraft-cli` (Linux). `--version` prints `effectcraft-cli 0.17.0`.

```
usage: effectcraft-cli <info|commands|exec|run|props|get|set|render-frame|render|script|mcp> [args] [--json]
```

## Session options (before the subcommand)

| Option | Meaning |
|---|---|
| `--project F.ecproj` | open this project first (headless) |
| `--demo` | open the built-in demo project |
| `--empty` | start with an empty project (also the default with none of these) |
| `--save` / `--save-as F` | save back / save to a path when the run finishes |
| `--bridge PORT` | talk to the running app (`effectcraft --control PORT`) instead of a headless engine |
| `--json` | machine-readable output |
| `--gpu` | GPU renderer |

**Each invocation is one session.** Build + `--save-as` in one call, then
`--project` in the next; nothing survives otherwise.

## Subcommands

| Command | Purpose |
|---|---|
| `info` | project + engine summary: items, active comp + its layers, command/effect counts |
| `commands [--filter TEXT] [--enabled]` | list engine commands (`--json` for the full catalog) |
| `exec <command-id> [--params JSON]` | run one command (`exec --list` = `commands`) |
| `run <id> <json> [<id> <json> …]` | several commands in order; `run --args-file F` one per line |
| `props <comp> <layer> [--flat] [--time S]` | a layer's property tree with paths |
| `get <comp> <layer> <path> [--time S]` | read one property |
| `set <comp> <layer> <path> <value> [--time S] [--expression E]` | write one property / expression |
| `render-frame` | one PNG (below) |
| `render` | export a movie / sequence / template (below) |
| `script FILE.jsx [F.ecproj]` \| `--eval CODE` | After Effects-style ExtendScript; prints `writeLn` output + result; errors exit 1 with `file:line:col` |
| `mcp` | MCP server on stdio (below) |
| `bench` | per-layer/effect timings (`--gpu`, `--ops`, `--play N`) |

`<comp>`: id or name, `-` = active comp. `<layer>`: id, `#n` (stack index) or
name. `<value>`: JSON or bare string.

## render-frame

```
render-frame [--comp C] [--time S | --frame N] [--max-side PX | --scale K]
             [--out F.png] [--transparent]
```

Defaults: active comp at the current time. `--transparent` → RGBA (works with
PNG). Fast: a 1920×1080 frame rendered in ~4 ms headless.

## render

```
render [--comp C] --out FILE [--format F] [--start S] [--end S] [--work-area] [--fps N]
       [--resolution full|half|third|quarter|K] [--quality best|draft]
       [--channels rgb|rgba] [--jpeg-quality N] [--bitrate KBPS] [--prores PROFILE]
       [--audio auto|on|off] [--profile main|main10] [--level auto|4.1]
       [--rate-control bitrate|quality] [--video-quality N] [--keyint FRAMES]
       [--webm-codec vp9|av1] [--audio-bitrate KBPS] [--opus-app audio|voice]
       | --queue
render/render-frame --template T.ectemplate [--values V.json]
```

- Formats: `h264|hevc|av1|prores|uncompressed|webm|png|jpeg|tiff|exr|gif|wav|aiff`.
  `--profile…--keyint` apply to HEVC/AV1; `--audio-bitrate/--opus-app` to WebM Opus.
- A **relative `--out` is relative to the process working directory** — pass
  absolute paths.
- `--progress` prints `(progress <done> <total> <elapsed> <left|->)` lines on
  stderr when not a terminal.
- Template mode renders one `.ectemplate` instance with values from a JSON file.

## mcp

```
mcp [--autosave | --bridge PORT]
    [--automation-read-root DIR] [--automation-write-root DIR]
```

- `--autosave` preserves unsaved headless work on exit.
- `--automation-read-root` / `--automation-write-root` (repeatable) confine
  the agent's file access: reads under a read or write root, writes under a
  write root; **scripts are refused** when roots are set.
- `--bridge PORT` attaches to `effectcraft --control PORT` (live GUI, 36 tools
  incl. UI automation) instead of a headless engine (27 tools).

## Exit codes

`0` success · `1` command/render failure · usage errors print
`effectcraft-cli <sub>: …` on stderr with exit ≠ 0. Failing commands print
`{"error":"<id>: <message>"}` — parameter errors include the accepted-key
list, unknown ids say `unknown command`.

## Verbatim `--help` (0.17.0)

```
usage: effectcraft-cli <info|commands|exec|run|props|get|set|render-frame|render|script|mcp> [args] [--json]
  info                                     project + engine summary
  commands [--filter TEXT] [--enabled]     list engine commands
  exec <command-id> [--params JSON]        run one engine command (exec --list: list them, as `commands`)
  run <id> <json> [<id> <json> ...]        run several commands in order
  run --args-file F                        the same, one argument per line of F (no command-line length limit)
  props <comp> <layer> [--flat] [--time S] a layer's property tree with paths
  get <comp> <layer> <path> [--time S]     read a property
  set <comp> <layer> <path> <value> [--time S] [--expression E]
  render-frame [--comp C] [--time S | --frame N] [--max-side PX | --scale K] [--out F.png] [--transparent]
  render [--comp C] --out FILE [--format F] [--start S] [--end S] [--work-area] [--fps N]
         [--resolution full|half|third|quarter|K] [--quality best|draft] [--channels rgb|rgba]
         [--jpeg-quality N] [--bitrate KBPS] [--prores PROFILE] [--audio auto|on|off]
         [--profile main|main10] [--level auto|4.1] [--rate-control bitrate|quality] [--video-quality N]
         [--keyint FRAMES] [--webm-codec vp9|av1] [--audio-bitrate KBPS] [--opus-app audio|voice] | --queue
                                           (formats h264|hevc|av1|prores|uncompressed|webm|png|jpeg|tiff|exr|gif|wav|aiff;
                                           --profile..--keyint: HEVC / AV1, --audio-bitrate/--opus-app: WebM Opus)
                                           a relative --out is relative to the working directory
                                           --progress: progress lines on stderr when it is not a terminal
                                           (progress <frames done> <total> <seconds elapsed> <seconds left|->)
  render/render-frame --template T.ectemplate [--values V.json]   render one template instance
  bench [--comp C] [--time S] [--scale K] [--n N] [--play N] [--gpu [--adv3d]]   per-layer/effect render timings;
                                           --play N renders N consecutive frames with/without the layer cache;
                                           --gpu compares CPU and GPU ms/frame for every comp at Full and Half
  bench --ops [--small] [--layers N] [--comps N] [--footage N]
                                           everyday operations on a large generated project: startup, open,
                                           save, auto-save, edits + undo/redo, timeline, Project panel
  script FILE.jsx [F.ecproj] | --eval CODE run JavaScript with the After Effects-style object model
                                           (app.project, comps, layers, properties…); prints writeLn
                                           output and the result; errors exit 1 with file:line:col
  mcp [--autosave | --bridge PORT]         MCP server (JSON-RPC over stdio); --autosave preserves unsaved headless work
      [--automation-read-root DIR] [--automation-write-root DIR]
                                           confine the agent's file access: reads under a read or write root,
                                           writes under a write root (each repeatable); scripts are refused
options: --project F.ecproj | --demo | --empty   --save | --save-as F   --bridge PORT   --json   --gpu
<comp>: id or name, '-' = active comp; <layer>: id, '#n' or name; <value>: JSON or bare string
```
