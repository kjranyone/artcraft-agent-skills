#!/usr/bin/env bash
# Dump the EffectCraft command catalog as JSON, Markdown and a summary.
# Usage: dump-commands.sh [outdir]      (default: ./effectcraft-commands)
set -eu

CLI=${EFFECTCRAFT_CLI:-effectcraft-cli}
OUT=${1:-effectcraft-commands}
mkdir -p "$OUT"

"$CLI" --version > "$OUT/version.txt"
"$CLI" --demo commands --json > "$OUT/commands.json"

PYBIN=""
for cand in python3 python; do
  # skip the Windows Store python3.exe stub: it exists but cannot run code
  if command -v "$cand" >/dev/null 2>&1 && "$cand" -c "pass" >/dev/null 2>&1; then
    PYBIN="$cand"; break
  fi
done
[ -n "$PYBIN" ] || { echo "dump: no usable python (python3/python)" >&2; exit 3; }

"$PYBIN" - "$OUT" <<'PY'
import json, os, collections, sys
out = sys.argv[1]
cmds = json.load(open(os.path.join(out, "commands.json")))
by = collections.defaultdict(list)
for c in cmds:
    by[c["id"].split(".")[0]].append(c)
enabled = sum(1 for c in cmds if c.get("enabled"))

lines = [f"# EffectCraft command catalog ({len(cmds)} commands)", ""]
lines += ["| namespace | n |", "|---|---|"]
for ns in sorted(by):
    lines.append(f"| `{ns}` | {len(by[ns])} |")
lines += ["", f"{enabled} of {len(cmds)} enabled in a fresh headless context "
          "(context-dependent commands show enabled: false until the selection / "
          "active comp / tool mode exists).", "", "## Commands", ""]
for ns in sorted(by):
    lines += [f"### {ns}", ""]
    for c in sorted(by[ns], key=lambda x: x["id"]):
        p = c.get("params") or ""
        sc = c.get("shortcut") or ""
        dis = "" if c.get("enabled") else " *(context)*"
        lines.append(f"- `{c['id']}`{dis} {p}" + (f"  ({sc})" if sc else ""))
    lines.append("")
open(os.path.join(out, "commands.md"), "w").write("\n".join(lines))

summary = [f"total: {len(cmds)}", f"namespaces: {len(by)}", f"enabled (fresh headless): {enabled}", ""]
summary += [f"{ns}: {len(by[ns])}" for ns in sorted(by)]
open(os.path.join(out, "summary.txt"), "w").write("\n".join(summary) + "\n")
print("\n".join(summary[:3]))
print("wrote", os.path.join(out, "commands.json"), "commands.md", "summary.txt")
PY
