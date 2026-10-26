# Launch FilmCraft with control port for live bridge on Windows
param(
    [int]$Port = 50051,
    [string]$Project = ""
)

$exe = if ($env:FILMCRAFT_BIN) { $env:FILMCRAFT_BIN } else { "C:\Program Files\FilmCraft\filmcraft.exe" }
$cli = if ($env:FILMCRAFT_CLI) { $env:FILMCRAFT_CLI } else { "C:\Program Files\FilmCraft\filmcraft-cli.exe" }

if (-not (Test-Path $exe)) {
    Write-Error "FilmCraft executable not found at $exe"
    exit 2
}

# Check if filmcraft is already running
$running = Get-Process filmcraft -ErrorAction SilentlyContinue
if ($running) {
    # Check if control port is active
    $test = & $cli --bridge "127.0.0.1:$Port" inspect 2>&1
    if ($LASTEXITCODE -eq 0 -or $test -match "project|sequence|no active sequence") {
        Write-Host "FilmCraft is already running and listening on control port $Port."
        exit 0
    } else {
        Write-Warning "FilmCraft is already running (PID $($running.Id)), but control port $Port is NOT responding."
        Write-Warning "Please save and close the running FilmCraft instance first, then re-run launch."
        exit 1
    }
}

$argList = @("--control", $Port.ToString())
if ($Project) {
    $argList += $Project
}

Write-Host "Starting FilmCraft with control port $Port..."
Start-Process -FilePath $exe -ArgumentList ($argList -join " ")

# Wait and verify
$ready = $false
for ($i = 0; $i -lt 15; $i++) {
    Start-Sleep -Milliseconds 800
    $resp = & $cli --bridge "127.0.0.1:$Port" inspect 2>&1
    if ($LASTEXITCODE -eq 0 -or $resp -match "project|sequence|no active sequence") {
        $ready = $true
        break
    }
}

if ($ready) {
    Write-Host "FilmCraft successfully launched and ready on 127.0.0.1:$Port!"
    exit 0
} else {
    Write-Warning "FilmCraft process started, but control port $Port timed out after 12 seconds."
    exit 1
}
