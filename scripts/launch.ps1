# Launch FilmCraft with control port and control token for live bridge on Windows
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

# Ensure 64-char hex control token
$token = $env:FILMCRAFT_CONTROL_TOKEN
if (-not $token) {
    $token = [Environment]::GetEnvironmentVariable('FILMCRAFT_CONTROL_TOKEN', 'User')
}
if (-not $token -or $token.Length -ne 64) {
    $bytes = New-Object byte[] 32
    $rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $rng.GetBytes($bytes)
    $sb = New-Object System.Text.StringBuilder
    for ($i = 0; $i -lt 32; $i++) {
        [void]$sb.AppendFormat("{0:x2}", $bytes[$i])
    }
    $token = $sb.ToString()
    [Environment]::SetEnvironmentVariable('FILMCRAFT_CONTROL_TOKEN', $token, 'User')
}
$env:FILMCRAFT_CONTROL_TOKEN = $token
[Environment]::SetEnvironmentVariable('FILMCRAFT_CONTROL_PORT', $Port.ToString(), 'User')
$env:FILMCRAFT_CONTROL_PORT = $Port.ToString()

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

Write-Host "Starting FilmCraft with control port $Port and secure token..."
Start-Process -FilePath $exe -ArgumentList ($argList -join " ")

# Wait and verify
$ready = $false
for ($i = 0; $i -lt 20; $i++) {
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
    Write-Warning "FilmCraft process started, but control port $Port timed out after 16 seconds."
    exit 1
}
