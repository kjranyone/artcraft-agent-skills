# Maintenance — keep this skill true

EffectCraft moves fast; the docs describe design intent, the binary is the
truth. Re-verify before trusting any claim here.

## 1. Version and identity

```powershell
& "C:\Program Files\EffectCraft\effectcraft-cli.exe" --version   # effectcraft-cli 0.17.0
& "C:\Program Files\EffectCraft\effectcraft.exe" --version       # effectcraft 0.17.0
```

If the version moved, re-run the checks below and update the numbers in
`SKILL.md` (commands / namespaces / effects / fonts), the catalog, and any
behavior that changed.

## 2. Handshake and tool surface

```sh
bash scripts/probe.sh            # headless; or: bash scripts/probe.sh --bridge 127.0.0.1:50052
# Windows: powershell -File scripts/probe.ps1 [-Bridge 50052]
```

Starts `effectcraft-cli mcp --demo`, does `initialize`, `tools/list`,
`resources/list`, counts commands, and fails if the expected core tools are
missing. Verified baseline (0.17.0): **27 headless tools, 36 bridge tools,
734 commands, 55 namespaces, 307 effects, 149 font families**.

## 3. Command catalog

```sh
bash scripts/dump-commands.sh /tmp/ec-commands      # or scripts/dump-commands.ps1 -Out /tmp/ec-commands
```

Writes `commands.json`, `commands.md`, `summary.txt`. Compare with
`references/catalog/`; replace the catalog when ids/params/enabled-contexts
change, and update the counts at the top of `commands.md` and in `SKILL.md`.

## 4. Behaviour checklist (10 minutes, verified expectations)

1. `comp.new {name,width,height,frameRate,duration}` → `{comp:id}` **and the
   comp becomes active** (text layer lands in it without `comp.open`).
2. `layer.newSolid` returns a **skipped id** (solid = footage item + layer).
3. `layer.timing {layers, start:2}` then `prop.addKey {time:0}` → key at
   `compTime:2.0` (layer-base default). `timeBase:"comp"` must land at 0.
4. `prop.get` at the midpoint of two keys returns the interpolated value
   (verified [10,100] → 77.5 at the middle… linear in each dim).
5. `effect.apply {"Gaussian Blur"}` with explicit `layers` works headless
   with no selection; without `layers` and no selection the command is
   disabled.
6. Unknown param → error listing accepted keys (strict validation).
7. `render-frame --time --max-side` writes a PNG (~4 ms/frame headless);
   `render --format h264 --start --end` writes a valid MP4 (`ftyp` box,
   mvhd duration = frames/fps).
8. `script --eval 'app.project.activeItem.name'` returns the comp name;
   `run_script` via MCP returns `{"ok":true,"result":…}`.
9. Bridge: `--control PORT`, plain `--bridge` connect with **no token**;
   `app.quit` over the bridge closes the app (process count 0).

If any of these changed, update `references/bugs-and-workarounds.md` and
`references/recipes.md` first.

## 5. Isolation and cleanup

- Headless runs are throwaway by default; use `--save-as` to keep work,
  `mcp --autosave` for MCP sessions with unsaved edits.
- `--automation-read-root` / `--automation-write-root` confine agent file
  access (and refuse scripts) — use them for untrusted automation.
- Data dir `%LOCALAPPDATA%\EffectCraft` (Windows) / `~/.local/share/effectcraft`
  holds the Disk Cache; safe to delete when the app is closed.
- Give bridge instances their own port if several run; close only instances
  you started (`app.quit` over your bridge).

## 6. Updating this skill

1. Regenerate `references/catalog/commands.md` (never hand-edit the body).
2. Keep `SKILL.md` lean; every `references/…` / `scripts/…` path it names
   must exist.
3. Re-run `scripts/smoke-test.sh` (or `.ps1`) end-to-end after edits.
4. Keep the FilmCraft sibling skill in sync structurally
   (`../filmcraft/` in this repository) — shared conventions: two connection
   modes, strict-args notes differ (FilmCraft drops unknown params,
   EffectCraft rejects them).
