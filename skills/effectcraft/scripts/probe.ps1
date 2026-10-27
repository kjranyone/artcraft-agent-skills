# Probe EffectCraft MCP surface on Windows
# Usage: powershell -File probe.ps1 [-Bridge 50052]
param(
    [string]$Bridge = ""
)

$cli = if ($env:EFFECTCRAFT_CLI) { $env:EFFECTCRAFT_CLI } else { "C:\Program Files\EffectCraft\effectcraft-cli.exe" }
if (-not (Test-Path $cli)) {
    $cli = (Get-Command effectcraft-cli -ErrorAction SilentlyContinue).Source
}
if (-not $cli -or -not (Test-Path $cli)) {
    Write-Error "effectcraft-cli not found"
    exit 2
}

Write-Host "effectcraft-cli: $(& $cli --version 2>&1)"

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
$script:id = 0
function Send-Rpc($method, $params = $null) {
    $script:id += 1
    $req = [ordered]@{ jsonrpc = "2.0"; id = $script:id; method = $method }
    if ($params) { $req["params"] = $params }
    $p.StandardInput.WriteLine(($req | ConvertTo-Json -Compress))
    $p.StandardInput.Flush()
    while (-not $p.StandardOutput.EndOfStream) {
        $line = $p.StandardOutput.ReadLine()
        if (-not $line) { continue }
        try {
            $resp = $line | ConvertFrom-Json
            if ($resp.id -eq $script:id) { return $resp }
        } catch {}
    }
    return $null
}

try {
    $init = Send-Rpc -method "initialize" -params @{
        protocolVersion = "2025-06-18"; capabilities = @{}
        clientInfo = @{ name = "effectcraft-probe"; version = "1" }
    }
    Write-Host "Protocol: $($init.result.protocolVersion)"
    Write-Host "Server: $($init.result.serverInfo.name) $($init.result.serverInfo.version)"

    $p.StandardInput.WriteLine((@{ jsonrpc = "2.0"; method = "notifications/initialized" } | ConvertTo-Json -Compress))
    $p.StandardInput.Flush()

    $tools = Send-Rpc -method "tools/list"
    Write-Host "Tools count: $($tools.result.tools.Count)"
    $names = $tools.result.tools | ForEach-Object { $_.name }
    Write-Host ("Tools: " + ($names -join ", "))
    $expected = @("command_list","command_run","batch","doc_inspect","get_project","get_comp",
                  "get_layer","get_property","set_property","add_keyframe","add_effect",
                  "list_effects","list_fonts","run_script","render_frame","get_state",
                  "open_project","save_project","undo")
    $missing = $expected | Where-Object { $names -notcontains $_ }
    if ($missing) {
        Write-Warning ("MISSING TOOLS: " + ($missing -join ", "))
        exit 1
    }

    $res = Send-Rpc -method "resources/list"
    Write-Host ("Resources: " + (($res.result.resources | ForEach-Object { $_.uri }) -join ", "))

    $cmd = Send-Rpc -method "tools/call" -params @{ name = "command_list"; arguments = @{} }
    $cmds = $cmd.result.content[0].text | ConvertFrom-Json
    Write-Host "Commands: $($cmds.Count)"
    Write-Host "PROBE OK"
} finally {
    try { $p.Kill() } catch {}
}
