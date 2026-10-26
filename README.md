# FilmCraft Agent Skills

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![FilmCraft](https://img.shields.io/badge/FilmCraft-0.10--0.12-purple)](https://github.com/storytold/filmcraft)
[![Agent Skills](https://img.shields.io/badge/Agent_Skills-OpenCode%20%7C%20Claude%20%7C%20Antigravity-blue)](SKILL.md)

Agent Skills for **[FilmCraft](https://github.com/storytold/filmcraft)** — the open-source, non-linear video editor written in pure Rust (Premiere Pro alternative).

This skill equips AI coding agents (Antigravity, Gemini CLI, Claude Code, OpenCode, Cursor, Codex) to autonomously drive FilmCraft:
- Assemble, cut, slip, and ripple-trim clips with tick-accurate precision
- Apply video/audio effects, Lumetri colour grades, and transitions
- Insert captions and graphics
- Render frames and export H.264, ProRes, DNxHR, or interchange formats (FCPXML, EDL, OTIO)
- Drive the live desktop GUI in real time via IPC bridge or run headlessly via `filmcraft-cli` and MCP

---

## Quick Start & Installation

### Option 1: Install for Antigravity & Gemini CLI

Clone directly into your personal agent skills directory:

```powershell
# Windows
git clone https://github.com/kjranyone/filmcraft-agent-skills.git "$env:USERPROFILE\.agents\skills\filmcraft"
```

```bash
# macOS / Linux
git clone https://github.com/kjranyone/filmcraft-agent-skills.git ~/.agents/skills/filmcraft
```

### Option 2: Install for Claude Code

```bash
# macOS / Linux
git clone https://github.com/kjranyone/filmcraft-agent-skills.git ~/.claude/skills/filmcraft
```

```powershell
# Windows
git clone https://github.com/kjranyone/filmcraft-agent-skills.git "$env:USERPROFILE\.claude\skills\filmcraft"
```

Or register the built-in MCP server:

```bash
# Windows
claude mcp add filmcraft -- "C:\Program Files\FilmCraft\filmcraft-cli.exe" mcp

# Linux / macOS
claude mcp add filmcraft -- filmcraft-cli mcp
```

### Option 3: OpenCode

```bash
git clone https://github.com/kjranyone/filmcraft-agent-skills.git ~/.config/opencode/skills/filmcraft
```

---

## Two Connection Modes

| Mode | Command | Best For |
|---|---|---|
| **Headless** | `filmcraft-cli mcp --demo` or `--project my.fcproj` | Batch rendering, headless pipelines, CLI automation |
| **Live GUI Bridge** | `filmcraft --control 50051` + `filmcraft-cli --bridge 127.0.0.1:50051` | Real-time human-AI collaboration on the desktop GUI |

### Enabling the Live GUI Bridge

To allow AI agents to edit your open timeline in FilmCraft:

1. Launch FilmCraft with `--control`:
   ```powershell
   & "C:\Program Files\FilmCraft\filmcraft.exe" --control 50051
   ```
2. Or set the persistent environment variable:
   ```powershell
   [Environment]::SetEnvironmentVariable('FILMCRAFT_CONTROL_PORT', '50051', 'User')
   ```

Now the AI agent can inspect your open timeline, import voiceovers (e.g. from `sttts-say`), place B-roll clips, and trigger previews while you work!

---

## Directory Structure

```
.
├── SKILL.md                          # Main Agent Skill instruction definition
├── README.md                         # Project overview and usage
├── INSTALL.md                        # Step-by-step installation instructions
├── LICENSE                           # MIT License
├── references/                       # Domain knowledge and technical manuals
│   ├── recipes.md                    # Verified step-by-step command recipes
│   ├── commands.md                   # 701 commands catalogue grouped by namespace
│   ├── cli.md                        # filmcraft-cli options and subcommands
│   ├── mcp-and-control.md            # MCP tool specs and JSON-RPC schema
│   ├── formats-and-roundtrip.md      # Codecs & NLE interchange compatibility
│   ├── bugs-and-workarounds.md       # Known edge cases and fixes
│   └── maintenance.md                # Verification and update guides
├── scripts/                          # Verification and utility scripts
│   ├── probe.ps1 / probe.sh          # MCP handshake and tool capability probe
│   ├── dump-commands.ps1 / .sh       # Command catalogue generator
│   └── smoke-test.ps1 / smoke-test.sh# Full end-to-end headless verification
└── skills/
    └── filmcraft/                    # Nested copy for multi-skill managers
```

---

## Credits & Attribution

- Built for **[FilmCraft](https://github.com/storytold/filmcraft)** by the ArtCraft team.
- Skill blueprint adapted from upstream issue proposal [#2831](https://github.com/storytold/filmcraft/issues/2831) and [AHL8192/opencode-craft-skills](https://github.com/AHL8192/opencode-craft-skills).
- Maintained by [kjranyone](https://github.com/kjranyone).
