# Dump the EffectCraft command catalog as JSON, Markdown and a summary.
# Usage: powershell -File dump-commands.ps1 [-Out effectcraft-commands]
param(
    [string]$Out = "effectcraft-commands"
)

$cli = if ($env:EFFECTCRAFT_CLI) { $env:EFFECTCRAFT_CLI } else { "C:\Program Files\EffectCraft\effectcraft-cli.exe" }
if (-not (Test-Path $cli)) {
    $cli = (Get-Command effectcraft-cli -ErrorAction SilentlyContinue).Source
}
if (-not $cli -or -not (Test-Path $cli)) {
    Write-Error "effectcraft-cli not found"
    exit 2
}

New-Item -ItemType Directory -Force -Path $Out | Out-Null

& $cli --version | Out-File -Encoding utf8 "$Out/version.txt"
& $cli --demo commands --json | Out-File -Encoding utf8 "$Out/commands.json"

$py = @'
import json, os, collections, sys
out = sys.argv[1]
cmds = json.load(open(os.path.join(out, "commands.json"), encoding="utf-8-sig"))
by = collections.defaultdict(list)
for c in cmds:
    by[c["id"].split(".")[0]].append(c)
enabled = sum(1 for c in cmds if c.get("enabled"))

lines = ["# EffectCraft command catalog ({} commands)".format(len(cmds)), ""]
lines += ["| namespace | n |", "|---|---|"]
for ns in sorted(by):
    lines.append("| `{}` | {} |".format(ns, len(by[ns])))
lines += ["", "{} of {} enabled in a fresh headless context ".format(enabled, len(cmds)) +
          "(context-dependent commands show enabled: false until the selection / " +
          "active comp / tool mode exists).", "", "## Commands", ""]
for ns in sorted(by):
    lines += ["### {}".format(ns), ""]
    for c in sorted(by[ns], key=lambda x: x["id"]):
        p = c.get("params") or ""
        sc = c.get("shortcut") or ""
        dis = "" if c.get("enabled") else " *(context)*"
        lines.append("- `{}`{} {}{}".format(c["id"], dis, p, ("  ({})".format(sc) if sc else "")))
    lines.append("")
open(os.path.join(out, "commands.md"), "w", encoding="utf-8").write("\n".join(lines))

summary = ["total: {}".format(len(cmds)), "namespaces: {}".format(len(by)),
           "enabled (fresh headless): {}".format(enabled), ""]
summary += ["{}: {}".format(ns, len(by[ns])) for ns in sorted(by)]
open(os.path.join(out, "summary.txt"), "w").write("\n".join(summary) + "\n")
print("\n".join(summary[:3]))
'@

$pyfile = Join-Path $env:TEMP "ec-dump-commands.py"
$py | Out-File -Encoding utf8 $pyfile
python $pyfile $Out
Write-Host "wrote $Out\commands.json commands.md summary.txt"
