# Installing filmcraft Agent Skill

Instructions for AI coding agents and human users to install and verify the `filmcraft` Agent Skill.

## 1. Prerequisites

Ensure FilmCraft is installed:
- **Windows**: `C:\Program Files\FilmCraft\filmcraft.exe` and `filmcraft-cli.exe`
- **Linux**: `/usr/bin/filmcraft` and `filmcraft-cli`
- **macOS**: `/Applications/FilmCraft.app` and `filmcraft-cli`

Verify CLI access:
```sh
filmcraft-cli --version
# or on Windows:
& "C:\Program Files\FilmCraft\filmcraft-cli.exe" --version
```

## 2. Install the Skill

Clone or copy the `filmcraft` skill into your agent's skill directory:

### For Antigravity & Gemini CLI
```powershell
# Windows
git clone https://github.com/kjranyone/filmcraft-agent-skills.git "$env:USERPROFILE\.agents\skills\filmcraft"
```
```bash
# macOS / Linux
git clone https://github.com/kjranyone/filmcraft-agent-skills.git ~/.agents/skills/filmcraft
```

### For Claude Code
```bash
# macOS / Linux
git clone https://github.com/kjranyone/filmcraft-agent-skills.git ~/.claude/skills/filmcraft
```
```powershell
# Windows
git clone https://github.com/kjranyone/filmcraft-agent-skills.git "$env:USERPROFILE\.claude\skills\filmcraft"
```

### For OpenCode
```bash
git clone https://github.com/kjranyone/filmcraft-agent-skills.git ~/.config/opencode/skills/filmcraft
```

## 3. Verify Installation

Run the verification probe:
```powershell
# Windows
powershell -File .\scripts\probe.ps1
```
```bash
# Linux / macOS
./scripts/probe.sh
```

All 17 MCP tools should be discovered.
