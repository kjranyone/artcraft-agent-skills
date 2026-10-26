# Dump the FilmCraft command catalog as JSON and Markdown on Windows.
param(
    [string]$OutDir = "filmcraft-commands"
)

$cli = if ($env:FILMCRAFT_CLI) { $env:FILMCRAFT_CLI } else { "C:\Program Files\FilmCraft\filmcraft-cli.exe" }
if (-not (Test-Path $cli)) {
    $cli = (Get-Command filmcraft-cli -ErrorAction SilentlyContinue).Source
}

if (-not $cli -or -not (Test-Path $cli)) {
    Write-Error "filmcraft-cli executable not found."
    exit 2
}

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
& $cli --version | Set-Content (Join-Path $OutDir "version.txt")
$jsonText = & $cli commands --json
$jsonText | Set-Content (Join-Path $OutDir "commands.json") -Encoding utf8

$cmds = $jsonText | ConvertFrom-Json
$grouped = $cmds | Group-Object { $_.id.Split('.')[0] } | Sort-Object Name

$md = @(
    "# FilmCraft Command Catalog ($($cmds.Count) commands)"
    ""
    "| Namespace | Count |"
    "|---|---|"
)

foreach ($g in $grouped) {
    $md += "| ``$($g.Name)`` | $($g.Count) |"
}

$md += ""
$md += "## Commands"
$md += ""

foreach ($g in $grouped) {
    $md += "### $($g.Name)"
    $md += ""
    foreach ($c in ($g.Group | Sort-Object id)) {
        $p = if ($c.params) { " $($c.params)" } else { "" }
        $sc = if ($c.shortcut) { "  ($($c.shortcut))" } else { "" }
        $md += "- ``$($c.id)``$p$sc"
    }
    $md += ""
}

$md | Set-Content (Join-Path $OutDir "commands.md") -Encoding utf8
Write-Host "Wrote command catalog to $OutDir (commands.json, commands.md, version.txt)"
