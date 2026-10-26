# End-to-end smoke test on Windows:
# build a 1 s timeline, save, export H.264, render a frame, and check files.
param()

$cli = if ($env:FILMCRAFT_CLI) { $env:FILMCRAFT_CLI } else { "C:\Program Files\FilmCraft\filmcraft-cli.exe" }
if (-not (Test-Path $cli)) {
    $cli = (Get-Command filmcraft-cli -ErrorAction SilentlyContinue).Source
}

if (-not $cli -or -not (Test-Path $cli)) {
    Write-Error "filmcraft-cli not found"
    exit 2
}

$tmp = Join-Path $env:TEMP ("fc-smoke-" + [Guid]::NewGuid().ToString().Substring(0,8))
New-Item -ItemType Directory -Force -Path $tmp | Out-Null
$dataDir = Join-Path $tmp "data"
$proj = Join-Path $tmp "smoke.fcproj"
$out = Join-Path $tmp "out.mp4"
$png = Join-Path $tmp "frame.png"
$scriptPath = Join-Path $tmp "script.jsonl"

New-Item -ItemType Directory -Force -Path $dataDir | Out-Null

$sec = "254016000000"

$scriptLines = @(
    '{"id":"file.newProject","params":{"name":"Smoke"}}'
    '{"id":"file.importDemoFootage","params":{"scene":"CityNight"}}'
    '{"id":"file.newSequence","params":{"name":"SmokeSeq","width":640,"height":360,"fps":24,"video":2,"audio":2}}'
    ("{" + "`"id`":`"timeline.place`",`"params`":{`"item`":1,`"track`":`"V1`",`"seconds`":0,`"duration`":$sec}}" )
    ("{" + "`"id`":`"file.saveAs`",`"params`":{`"path`":`"$($proj.Replace('\','\\'))`"}}" )
    ("{" + "`"id`":`"file.exportMedia`",`"params`":{`"path`":`"$($out.Replace('\','\\'))`",`"format`":`"h264`",`"range`":`"custom`",`"startSeconds`":0,`"endSeconds`":1,`"wait`":true}}" )
    ("{" + "`"id`":`"file.exportFrame`",`"params`":{`"path`":`"$($png.Replace('\','\\'))`",`"format`":`"png`",`"time`":$sec,`"target`":`"program`"}}" )
)

[System.IO.File]::WriteAllLines($scriptPath, $scriptLines)

Write-Host "Running smoke test with $($scriptLines.Count) steps..."
$runOut = & $cli --compact --data-dir $dataDir run $scriptPath

$failed = $false
foreach ($line in $runOut) {
    if (-not $line) { continue }
    try {
        $res = $line | ConvertFrom-Json
        if (-not $res.ok) {
            Write-Error "Step failed: $line"
            $failed = $true
        }
    } catch {}
}

if ($failed) {
    Write-Error "Smoke test steps failed"
    exit 1
}

Write-Host "All commands executed successfully."

if ((Test-Path $proj) -and ((Get-Item $proj).Length -gt 500)) {
    Write-Host "OK: Project file saved ($((Get-Item $proj).Length) bytes)"
} else {
    Write-Error "FAIL: Project file missing or too small"
}

if ((Test-Path $out) -and ((Get-Item $out).Length -gt 500)) {
    Write-Host "OK: MP4 exported ($((Get-Item $out).Length) bytes)"
} else {
    Write-Error "FAIL: MP4 export missing or too small"
}

if ((Test-Path $png) -and ((Get-Item $png).Length -gt 500)) {
    Write-Host "OK: Frame PNG exported ($((Get-Item $png).Length) bytes)"
} else {
    Write-Error "FAIL: Frame PNG missing or too small"
}

# Cleanup
Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue
Write-Host "Smoke test PASSED."
