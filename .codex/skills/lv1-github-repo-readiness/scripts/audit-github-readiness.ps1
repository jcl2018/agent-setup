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
