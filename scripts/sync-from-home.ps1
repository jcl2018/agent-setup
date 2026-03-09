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

$scriptPath = Join-Path $PSScriptRoot "home-mirror.ps1"
& $scriptPath -Direction "from-home" -Tool $Tool -RepoRoot $RepoRoot -HomeRoot $HomeRoot -WhatIf:$WhatIfPreference
exit $LASTEXITCODE
