[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("to-home", "from-home")]
    [string]$Direction,

    [string[]]$Tool = @("all"),

    [string]$RepoRoot,

    [string]$HomeRoot
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
    $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

if ([string]::IsNullOrWhiteSpace($HomeRoot)) {
    $HomeRoot = $HOME
}

$toolSpecs = @{
    codex = @{
        RepoDir = ".codex"
        HomeDir = ".codex"
        Items   = @(
            "AGENTS.md",
            "config.toml",
            "workflows",
            "templates",
            "checklists",
            "knowledge",
            "skills",
            ".agents-home",
            "examples",
            "tasks"
        )
    }
    claude = @{
        RepoDir = ".claude"
        HomeDir = ".claude"
        Items   = @(
            "CLAUDE.md",
            "settings.json",
            "workflows",
            "templates",
            "checklists",
            "knowledge",
            "skills",
            "examples",
            "tasks"
        )
    }
    copilot = @{
        RepoDir = ".github"
        HomeDir = ".github"
        Items   = @(
            "copilot-instructions.md",
            "instructions",
            "agents",
            "workflows",
            "templates",
            "checklists",
            "knowledge",
            "examples",
            "tasks"
        )
    }
}

$toolAliases = @{
    github = "copilot"
}

$rootItems = @(
    "AGENTS.md"
)

$excludedKnowledgeFiles = @(
    "progress-tracker.md",
    "future-plan.md"
)

function Get-ExcludedChildNames {
    param([string]$RelativePath)

    if ($RelativePath -eq "knowledge") {
        return $excludedKnowledgeFiles
    }

    return @()
}

function Resolve-RequestedTools {
    param([string[]]$Requested)

    if ($Requested.Count -eq 0 -or $Requested -contains "all") {
        return @("codex", "claude", "copilot")
    }

    $resolved = New-Object System.Collections.Generic.List[string]
    foreach ($entry in $Requested) {
        $normalized = $entry.Trim().ToLowerInvariant()
        if ($toolAliases.ContainsKey($normalized)) {
            $normalized = $toolAliases[$normalized]
        }

        if (-not $toolSpecs.ContainsKey($normalized)) {
            throw "Unsupported tool '$entry'. Use one of: all, codex, claude, copilot."
        }

        if (-not $resolved.Contains($normalized)) {
            $resolved.Add($normalized)
        }
    }

    return @($resolved)
}

function Ensure-Directory {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        if ($PSCmdlet.ShouldProcess($Path, "Create directory")) {
            New-Item -ItemType Directory -Path $Path -Force | Out-Null
        }
    }
}

function Copy-ManagedItem {
    param(
        [string]$SourceRoot,
        [string]$DestinationRoot,
        [string]$RelativePath
    )

    $sourcePath = Join-Path $SourceRoot $RelativePath
    if (-not (Test-Path -LiteralPath $sourcePath)) {
        Write-Warning "Skipping missing path: $sourcePath"
        return $false
    }

    Ensure-Directory -Path $DestinationRoot

    $targetPath = Join-Path $DestinationRoot $RelativePath
    $sourceItem = Get-Item -LiteralPath $sourcePath
    if ($sourceItem.PSIsContainer) {
        Ensure-Directory -Path $targetPath
        $excludedChildNames = Get-ExcludedChildNames -RelativePath $RelativePath
        if ($PSCmdlet.ShouldProcess($targetPath, "Copy directory '$RelativePath'")) {
            foreach ($child in Get-ChildItem -Force -LiteralPath $sourcePath) {
                if ($excludedChildNames -contains $child.Name) {
                    continue
                }
                Copy-Item -LiteralPath $child.FullName -Destination $targetPath -Recurse -Force
            }
        }
    } else {
        $targetParent = Split-Path -Parent $targetPath
        Ensure-Directory -Path $targetParent
        if ($PSCmdlet.ShouldProcess($targetPath, "Copy file '$RelativePath'")) {
            Copy-Item -LiteralPath $sourcePath -Destination $targetPath -Force
        }
    }

    return $true
}

$requestedTools = Resolve-RequestedTools -Requested $Tool
$copied = 0

foreach ($toolName in $requestedTools) {
    $spec = $toolSpecs[$toolName]
    $repoToolRoot = Join-Path $RepoRoot $spec.RepoDir
    $homeToolRoot = Join-Path $HomeRoot $spec.HomeDir

    if ($Direction -eq "to-home") {
        $sourceRoot = $repoToolRoot
        $destinationRoot = $homeToolRoot
    } else {
        $sourceRoot = $homeToolRoot
        $destinationRoot = $repoToolRoot
    }

    foreach ($item in $spec.Items) {
        if (Copy-ManagedItem -SourceRoot $sourceRoot -DestinationRoot $destinationRoot -RelativePath $item) {
            $copied += 1
        }
    }
}

if ($Direction -eq "to-home") {
    $rootSourceRoot = $RepoRoot
    $rootDestinationRoot = $HomeRoot
} else {
    $rootSourceRoot = $HomeRoot
    $rootDestinationRoot = $RepoRoot
}

foreach ($item in $rootItems) {
    if (Copy-ManagedItem -SourceRoot $rootSourceRoot -DestinationRoot $rootDestinationRoot -RelativePath $item) {
        $copied += 1
    }
}

Write-Host ("Completed {0} sync for {1}. Managed items copied: {2}" -f $Direction, ($requestedTools -join ", "), $copied)
