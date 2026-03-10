[CmdletBinding(SupportsShouldProcess)]
param(
    [string[]]$Tool = @("all"),
    [string]$RepoRoot,
    [string]$HomeRoot
)

if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
    $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

if ([string]::IsNullOrWhiteSpace($HomeRoot)) {
    $HomeRoot = $HOME
}

$skillSyncPath = Join-Path $PSScriptRoot "sync-shared-skills.ps1"
& $skillSyncPath -RepoRoot $RepoRoot -WhatIf:$WhatIfPreference
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

$scriptPath = Join-Path $PSScriptRoot "home-mirror.ps1"
& $scriptPath -Direction "to-home" -Tool $Tool -RepoRoot $RepoRoot -HomeRoot $HomeRoot -WhatIf:$WhatIfPreference
exit $LASTEXITCODE
