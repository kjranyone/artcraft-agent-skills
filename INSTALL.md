# Installing the ArtCraft Agent Skills

One repository, one skill per app (`skills/filmcraft`, `skills/effectcraft`).
Skill managers discover skills at `<skills-dir>/<name>/SKILL.md`, so install
by cloning this repo once and linking (or copying) each skill you want.

## 1. Prerequisites

The app you want to drive must be installed:

| App | Windows | Linux |
|---|---|---|
| FilmCraft | `C:\Program Files\FilmCraft\filmcraft.exe` + `filmcraft-cli.exe` | `/usr/bin/filmcraft` + `filmcraft-cli` |
| EffectCraft | `C:\Program Files\EffectCraft\effectcraft.exe` + `effectcraft-cli.exe` | `/usr/bin/effectcraft` + `effectcraft-cli` |

```sh
filmcraft-cli --version          # or, on Windows:
& "C:\Program Files\EffectCraft\effectcraft-cli.exe" --version
```

## 2. Clone the repository once

```sh
git clone https://github.com/kjranyone/artcraft-agent-skills.git ~/artcraft-agent-skills
cd ~/artcraft-agent-skills
```

## 3. Link each skill into your agent's skills directory

### Antigravity & Gemini CLI — `~/.agents/skills`

```bash
# macOS / Linux (symlink)
ln -s ~/artcraft-agent-skills/skills/filmcraft ~/.agents/skills/filmcraft
ln -s ~/artcraft-agent-skills/skills/effectcraft ~/.agents/skills/effectcraft
```

```powershell
# Windows (junction — no admin rights needed)
New-Item -ItemType Junction -Path "$env:USERPROFILE\.agents\skills\filmcraft" -Target "$env:USERPROFILE\artcraft-agent-skills\skills\filmcraft"
New-Item -ItemType Junction -Path "$env:USERPROFILE\.agents\skills\effectcraft" -Target "$env:USERPROFILE\artcraft-agent-skills\skills\effectcraft"
```

### Claude Code — `~/.claude/skills`

Same commands with `~/.claude/skills` (`$env:USERPROFILE\.claude\skills`)
as the link path. Then optionally register the MCP server directly:

```powershell
# Windows
claude mcp add filmcraft  -- "C:\Program Files\FilmCraft\filmcraft-cli.exe" mcp
claude mcp add effectcraft -- "C:\Program Files\EffectCraft\effectcraft-cli.exe" mcp
# bridge to a running app instead of headless: append --bridge 50051
```

### OpenCode — `~/.config/opencode/skills`

```bash
ln -s ~/artcraft-agent-skills/skills/filmcraft  ~/.config/opencode/skills/filmcraft
ln -s ~/artcraft-agent-skills/skills/effectcraft ~/.config/opencode/skills/effectcraft
```

### Copy instead of link (any agent)

```powershell
Copy-Item -Recurse ~/artcraft-agent-skills/skills/effectcraft $env:USERPROFILE\.agents\skills\effectcraft
```

Copies don't track `git pull` updates — prefer links, or re-copy after
updating.

## 4. Verify

```sh
cd ~/artcraft-agent-skills/skills/filmcraft   && bash scripts/probe.sh   # 17 MCP tools
cd ~/artcraft-agent-skills/skills/effectcraft && bash scripts/probe.sh   # 27 headless tools (36 bridged)
# Windows: powershell -File scripts\probe.ps1
```

End-to-end build → render → export check:

```sh
bash scripts/smoke-test.sh                    # or scripts\smoke-test.ps1
```

## 5. Going live (GUI bridge)

```powershell
# FilmCraft: token-managed launch on the visible desktop
powershell -File skills\filmcraft\scripts\launch.ps1 -Port 50051
# EffectCraft: no token needed
powershell -File skills\effectcraft\scripts\launch.ps1 -Port 50052
```

Now the agent can read your open project, place clips/layers and render
previews while you work. Details in each skill's SKILL.md.
