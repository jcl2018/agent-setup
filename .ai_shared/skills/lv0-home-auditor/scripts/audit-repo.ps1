param(
    [string]$RepoPath = "."
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

$repoBlockers = New-Object System.Collections.Generic.List[string]
$important = New-Object System.Collections.Generic.List[string]
$niceToHave = New-Object System.Collections.Generic.List[string]
$signals = New-Object System.Collections.Generic.List[string]

function Add-Finding {
    param(
        [string]$Severity,
        [string]$Message
    )

    switch ($Severity) {
        "blocker" { $script:repoBlockers.Add($Message) }
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

function Test-DocumentedValidationPath {
    param([string[]]$Candidates)

    foreach ($candidate in $Candidates) {
        $fullPath = Join-Path $repoRoot $candidate
        if (-not (Test-Path -LiteralPath $fullPath)) {
            continue
        }

        $content = Get-Content -Raw -LiteralPath $fullPath -ErrorAction SilentlyContinue
        if ([string]::IsNullOrWhiteSpace($content)) {
            continue
        }

        $hasCommandExample = ($content -match '(?s)```.+?```') -or ($content -match '(?m)^-\s+`[^`]+`')
        if (-not $hasCommandExample) {
            continue
        }

        if ($candidate -like "*.ai_shared/knowledge/test-commands.md" -or $candidate -eq ".ai_shared/knowledge/test-commands.md") {
            return $true
        }

        if ($content -match '(?im)\b(test|validation|verify|verification|check)\b') {
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
$testsPresent = (Test-Path -LiteralPath (Join-Path $repoRoot "tests")) -or (@(Get-ChildItem -LiteralPath $repoRoot -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "^(test|spec)" }).Count -gt 0)
$documentedValidationPresent = Test-DocumentedValidationPath @(".ai_shared/knowledge/test-commands.md", "README.md", "README.rst", "README.txt")
$docsPresent = (Test-Path -LiteralPath (Join-Path $repoRoot "docs")) -or (Test-Path -LiteralPath (Join-Path $repoRoot "examples"))
$gitignorePresent = Test-AnyPath @(".gitignore")

if (-not $readmePresent) {
    Add-Finding blocker "Missing README: explain the problem, local setup, and a first successful run."
} else {
    Add-Finding signal "README is present."
}

if ($testsPresent) {
    Add-Finding signal "Automated tests are present."
} elseif ($documentedValidationPresent) {
    Add-Finding signal "Documented validation commands are present."
} else {
    Add-Finding important "No obvious automated validation or test path found: add at least one automated smoke path or document the intended validation commands."
}

if ($docsPresent) {
    Add-Finding signal "Docs or examples folder is present."
} else {
    Add-Finding nice "No docs or examples folder found: consider adding docs/ or examples/ when setup or behavior needs more context."
}

if (-not $gitignorePresent) {
    Add-Finding important "Missing .gitignore: generated files, caches, and local data are easier to leak into the repo."
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

    Add-Finding blocker ("Tracked local or private artifacts: remove, anonymize, or move them out of git. Examples: " + ($examples -join ", ") + $suffix)
    if ($gitignorePresent) {
        Add-Finding important "Tracked local artifacts also suggest .gitignore should be expanded."
    }
}

$largeTrackedFiles = foreach ($relativePath in $trackedFiles) {
    $fullPath = Join-Path $repoRoot $relativePath
    if (-not (Test-Path -LiteralPath $fullPath)) {
        continue
    }

    try {
        $resolvedPath = (Resolve-Path -LiteralPath $fullPath).Path
        $item = [System.IO.FileInfo]::new($resolvedPath)
    } catch {
        continue
    }

    if ($item.Length -ge 5MB) {
        [PSCustomObject]@{
            Path = $relativePath
            SizeMb = [math]::Round($item.Length / 1MB, 2)
        }
    }
}

if (@($largeTrackedFiles).Count -gt 0) {
    $formatted = @($largeTrackedFiles | Select-Object -First 5 | ForEach-Object { "$($_.Path) ($($_.SizeMb) MB)" })
    Add-Finding important ("Large tracked files can make cloning and local iteration harder. Review: " + ($formatted -join ", "))
}

$pyprojectPath = Join-Path $repoRoot "pyproject.toml"
if (Test-Path -LiteralPath $pyprojectPath) {
    $pyproject = Get-Content -Raw -LiteralPath $pyprojectPath
    Add-Finding signal "pyproject.toml is present."
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

Write-Output "# Local Repo Audit"
Write-Output "Repo: $repoRoot"
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

Write-Section "Repo blockers" $repoBlockers
Write-Section "Important improvements" $important
Write-Section "Nice-to-have polish" $niceToHave
Write-Section "Signals already in place" $signals
