# ArtCraft Agent Skills

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![FilmCraft](https://img.shields.io/badge/FilmCraft-0.10--0.13-purple)](https://github.com/storytold/filmcraft)
[![EffectCraft](https://img.shields.io/badge/EffectCraft-0.17-teal)](https://getartcraft.com/apps/effectcraft)
[![Agent Skills](https://img.shields.io/badge/Agent_Skills-Antigravity%20%7C%20Claude%20%7C%20OpenCode-blue)](INSTALL.md)

Agent Skills for the **[ArtCraft](https://getartcraft.com)** creative suite —
native Rust creative tools that share one agent architecture: **every action
is a command with an id**, driven by a CLI, an MCP server and a live GUI
bridge.

## Install

### Claude Code (plugin marketplace — 1 command)

```
/plugin marketplace add kjranyone/artcraft-agent-skills
/plugin install video-production@artcraft-agent-skills
```

### Other agents (git clone + symlink)

```bash
git clone https://github.com/kjranyone/artcraft-agent-skills.git
cd artcraft-agent-skills

# Windows (PowerShell) — run install.ps1
.\install.ps1 claude     # or: antigravity / opencode

# macOS / Linux
chmod +x install.sh && ./install.sh claude
```

> `install.sh` / `install.ps1` create junctions/symlinks from this repo's
> `skills/` folders into your agent's skills directory. Re-run after
> `git pull` to pick up updates.

> Detailed instructions (per-skill install, MCP registration): **[INSTALL.md](INSTALL.md)**

## Skills

| Skill | Type | What it does |
|---|---|---|
| [`video-director`](skills/video-director/) | orchestration | director role: pipeline (brief→boards→animatic→build→sound→QC), design discipline, aesthetic canon, frame review rubric |
| [`style-stock`](skills/style-stock/) | reference library | decomposed style cards from real masterpieces (Linear, Spotify Wrapped, Z会, Dylan) + 5 genre fallbacks |
| [`filmcraft`](skills/filmcraft/) | FilmCraft skill | NLE video editor (Premiere Pro-class): cut, grade, export |
| [`effectcraft`](skills/effectcraft/) | EffectCraft skill | motion graphics & VFX (After Effects-class): comps, keyframes, effects, render |
| [`canvas-design`](skills/canvas-design/) | design (vendored) | design-philosophy-first visual craft + Latin font library (from [anthropics/skills](https://github.com/anthropics/skills), Apache-2.0) |

**Companion skill:** [sttts-say](https://github.com/kjranyone/sttts-gui) —
Irodori-TTS for Japanese narration. Recommended for all video projects
(8 bundled voices, local GPU, already installed on dev machines).

## Sanity check

```bash
cd skills/effectcraft && bash scripts/probe.sh    # or skills/filmcraft
```

## Two connection modes

| Mode | Command | Best for |
|---|---|---|
| **Headless** | `<app>-cli mcp --demo` or `--project file` | batch builds, renders, exports, CI |
| **Live GUI bridge** | `<app> --control 50051` + `<app>-cli mcp --bridge 50051` | real-time human-AI collaboration |

## Repository layout

```
.
├── README.md / INSTALL.md / LICENSE
└── skills/
    ├── video-director/         # orchestration: pipeline + quality gates
    │   ├── SKILL.md            # role, gates, design rules, sound rule
    │   ├── references/         # canon, playbook, rubric, case study
    │   └── scripts/            # frame_audit.py (executable rubric)
    ├── style-stock/            # reference style library
    │   ├── SKILL.md            # selection workflow + card template
    │   └── styles/             # real stock (4) + genre cards (5)
    ├── canvas-design/          # Anthropic design skill (vendored)
    │   ├── SKILL.md            # design philosophy → canvas
    │   └── canvas-fonts/       # Big Shoulders, DM Mono, Bricolage…
    ├── filmcraft/              # FilmCraft agent skill
    │   ├── SKILL.md
    │   ├── references/         # recipes, catalog, CLI/MCP docs, bugs
    │   └── scripts/
    └── effectcraft/            # EffectCraft agent skill
        ├── SKILL.md
        ├── references/         # recipes, catalog, CLI/MCP docs, bugs ×10
        └── scripts/
```

## Credits & attribution

- Built for the **ArtCraft** apps by [kjranyone](https://github.com/kjranyone).
- Skill blueprint adapted from upstream issue proposal
  [storytold/filmcraft#2831](https://github.com/storytold/filmcraft/issues/2831)
  and [AHL8192/opencode-craft-skills](https://github.com/AHL8192/opencode-craft-skills).
- Community: <https://discord.gg/artcraft> · <https://getartcraft.com>
