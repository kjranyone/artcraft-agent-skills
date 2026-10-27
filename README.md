# ArtCraft Agent Skills

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![FilmCraft](https://img.shields.io/badge/FilmCraft-0.10--0.13-purple)](https://github.com/storytold/filmcraft)
[![EffectCraft](https://img.shields.io/badge/EffectCraft-0.17-teal)](https://getartcraft.com/apps/effectcraft)
[![Agent Skills](https://img.shields.io/badge/Agent_Skills-Antigravity%20%7C%20Claude%20%7C%20OpenCode-blue)](INSTALL.md)

Agent Skills for the **[ArtCraft](https://getartcraft.com)** creative suite —
native Rust creative tools that share one agent architecture: **every action
is a command with an id**, driven by a CLI, an MCP server and a live GUI
bridge.

| Skill | App | What the agent can do | Verified |
|---|---|---|---|
| [`skills/canvas-design`](skills/canvas-design/) | *vendored from [anthropics/skills](https://github.com/anthropics/skills) (Apache-2.0)* | design-philosophy-first visual craft for posters/boards, incl. a curated Latin font library (Big Shoulders, DM Mono, Bricolage Grotesque…) | upstream |
| [`skills/video-director`](skills/video-director/) | *orchestration layer* (any app) | act as the professional director for promo/teaser work: production pipeline with a storyboard approval gate, design discipline (palette/typography/pacing), sound planning, editorial self-review — built on the GRAND2 teaser postmortem | process, 2026-10 |
| [`skills/filmcraft`](skills/filmcraft/) | [FilmCraft](https://github.com/storytold/filmcraft) — NLE video editor (Premiere Pro-class) | assemble/cut/trim clips tick-accurately, effects & Lumetri grades, transitions, captions, graphics, export H.264/ProRes/DNxHR/FCPXML/EDL/OTIO, drive the live GUI | 0.10.0–0.13.0 (Windows, Linux) |
| [`skills/effectcraft`](skills/effectcraft/) | [EffectCraft](https://getartcraft.com/apps/effectcraft) — motion graphics & VFX compositor (After Effects-class) | build comps/layers, keyframes & easing, 307 effects, masks, tracking, expressions, ExtendScript, templates, render MP4/ProRes/EXR/WebM, drive the live GUI | 0.17.0 (Windows) |

More apps in the series (PhotoCraft, VectorCraft, …) follow the same
`<app>-cli` + `--control` bridge pattern; skills land here as they are
verified against installed builds.

---

## Quick start

1. Install the skills into your agent — see **[INSTALL.md](INSTALL.md)**
   (Antigravity / Gemini CLI, Claude Code, OpenCode, and MCP-only setups).
2. Headless sanity check (no GUI window):

   ```sh
   cd skills/effectcraft && bash scripts/probe.sh        # or skills/filmcraft
   ```

3. Ask your agent, e.g. *"EffectCraftを起動して"* (launches the GUI with a
   control port), *"build a 5-second lower-third in EffectCraft and export
   MP4"*, or *"cut this clip at 0:12 and cross-dissolve"* in FilmCraft.

## Two connection modes (both apps)

| Mode | Command | Best for |
|---|---|---|
| **Headless** | `<app>-cli mcp --demo` or `--project file` | batch builds, renders, exports, CI |
| **Live GUI bridge** | `<app> --control 50051` + `<app>-cli mcp --bridge 50051` | real-time human-AI collaboration on the open project |

FilmCraft's bridge requires a 64-char `FILMCRAFT_CONTROL_TOKEN`;
EffectCraft's bridge needs no token. Each skill documents its own tools,
recipes, pitfalls and maintenance procedure.

## Repository layout

```
.
├── README.md / INSTALL.md / LICENSE
└── skills/
    ├── video-director/         # orchestration layer: pipeline + quality gates
    │   ├── SKILL.md            # role, gates, design rules, sound rule
    │   └── references/         # production playbook + GRAND2 case study
    ├── filmcraft/              # FilmCraft agent skill
    │   ├── SKILL.md            # entry point the agent reads
    │   ├── references/         # recipes, command catalog, CLI/MCP docs, bugs
    │   └── scripts/            # probe, launch, dump-commands, smoke-test
    └── effectcraft/            # EffectCraft agent skill (same shape)
```

## Credits & attribution

- Built for the **ArtCraft** apps by [kjranyone](https://github.com/kjranyone).
- Skill blueprint adapted from upstream issue proposal
  [storytold/filmcraft#2831](https://github.com/storytold/filmcraft/issues/2831)
  and [AHL8192/opencode-craft-skills](https://github.com/AHL8192/opencode-craft-skills).
- Community: <https://discord.gg/artcraft> · <https://getartcraft.com>
