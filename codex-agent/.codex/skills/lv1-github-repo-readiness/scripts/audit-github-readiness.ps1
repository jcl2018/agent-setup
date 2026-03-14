param(
    [string]$RepoPath = ".",
    [ValidateSet("private", "public", "either")]
    [string]$Visibility = "either"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path -LiteralPath $RepoPath).Path
$gitCheck = git -C $repoRoot rev-parse --is-inside-work-tree 2>$null
if ($LASTEXITCODE -ne 0 -or $gitCheck.Trim() -ne "true") {
    Write-Error "Path is not inside a git work tree: $repoRoot"
    exit 1
}

$trackedFiles = @(git -C $repoRoot ls-files)

$releaseBlockers = New-Object System.Collections.Generic.List[string]
$important = New-Object System.Collections.Generic.List[string]
$niceToHave = New-Object System.Collections.Generic.List[string]
$signals = New-Object System.Collections.Generic.List[string]

function Add-Finding {
    param(
        [string]$Severity,
        [string]$Message
    )

    switch ($Severity) {
        "blocker" { $script:releaseBlockers.Add($Message) }
        "important" { $script:important.Add($Message) }
        "nice" { $script:niceToHave.Add($Message) }
        "signal" { $script:signals.Add($Message) }
        default { throw "Unknown severity: $Severity" }
    }
}

function Test-AnyPath {
    param([string[]]$Candidates)

    foreach ($candidate in $Candidates) {
        if (Test-Path -LiteralPath (Join-Path $repoRoot $candidate)) {
            return $true
        }
    }

    return $false
}

function Get-TrackedMatches {
    param([string[]]$Patterns)

    $matches = foreach ($pattern in $Patterns) {
        $trackedFiles | Where-Object { $_ -like $pattern }
    }

    @(
        $matches |
            Sort-Object -Unique -Property `
                @{ Expression = { ($_ -split "[/\\]").Count } }, `
                @{ Expression = { $_ } }
    )
}

function Get-RelativePath {
    param([string]$FullPath)

    $normalizedRoot = [System.IO.Path]::GetFullPath($repoRoot)
    $normalizedPath = [System.IO.Path]::GetFullPath($FullPath)
    if ($normalizedPath.StartsWith($normalizedRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $normalizedPath.Substring($normalizedRoot.Length).TrimStart("\", "/")
    }

    return $normalizedPath
}

function Get-TrackedTextFiles {
    param([string[]]$Patterns)

    foreach ($relativePath in $trackedFiles) {
        $matchesPattern = $false
        foreach ($pattern in $Patterns) {
            if ($relativePath -like $pattern) {
                $matchesPattern = $true
                break
            }
        }

        if (-not $matchesPattern) {
            continue
        }

        $fullPath = Join-Path $repoRoot $relativePath
        if (-not (Test-Path -LiteralPath $fullPath)) {
            continue
        }

        try {
            Get-Item -LiteralPath $fullPath -ErrorAction Stop
        } catch {
            continue
        }
    }
}

$licensePresent = Test-AnyPath @("LICENSE", "LICENSE.md", "LICENSE.txt", "COPYING")
$contributingPresent = Test-AnyPath @("CONTRIBUTING.md", ".github/CONTRIBUTING.md")
$securityPresent = Test-AnyPath @("SECURITY.md", ".github/SECURITY.md")
$conductPresent = Test-AnyPath @("CODE_OF_CONDUCT.md", ".github/CODE_OF_CONDUCT.md")
$ciPresent = Test-Path -LiteralPath (Join-Path $repoRoot ".github/workflows")
$issueTemplatesPresent = Test-Path -LiteralPath (Join-Path $repoRoot ".github/ISSUE_TEMPLATE")
$prTemplatePresent = Test-AnyPath @(".github/pull_request_template.md", "pull_request_template.md")

switch ($Visibility) {
    "public" {
        if (-not $licensePresent) {
            Add-Finding blocker "Missing license: add a real LICENSE file before public release so reuse terms are explicit."
        } else {
            Add-Finding signal "License file is present."
        }
    }
    "either" {
        if (-not $licensePresent) {
            Add-Finding important "Missing license: acceptable for a private repo today, but required before any public release."
        } else {
            Add-Finding signal "License file is present."
        }
    }
    "private" {
        if (-not $licensePresent) {
            Add-Finding nice "No LICENSE file found. That can be acceptable for a private repo, but add one before any public release."
        } else {
            Add-Finding signal "License file is present."
        }
    }
}

if (-not $ciPresent) {
    Add-Finding important "Missing CI workflow under .github/workflows: add GitHub Actions so collaborators can validate changes from fresh clones."
} else {
    Add-Finding signal "GitHub workflow directory is present."
}

if (-not $contributingPresent) {
    if ($Visibility -eq "private") {
        Add-Finding nice "Missing CONTRIBUTING.md: useful even for a private repo when teammates need shared workflow guidance."
    } else {
        Add-Finding important "Missing CONTRIBUTING.md: document setup, tests, style expectations, and how to propose changes."
    }
} else {
    Add-Finding signal "Contributor guidance is present."
}

if (-not $securityPresent) {
    if ($Visibility -eq "private") {
        Add-Finding nice "Missing SECURITY.md: useful if teammates need a private path for reporting vulnerabilities or secret leaks."
    } else {
        Add-Finding important "Missing SECURITY.md: explain how to report vulnerabilities privately."
    }
} else {
    Add-Finding signal "Security policy is present."
}

if (-not $conductPresent) {
    if ($Visibility -ne "private") {
        Add-Finding nice "Missing CODE_OF_CONDUCT.md: useful once outside contributors start arriving."
    }
} else {
    Add-Finding signal "Code of conduct is present."
}

if (-not $issueTemplatesPresent) {
    if ($Visibility -ne "private") {
        Add-Finding nice "Missing issue templates: add bug-report and feature-request templates under .github/ISSUE_TEMPLATE."
    }
} else {
    Add-Finding signal "Issue templates are present."
}

if (-not $prTemplatePresent) {
    if ($Visibility -ne "private") {
        Add-Finding nice "Missing pull request template: ask for summary, testing, and screenshots when relevant."
    }
} else {
    Add-Finding signal "Pull request template is present."
}

$localOnlyRecordPatterns = @(
    "*progress-tracker.md",
    "*future-plan.md",
    ".codex/auth.json",
    ".codex/cap_sid",
    ".codex/.codex-global-state.json",
    ".codex/.personality_migration",
    ".codex/models_cache.json",
    ".codex/session_index.jsonl",
    ".codex/sessions/*",
    ".codex/sqlite/*",
    ".codex/state_*.sqlite",
    ".codex/state_*.sqlite-*",
    ".codex/tmp/*",
    ".codex/vendor_imports/*"
)

$localOnlyRecordMatches = @(Get-TrackedMatches $localOnlyRecordPatterns)
if ($localOnlyRecordMatches.Count -gt 0) {
    $examples = @($localOnlyRecordMatches | Select-Object -First 8)
    $suffix = ""
    if ($localOnlyRecordMatches.Count -gt $examples.Count) {
        $suffix = " (+" + ($localOnlyRecordMatches.Count - $examples.Count) + " more)"
    }

    Add-Finding blocker ("Tracked local tracking files or tool runtime/session files should stay off remotes. Remove or untrack them before sharing. Examples: " + ($examples -join ", ") + $suffix)
}

$textFilePatterns = @("*.md", "*.txt", "*.rst", "*.py", "*.ps1", "*.sh", "*.js", "*.ts", "*.tsx", "*.jsx", "*.yml", "*.yaml", "*.toml", "*.json", "*.ini", "*.cfg")
$trackedTextFiles = @(Get-TrackedTextFiles $textFilePatterns)
$absolutePathRegex = '(?i)(/Users/[^/\s"'']+(?:/[^\s"'']+)*)|(/home/[^/\s"'']+(?:/[^\s"'']+)*)|([A-Z]:\\Users\\[^\\\s"'']+(?:\\[^\\\s"'']+)*)'
$absolutePathHits = foreach ($file in $trackedTextFiles) {
    Select-String -Path $file.FullName -Pattern $absolutePathRegex -ErrorAction SilentlyContinue
}
$absolutePathExamples = @($absolutePathHits | Select-Object -First 5 | ForEach-Object { "$(Get-RelativePath $_.Path):$($_.LineNumber)" })
if ($absolutePathExamples.Count -gt 0) {
    Add-Finding blocker ("Tracked shareable files contain user-specific absolute filesystem paths. Replace them with repo-relative paths, or `~`-relative home-install paths before sharing. Review: " + ($absolutePathExamples -join ", "))
}

$pyprojectPath = Join-Path $repoRoot "pyproject.toml"
if (Test-Path -LiteralPath $pyprojectPath) {
    $pyproject = Get-Content -Raw -LiteralPath $pyprojectPath
    Add-Finding signal "pyproject.toml is present."
    if ($pyproject -notmatch "(?m)^\[project\.urls\]") {
        Add-Finding important "pyproject.toml has no [project.urls] section for Homepage, Repository, and Issues."
    }
}

$packageJsonPath = Join-Path $repoRoot "package.json"
if (Test-Path -LiteralPath $packageJsonPath) {
    try {
        $packageJson = Get-Content -Raw -LiteralPath $packageJsonPath | ConvertFrom-Json
        Add-Finding signal "package.json is present."
        if (-not $packageJson.repository) {
            Add-Finding important "package.json has no repository field."
        }
        if (-not $packageJson.homepage) {
            Add-Finding nice "package.json has no homepage field."
        }
        if (-not $packageJson.bugs) {
            Add-Finding nice "package.json has no bugs field."
        }
    } catch {
        Add-Finding important "package.json is present but could not be parsed for repository metadata."
    }
}

Write-Output "# GitHub Readiness Audit"
Write-Output "Repo: $repoRoot"
Write-Output "Visibility target: $Visibility"
Write-Output ""

function Write-Section {
    param(
        [string]$Title,
        [System.Collections.Generic.List[string]]$Items
    )

    Write-Output "## $Title"
    if ($Items.Count -eq 0) {
        Write-Output "- None found."
    } else {
        foreach ($item in $Items) {
            Write-Output "- $item"
        }
    }
    Write-Output ""
}

Write-Section "Release blockers" $releaseBlockers
Write-Section "Important improvements" $important
Write-Section "Nice-to-have polish" $niceToHave
Write-Section "Signals already in place" $signals
