# Launch EffectCraft with a control port for the live bridge on Windows (interactive desktop).
# No control token is required (unlike FilmCraft).
# Usage: powershell -File launch.ps1 [-Port 50052] [-Project "path\to\p.ecproj"]
param(
    [int]$Port = 50052,
    [string]$Project = ""
)

$exe = if ($env:EFFECTCRAFT_BIN) { $env:EFFECTCRAFT_BIN } else { "C:\Program Files\EffectCraft\effectcraft.exe" }
$cli = if ($env:EFFECTCRAFT_CLI) { $env:EFFECTCRAFT_CLI } else { "C:\Program Files\EffectCraft\effectcraft-cli.exe" }

if (-not (Test-Path $exe)) {
    Write-Error "EffectCraft executable not found at $exe"
    exit 2
}

[Environment]::SetEnvironmentVariable('EFFECTCRAFT_CONTROL_PORT', $Port.ToString(), 'User')
$env:EFFECTCRAFT_CONTROL_PORT = $Port.ToString()

# Check if EffectCraft is already running
$running = Get-Process effectcraft -ErrorAction SilentlyContinue
if ($running) {
    $info = & $cli --bridge $Port info 2>&1
    if ($LASTEXITCODE -eq 0 -or $info -match "effectcraft.*bridge") {
        Write-Host "EffectCraft is already running and listening on control port $Port."
        exit 0
    }
    Write-Warning "EffectCraft is already running (PID $($running[0].Id)), but control port $Port is NOT responding."
    Write-Warning "Save and close the running instance first, then re-run launch."
    exit 1
}

$argList = @("--control", $Port.ToString())
if ($Project) { $argList += $Project }

Write-Host "Launching EffectCraft on the interactive desktop with control port $Port..."

# Scheduled task breaks out of job objects and attaches to the user desktop,
# so the window is visible instead of hidden in a background session.
$taskName = "EffectCraft_Live_Bridge"
$action = New-ScheduledTaskAction -Execute $exe -Argument ($argList -join " ")
$principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType Interactive
Register-ScheduledTask -TaskName $taskName -Action $action -Principal $principal -Force | Out-Null
Start-ScheduledTask -TaskName $taskName

$ready = $false
for ($i = 0; $i -lt 25; $i++) {
    Start-Sleep -Milliseconds 800
    $info = & $cli --bridge $Port info 2>&1
    if ($LASTEXITCODE -eq 0 -or $info -match "effectcraft.*bridge") {
        $ready = $true
        break
    }
}

if ($ready) {
    Write-Host "EffectCraft launched and ready on 127.0.0.1:$Port (no token needed)."
    exit 0
} else {
    Write-Warning "EffectCraft process started, but control port $Port timed out after 20 seconds."
    exit 1
}
