param(
    [string]$RepoRoot = ".",
    [string]$HomeRoot = $HOME
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-RequiredPath {
    param(
        [string]$Path,
        [string]$Label
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        Write-Error "$Label path not found: $Path"
        exit 1
    }

    return (Resolve-Path -LiteralPath $Path).Path
}

function Get-NormalizedRelativePath {
    param(
        [string]$BasePath,
        [string]$FullPath
    )

    $relativePath = $FullPath.Substring($BasePath.Length).TrimStart("\", "/")
    return $relativePath.Replace("\", "/")
}

function Get-TextFingerprint {
    param([string]$Text)

    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Text)
    $sha256 = [System.Security.Cryptography.SHA256]::Create()
    try {
        return ([System.BitConverter]::ToString($sha256.ComputeHash($bytes))).Replace("-", "")
    } finally {
        $sha256.Dispose()
    }
}

function Get-DirectoryFingerprint {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        return $null
    }

    $files = @(Get-ChildItem -LiteralPath $Path -Recurse -File -Force | Sort-Object FullName)
    if ($files.Count -eq 0) {
        return "__EMPTY__"
    }

    $parts = foreach ($file in $files) {
        $relativePath = Get-NormalizedRelativePath -BasePath $Path -FullPath $file.FullName
        $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $file.FullName).Hash
        "${relativePath}:$hash"
    }

    return Get-TextFingerprint -Text ([string]::Join("`n", $parts))
}

function Get-DirectoryInventory {
    param(
        [string]$Path,
        [string[]]$ExcludeNames = @()
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        return @()
    }

    $items = Get-ChildItem -LiteralPath $Path -Directory -Force |
        Where-Object { $ExcludeNames -notcontains $_.Name } |
        Sort-Object Name

    return @(
        foreach ($item in $items) {
            [PSCustomObject]@{
                Name        = $item.Name
                Fingerprint = Get-DirectoryFingerprint -Path $item.FullName
            }
        }
    )
}

function Get-FileInventory {
    param(
        [string]$Path,
        [string[]]$IncludeNames = @(),
        [string[]]$ExcludeNames = @()
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        return @()
    }

    $items = Get-ChildItem -LiteralPath $Path -File -Force |
        Where-Object {
            ($IncludeNames.Count -eq 0 -or $IncludeNames -contains $_.Name) -and
            ($ExcludeNames -notcontains $_.Name)
        } |
        Sort-Object Name

    return @(
        foreach ($item in $items) {
            [PSCustomObject]@{
                Name        = $item.Name
                Fingerprint = (Get-FileHash -Algorithm SHA256 -LiteralPath $item.FullName).Hash
            }
        }
    )
}

function Get-ExplicitFileInventory {
    param(
        [string]$BasePath,
        [string[]]$RelativePaths
    )

    return @(
        foreach ($relativePath in $RelativePaths) {
            $fullPath = Join-Path $BasePath $relativePath
            if (-not (Test-Path -LiteralPath $fullPath)) {
                continue
            }

            [PSCustomObject]@{
                Name        = $relativePath.Replace("\", "/")
                Fingerprint = (Get-FileHash -Algorithm SHA256 -LiteralPath $fullPath).Hash
            }
        }
    )
}

function Get-RecursiveFileInventory {
    param(
        [string]$Path,
        [string]$RelativePattern,
        [string[]]$ExcludeTopLevelNames = @()
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        return @()
    }

    $items = foreach ($file in Get-ChildItem -LiteralPath $Path -Recurse -File -Force) {
        $relativePath = Get-NormalizedRelativePath -BasePath $Path -FullPath $file.FullName
        $segments = $relativePath -split "/"
        if ($segments.Count -eq 0) {
            continue
        }

        if ($ExcludeTopLevelNames -contains $segments[0]) {
            continue
        }

        if ($relativePath -notlike $RelativePattern) {
            continue
        }

        [PSCustomObject]@{
            Name        = $relativePath
            Fingerprint = (Get-FileHash -Algorithm SHA256 -LiteralPath $file.FullName).Hash
        }
    }

    return @($items | Sort-Object Name)
}

function Compare-Inventory {
    param(
        [object[]]$RepoItems,
        [object[]]$HomeItems
    )

    $repoMap = @{}
    foreach ($item in $RepoItems) {
        $repoMap[$item.Name] = $item.Fingerprint
    }

    $homeMap = @{}
    foreach ($item in $HomeItems) {
        $homeMap[$item.Name] = $item.Fingerprint
    }

    $missing = @($RepoItems | Where-Object { -not $homeMap.ContainsKey($_.Name) } | ForEach-Object { $_.Name })
    $extra = @($HomeItems | Where-Object { -not $repoMap.ContainsKey($_.Name) } | ForEach-Object { $_.Name })
    $drift = @(
        foreach ($item in $RepoItems) {
            if ($homeMap.ContainsKey($item.Name) -and $homeMap[$item.Name] -ne $item.Fingerprint) {
                $item.Name
            }
        }
    )

    return [PSCustomObject]@{
        Missing        = $missing
        Extra          = $extra
        Drift          = $drift
        HasDiscrepancy = ($missing.Count -gt 0) -or ($extra.Count -gt 0) -or ($drift.Count -gt 0)
    }
}

function Format-NameList {
    param([string[]]$Names)

    if (-not $Names -or $Names.Count -eq 0) {
        return "none"
    }

    return ($Names | Sort-Object -Unique) -join ", "
}

function Format-InventoryLine {
    param([object[]]$Items)

    if (-not $Items -or $Items.Count -eq 0) {
        return "none"
    }

    return ($Items | ForEach-Object { $_.Name }) -join ", "
}

function Write-InventorySection {
    param(
        [string]$Title,
        [object[]]$RepoItems,
        [object[]]$HomeItems,
        [object]$Comparison,
        [string[]]$Notes = @()
    )

    Write-Output "### $Title"
    Write-Output "- Repo-managed ($($RepoItems.Count)): $(Format-InventoryLine -Items $RepoItems)"
    Write-Output "- Live home ($($HomeItems.Count)): $(Format-InventoryLine -Items $HomeItems)"
    Write-Output "- Missing from live home: $(Format-NameList -Names $Comparison.Missing)"
    Write-Output "- Extra on live home: $(Format-NameList -Names $Comparison.Extra)"
    Write-Output "- Content drift: $(Format-NameList -Names $Comparison.Drift)"

    foreach ($note in $Notes) {
        if (-not [string]::IsNullOrWhiteSpace($note)) {
            Write-Output "- Note: $note"
        }
    }

    Write-Output ""
}

$resolvedRepoRoot = Resolve-RequiredPath -Path $RepoRoot -Label "Repo root"
$resolvedHomeRoot = Resolve-RequiredPath -Path $HomeRoot -Label "Home root"

$codexBuiltinExtras = @()
if (Test-Path -LiteralPath (Join-Path $resolvedHomeRoot ".codex\skills\.system")) {
    $codexBuiltinExtras += ".system"
}

$codexAgentsHomeExtras = @()
if (Test-Path -LiteralPath (Join-Path $resolvedHomeRoot ".codex\.agents-home\skills\_removed-skills")) {
    $codexAgentsHomeExtras += "_removed-skills"
}

$sharedSkillsRepo = Get-DirectoryInventory -Path (Join-Path $resolvedRepoRoot ".ai_shared\skills")
$sharedSkillsHome = Get-DirectoryInventory -Path (Join-Path $resolvedHomeRoot ".ai_shared\skills")
$codexSkillsRepo = Get-DirectoryInventory -Path (Join-Path $resolvedRepoRoot ".codex\skills") -ExcludeNames @(".system")
$codexSkillsHome = Get-DirectoryInventory -Path (Join-Path $resolvedHomeRoot ".codex\skills") -ExcludeNames @(".system")
$codexAgentsHomeRepo = Get-DirectoryInventory -Path (Join-Path $resolvedRepoRoot ".codex\.agents-home\skills") -ExcludeNames @("_removed-skills")
$codexAgentsHomeHome = Get-DirectoryInventory -Path (Join-Path $resolvedHomeRoot ".codex\.agents-home\skills") -ExcludeNames @("_removed-skills")

$workflowsRepo = Get-FileInventory -Path (Join-Path $resolvedRepoRoot ".ai_shared\workflows")
$workflowsHome = Get-FileInventory -Path (Join-Path $resolvedHomeRoot ".ai_shared\workflows")
$checklistsRepo = Get-FileInventory -Path (Join-Path $resolvedRepoRoot ".ai_shared\checklists")
$checklistsHome = Get-FileInventory -Path (Join-Path $resolvedHomeRoot ".ai_shared\checklists")
$ruleNoteNames = @(
    "agent-authoring.md",
    "agent-stack.md",
    "coding-standards.md",
    "home-audit-rules.md",
    "naming-conventions.md",
    "remote-sharing-rules.md"
)
$ruleNotesRepo = Get-FileInventory -Path (Join-Path $resolvedRepoRoot ".ai_shared\knowledge") -IncludeNames $ruleNoteNames
$ruleNotesHome = Get-FileInventory -Path (Join-Path $resolvedHomeRoot ".ai_shared\knowledge") -IncludeNames $ruleNoteNames

$agentEntryFiles = @(
    "AGENTS.md",
    ".codex\AGENTS.md"
)
$agentEntryRepo = Get-ExplicitFileInventory -BasePath $resolvedRepoRoot -RelativePaths $agentEntryFiles
$agentEntryHome = Get-ExplicitFileInventory -BasePath $resolvedHomeRoot -RelativePaths $agentEntryFiles
$codexManifestRepo = Get-RecursiveFileInventory -Path (Join-Path $resolvedRepoRoot ".codex\skills") -RelativePattern "*/agents/openai.yaml" -ExcludeTopLevelNames @(".system")
$codexManifestHome = Get-RecursiveFileInventory -Path (Join-Path $resolvedHomeRoot ".codex\skills") -RelativePattern "*/agents/openai.yaml" -ExcludeTopLevelNames @(".system")

$sections = @(
    [PSCustomObject]@{
        Title      = "Shared skills"
        RepoItems  = $sharedSkillsRepo
        HomeItems  = $sharedSkillsHome
        Notes      = @()
    },
    [PSCustomObject]@{
        Title      = "Codex skills"
        RepoItems  = $codexSkillsRepo
        HomeItems  = $codexSkillsHome
        Notes      = @(
            if ($codexBuiltinExtras.Count -gt 0) {
                "Ignored home-only builtins: $(Format-NameList -Names $codexBuiltinExtras)"
            }
        )
    },
    [PSCustomObject]@{
        Title      = "Codex home-library skills"
        RepoItems  = $codexAgentsHomeRepo
        HomeItems  = $codexAgentsHomeHome
        Notes      = @(
            if ($codexAgentsHomeExtras.Count -gt 0) {
                "Ignored home-only archives: $(Format-NameList -Names $codexAgentsHomeExtras)"
            }
        )
    },
    [PSCustomObject]@{
        Title      = "Workflows"
        RepoItems  = $workflowsRepo
        HomeItems  = $workflowsHome
        Notes      = @()
    },
    [PSCustomObject]@{
        Title      = "Checklists"
        RepoItems  = $checklistsRepo
        HomeItems  = $checklistsHome
        Notes      = @()
    },
    [PSCustomObject]@{
        Title      = "Rule notes"
        RepoItems  = $ruleNotesRepo
        HomeItems  = $ruleNotesHome
        Notes      = @()
    },
    [PSCustomObject]@{
        Title      = "Agent entry files"
        RepoItems  = $agentEntryRepo
        HomeItems  = $agentEntryHome
        Notes      = @()
    },
    [PSCustomObject]@{
        Title      = "Codex agent manifests"
        RepoItems  = $codexManifestRepo
        HomeItems  = $codexManifestHome
        Notes      = @()
    }
)

$discrepancyTitles = New-Object System.Collections.Generic.List[string]
foreach ($section in $sections) {
    $comparison = Compare-Inventory -RepoItems $section.RepoItems -HomeItems $section.HomeItems
    $section | Add-Member -NotePropertyName Comparison -NotePropertyValue $comparison
    if ($comparison.HasDiscrepancy) {
        $discrepancyTitles.Add($section.Title)
    }
}

Write-Output "# Home Audit Checkup"
Write-Output "Repo root: $resolvedRepoRoot"
Write-Output "Home root: $resolvedHomeRoot"
Write-Output ""
Write-Output "## Checkup"
if ($discrepancyTitles.Count -eq 0) {
    Write-Output "- Managed skills, rules, and agent surfaces match between the repo and the live home install."
} else {
    Write-Output "- Review discrepancies in: $(Format-NameList -Names $discrepancyTitles)"
}
Write-Output ""

foreach ($section in $sections) {
    Write-InventorySection -Title $section.Title -RepoItems $section.RepoItems -HomeItems $section.HomeItems -Comparison $section.Comparison -Notes $section.Notes
}
