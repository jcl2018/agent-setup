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

$readmePresent = Test-AnyPath @("README.md", "README.rst", "README.txt")
$licensePresent = Test-AnyPath @("LICENSE", "LICENSE.md", "LICENSE.txt", "COPYING")
$contributingPresent = Test-AnyPath @("CONTRIBUTING.md", ".github/CONTRIBUTING.md")
$securityPresent = Test-AnyPath @("SECURITY.md", ".github/SECURITY.md")
$conductPresent = Test-AnyPath @("CODE_OF_CONDUCT.md", ".github/CODE_OF_CONDUCT.md")
$ciPresent = Test-Path -LiteralPath (Join-Path $repoRoot ".github/workflows")
$issueTemplatesPresent = Test-Path -LiteralPath (Join-Path $repoRoot ".github/ISSUE_TEMPLATE")
$prTemplatePresent = Test-AnyPath @(".github/pull_request_template.md", "pull_request_template.md")
$testsPresent = (Test-Path -LiteralPath (Join-Path $repoRoot "tests")) -or (@(Get-ChildItem -LiteralPath $repoRoot -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "^(test|spec)" }).Count -gt 0)
$docsPresent = (Test-Path -LiteralPath (Join-Path $repoRoot "docs")) -or (Test-Path -LiteralPath (Join-Path $repoRoot "examples"))
$gitignorePresent = Test-AnyPath @(".gitignore")

if (-not $readmePresent) {
    Add-Finding blocker "Missing README: explain the problem, install steps, and first successful run."
} else {
    Add-Finding signal "README is present."
}

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

if (-not $testsPresent) {
    Add-Finding blocker "Missing tests: add at least one automated smoke test before inviting collaborators."
} else {
    Add-Finding signal "Automated tests are present."
}

if (-not $ciPresent) {
    Add-Finding important "Missing CI workflow: add GitHub Actions so collaborators can verify the project on fresh clones."
} else {
    Add-Finding signal "CI workflow directory is present."
}

if (-not $contributingPresent) {
    if ($Visibility -eq "private") {
        Add-Finding nice "Missing CONTRIBUTING.md: useful even for a private repo when teammates need shared setup and workflow guidance."
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

if ($docsPresent) {
    Add-Finding signal "Docs or examples folder is present."
} else {
    Add-Finding nice "No docs or examples folder found: consider adding docs/ or examples/ for deeper guidance."
}

if (-not $gitignorePresent) {
    Add-Finding important "Missing .gitignore: generated files and local data are easier to leak into GitHub history."
} else {
    Add-Finding signal ".gitignore is present."
}

$suspiciousPatterns = @(
    "*.db",
    "*.sqlite",
    "*.sqlite3",
    "*.db-journal",
    "*.bak",
    "*.pyc",
    "*.pyo",
    "*.xlsx",
    "*.xls",
    "*_output.txt",
    "__pycache__/*",
    ".env",
    ".env.*"
)

$suspiciousMatches = @(Get-TrackedMatches $suspiciousPatterns)
if ($suspiciousMatches.Count -gt 0) {
    $examples = @($suspiciousMatches | Select-Object -First 8)
    $suffix = ""
    if ($suspiciousMatches.Count -gt $examples.Count) {
        $suffix = " (+" + ($suspiciousMatches.Count - $examples.Count) + " more)"
    }

    Add-Finding blocker ("Tracked local or private artifacts: remove, anonymize, or move them out of git before wider sharing. Examples: " + ($examples -join ", ") + $suffix)
    if ($gitignorePresent) {
        Add-Finding important "Tracked local artifacts also suggest .gitignore should be expanded before the repo is shared more broadly."
    }
}

$largeTrackedFiles = foreach ($relativePath in $trackedFiles) {
    $fullPath = Join-Path $repoRoot $relativePath
    if (Test-Path -LiteralPath $fullPath) {
        $item = Get-Item -LiteralPath $fullPath
        if ($item.Length -ge 5MB) {
            [PSCustomObject]@{
                Path = $relativePath
                SizeMb = [math]::Round($item.Length / 1MB, 2)
            }
        }
    }
}

if (@($largeTrackedFiles).Count -gt 0) {
    $formatted = @($largeTrackedFiles | Select-Object -First 5 | ForEach-Object { "$($_.Path) ($($_.SizeMb) MB)" })
    Add-Finding important ("Large tracked files can make cloning and collaboration harder. Review: " + ($formatted -join ", "))
}

$pyprojectPath = Join-Path $repoRoot "pyproject.toml"
if (Test-Path -LiteralPath $pyprojectPath) {
    $pyproject = Get-Content -Raw -LiteralPath $pyprojectPath
    Add-Finding signal "pyproject.toml is present."
    if ($pyproject -notmatch "(?m)^\[project\.urls\]") {
        Add-Finding important "pyproject.toml has no [project.urls] section for Homepage, Repository, and Issues."
    }
    if ($pyproject -notmatch '(?m)^requires-python\s*=') {
        Add-Finding important "pyproject.toml does not declare requires-python."
    }
}

$textFilePatterns = @("*.py", "*.ps1", "*.sh", "*.js", "*.ts", "*.tsx", "*.jsx", "*.yml", "*.yaml", "*.toml", "*.json", "*.ini", "*.cfg")
$sourceFiles = @(Get-ChildItem -LiteralPath $repoRoot -Recurse -File -Include $textFilePatterns -ErrorAction SilentlyContinue | Where-Object { $_.FullName -notmatch "[\\/]\.git([\\/]|$)" })
$secretRegex = '(?i)(secret|api[_-]?key|token|password)[^`r`n]{0,40}?[:=]\s*["''][^"'']+["'']'
$secretHits = foreach ($file in $sourceFiles) {
    Select-String -Path $file.FullName -Pattern $secretRegex -ErrorAction SilentlyContinue
}
$secretExamples = @($secretHits | Select-Object -First 5 | ForEach-Object { "$(Get-RelativePath $_.Path):$($_.LineNumber)" })
if ($secretExamples.Count -gt 0) {
    Add-Finding important ("Possible hardcoded secret-like literals found. Review: " + ($secretExamples -join ", "))
}

Write-Output "# GitHub Repo Readiness Audit"
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
