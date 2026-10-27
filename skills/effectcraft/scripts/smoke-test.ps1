# End-to-end smoke test (Windows): build a comp with an animated, blurred text
# layer, save, render one frame and an H.264 movie, then validate the artifacts.
# Usage: powershell -File smoke-test.ps1
$ErrorActionPreference = "Stop"

$cli = if ($env:EFFECTCRAFT_CLI) { $env:EFFECTCRAFT_CLI } else { "C:\Program Files\EffectCraft\effectcraft-cli.exe" }
if (-not (Test-Path $cli)) {
    $cli = (Get-Command effectcraft-cli -ErrorAction SilentlyContinue).Source
}
if (-not $cli -or -not (Test-Path $cli)) {
    Write-Error "effectcraft-cli not found"
    exit 2
}

$tmp = Join-Path $env:TEMP ("ec-smoke-" + [guid]::NewGuid().ToString("N").Substring(0, 8))
New-Item -ItemType Directory -Path $tmp | Out-Null
$proj = Join-Path $tmp "smoke.ecproj"
$out = Join-Path $tmp "out.mp4"
$png = Join-Path $tmp "frame.png"

try {
    Write-Host "smoke: $(& $cli --version) in $tmp"

    & $cli --empty --save-as $proj run `
      'file.newProject' '{}' `
      'comp.new' '{"name":"Smoke","width":640,"height":360,"frameRate":30,"duration":3}' `
      'layer.newText' '{"text":"SMOKE","size":96,"fill":"#ff5533","position":[320,180]}' `
      'prop.addKey' '{"layer":2,"path":"transform.position","timeBase":"comp","time":0,"value":[100,180]}' `
      'prop.addKey' '{"layer":2,"path":"transform.position","timeBase":"comp","time":2,"value":[540,180]}' `
      'effect.apply' '{"effect":"Gaussian Blur","layers":[2]}' `
      --json | Out-Host

    if ($LASTEXITCODE -ne 0) { throw "build run failed" }

    & $cli --project $proj render-frame --out $png --time 1.0 --max-side 320 | Out-Host
    if ($LASTEXITCODE -ne 0) { throw "render-frame failed" }

    & $cli --project $proj render --out $out --format h264 --start 0 --end 2 | Out-Host
    if ($LASTEXITCODE -ne 0) { throw "render failed" }

    foreach ($f in @($proj, $out, $png)) {
        $size = (Get-Item $f).Length
        if ($size -lt 1000) { throw "$f too small ($size bytes)" }
        Write-Host "ok   $f ($size bytes)"
    }

    $raw = [System.IO.File]::ReadAllBytes($png)
    $sig = [System.Text.Encoding]::ASCII.GetString($raw[1..7])
    if ($sig -ne "PNG\r\n\x1a\n") { $sigOk = ($raw[0] -eq 0x89) } else { $sigOk = $true }
    $w = ($raw[16] -shl 24) -bor ($raw[17] -shl 16) -bor ($raw[18] -shl 8) -bor $raw[19]
    $h = ($raw[20] -shl 24) -bor ($raw[21] -shl 16) -bor ($raw[22] -shl 8) -bor $raw[23]
    if (-not $sigOk) { throw "PNG signature mismatch" }
    if ("$($w)x$($h)" -ne "320x180") { throw "PNG is ${w}x${h}, want 320x180" }
    Write-Host "ok   PNG 320x180"

    $mp4 = [System.Text.Encoding]::ASCII.GetString([System.IO.File]::ReadAllBytes($out)[4..11])
    if (-not $mp4.Contains("ftyp")) { throw "MP4 missing ftyp box" }
    Write-Host "ok   MP4 container (ftyp)"

    Write-Host "SMOKE OK"
} finally {
    Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue
}
