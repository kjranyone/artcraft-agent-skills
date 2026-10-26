# Probe FilmCraft MCP surface on Windows
param(
    [string]$Bridge = ""
)

$cli = if ($env:FILMCRAFT_CLI) { $env:FILMCRAFT_CLI } else { "C:\Program Files\FilmCraft\filmcraft-cli.exe" }
if (-not (Test-Path $cli)) {
    $cli = (Get-Command filmcraft-cli -ErrorAction SilentlyContinue).Source
}

if (-not $cli -or -not (Test-Path $cli)) {
    Write-Error "filmcraft-cli not found"
    exit 2
}

$version = & $cli --version 2>&1
Write-Host "filmcraft-cli: $version"

$argsList = @("mcp")
if ($Bridge) {
    $argsList += @("--bridge", $Bridge)
    Write-Host "Mode: bridge $Bridge"
} else {
    $argsList += "--demo"
    Write-Host "Mode: headless (--demo)"
}

$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = $cli
$psi.Arguments = ($argsList -join " ")
$psi.UseShellExecute = $false
$psi.RedirectStandardInput = $true
$psi.RedirectStandardOutput = $true
$psi.RedirectStandardError = $true
$psi.StandardOutputEncoding = [System.Text.Encoding]::UTF8

$p = [System.Diagnostics.Process]::Start($psi)

function Send-Rpc($method, $params = $null, $id = 1) {
    $req = [ordered]@{
        jsonrpc = "2.0"
        id = $id
        method = $method
    }
    if ($params) { $req["params"] = $params }
    $json = $req | ConvertTo-Json -Compress
    $p.StandardInput.WriteLine($json)
    $p.StandardInput.Flush()
    
    while (-not $p.StandardOutput.EndOfStream) {
        $line = $p.StandardOutput.ReadLine()
        if (-not $line) { continue }
        try {
            $resp = $line | ConvertFrom-Json
            if ($resp.id -eq $id) { return $resp }
        } catch {}
    }
    return $null
}

try {
    $init = Send-Rpc -method "initialize" -params @{
        protocolVersion = "2025-06-18"
        capabilities = @{}
        clientInfo = @{ name = "filmcraft-probe"; version = "1" }
    } -id 1

    Write-Host "Protocol: $($init.result.protocolVersion)"
    Write-Host "Server: $($init.result.serverInfo.name) $($init.result.serverInfo.version)"

    $notif = @{ jsonrpc = "2.0"; method = "notifications/initialized" } | ConvertTo-Json -Compress
    $p.StandardInput.WriteLine($notif)
    $p.StandardInput.Flush()

    $tools = Send-Rpc -method "tools/list" -id 2
    $toolList = $tools.result.tools
    Write-Host "Tools count: $($toolList.Count)"
    foreach ($t in $toolList) {
        Write-Host "  - $($t.name): $($t.description)"
    }
} finally {
    $p.Kill()
}
