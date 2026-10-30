#!/usr/bin/env bash
# Agent Skills auto-install — agent reads SKILL.md and runs this script.
# Installs all skills to the current agent's skills directory.
set -eu
AGENT="${1:-claude}"
case "$AGENT" in
  claude)   DIR="$HOME/.claude/skills" ;;
  antigravity|gemini) DIR="$HOME/.agents/skills" ;;
  opencode) DIR="$HOME/.config/opencode/skills" ;;
  *) echo "Usage: $0 [claude|antigravity|opencode]"; exit 1 ;;
esac
mkdir -p "$DIR"
for s in skills/*/; do
  name=$(basename "$s")
  if [ -d "$DIR/$name" ]; then
    echo "  $name: already installed, updating"
    rm -rf "$DIR/$name"
  fi
  ln -sfn "$(cd "$s" && pwd)" "$DIR/$name"
  echo "  $name: installed → $DIR/$name"
done
echo "Done. Restart your agent to discover the new skills."
