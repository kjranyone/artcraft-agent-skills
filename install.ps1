# Agent Skills auto-install for Windows (Junction, no admin required)
param([string]$Agent = "claude")
$skillsRoot = switch ($Agent) {
  "claude" { "$env:USERPROFILE\.claude\skills" }
  "antigravity" { "$env:USERPROFILE\.agents\skills" }
  "gemini" { "$env:USERPROFILE\.agents\skills" }
  "opencode" { "$env:USERPROFILE\.config\opencode\skills" }
  default { Write-Error "Unknown agent: $Agent"; exit 1 }
}
New-Item -ItemType Directory -Force -Path $skillsRoot | Out-Null
Get-ChildItem skills -Directory | ForEach-Object {
  $target = Join-Path $skillsRoot $_.Name
  if (Test-Path $target) { Write-Host "  $($_.Name): already installed, updating" }
  New-Item -ItemType Junction -Path $target -Target $_.FullName -Force | Out-Null
  Write-Host "  $($_.Name): installed -> $target"
}
Write-Host "Done. Restart your agent to discover the new skills."
