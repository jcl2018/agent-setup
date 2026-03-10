[CmdletBinding(SupportsShouldProcess)]
param(
    [string[]]$Name = @("all"),
    [string]$RepoRoot
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
    $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

$sharedSkillsRoot = Join-Path $RepoRoot ".ai_shared\skills"
$catalogPath = Join-Path $sharedSkillsRoot "catalog.json"

if (-not (Test-Path -LiteralPath $catalogPath)) {
    throw "Missing catalog: $catalogPath"
}

$catalog = (Get-Content -Raw -LiteralPath $catalogPath | ConvertFrom-Json).skills

function Resolve-RequestedNames {
    param(
        [object[]]$CatalogItems,
        [string[]]$Requested
    )

    $normalizedRequested = New-Object System.Collections.Generic.List[string]
    foreach ($entry in $Requested) {
        if ([string]::IsNullOrWhiteSpace($entry)) {
            continue
        }

        foreach ($candidate in ($entry -split ",")) {
            $trimmed = $candidate.Trim()
            if ([string]::IsNullOrWhiteSpace($trimmed)) {
                continue
            }

            if (-not $normalizedRequested.Contains($trimmed)) {
                $normalizedRequested.Add($trimmed)
            }
        }
    }

    if ($normalizedRequested.Count -eq 0 -or $normalizedRequested -contains "all") {
        return @($CatalogItems)
    }

    $catalogByName = @{}
    foreach ($item in $CatalogItems) {
        $catalogByName[$item.name] = $item
    }

    $resolved = New-Object System.Collections.Generic.List[object]
    foreach ($entry in $normalizedRequested) {
        if (-not $catalogByName.ContainsKey($entry)) {
            throw "Unknown shared skill '$entry'."
        }
        $resolved.Add($catalogByName[$entry])
    }

    return @($resolved.ToArray())
}

function Ensure-Directory {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        if ($PSCmdlet.ShouldProcess($Path, "Create directory")) {
            New-Item -ItemType Directory -Path $Path -Force | Out-Null
        }
    }
}

function Reset-Directory {
    param([string]$Path)

    if (Test-Path -LiteralPath $Path) {
        if ($PSCmdlet.ShouldProcess($Path, "Remove directory")) {
            Remove-Item -LiteralPath $Path -Recurse -Force
        }
    }

    Ensure-Directory -Path $Path
}

function Write-Utf8File {
    param(
        [string]$Path,
        [string]$Content
    )

    $parent = Split-Path -Parent $Path
    Ensure-Directory -Path $parent

    if ($PSCmdlet.ShouldProcess($Path, "Write file")) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($Path, $Content, $utf8NoBom)
    }
}

function Escape-YamlValue {
    param([string]$Value)

    return ($Value -replace '\\', '\\' -replace '"', '\"')
}

function Render-Template {
    param(
        [string]$Template,
        [hashtable]$Context
    )

    $rendered = $Template
    foreach ($key in $Context.Keys) {
        $rendered = $rendered.Replace("{{${key}}}", [string]$Context[$key])
    }

    return $rendered.Trim() + "`n"
}

function Build-MarkdownWrapper {
    param(
        [object]$Skill,
        [string]$RenderedBody,
        [string]$FrontmatterName,
        [string]$SourceRelativePath
    )

    @(
        "---"
        "name: $FrontmatterName"
        "description: $($Skill.description)"
        "---"
        "<!-- Generated from $SourceRelativePath. Edit the shared source and run scripts/sync-shared-skills.ps1. -->"
        ""
        $RenderedBody.TrimEnd()
        ""
    ) -join "`n"
}

function Copy-SharedAssets {
    param(
        [string]$SourceSkillRoot,
        [string]$TargetSkillRoot
    )

    $assetDirs = Get-ChildItem -LiteralPath $SourceSkillRoot -Directory
    foreach ($assetDir in $assetDirs) {
        $targetDir = Join-Path $TargetSkillRoot $assetDir.Name
        Ensure-Directory -Path $TargetSkillRoot
        if ($PSCmdlet.ShouldProcess($targetDir, "Copy asset directory '$($assetDir.Name)'")) {
            Copy-Item -LiteralPath $assetDir.FullName -Destination $TargetSkillRoot -Recurse -Force
        }
    }
}

function Copy-CodexMirror {
    param(
        [string]$SourceSkillRoot,
        [string]$MirrorSkillRoot
    )

    if (Test-Path -LiteralPath $MirrorSkillRoot) {
        if ($PSCmdlet.ShouldProcess($MirrorSkillRoot, "Remove mirror directory")) {
            Remove-Item -LiteralPath $MirrorSkillRoot -Recurse -Force
        }
    }

    $mirrorParent = Split-Path -Parent $MirrorSkillRoot
    Ensure-Directory -Path $mirrorParent
    if ($PSCmdlet.ShouldProcess($MirrorSkillRoot, "Copy Codex mirror skill")) {
        Copy-Item -LiteralPath $SourceSkillRoot -Destination $mirrorParent -Recurse -Force
    }
}

$toolContexts = @{
    codex = @{
        ToolName           = "Codex"
        WrapperNoun        = "skill"
        ToolHomeComponents = "skills"
        HomeToolDir        = "~/.codex/"
        RepoToolDir        = ".codex/"
        EntryRef           = "~/.codex/skills/lv0-instruction-core/SKILL.md"
        SkillOnboardingRef = "~/.codex/skills/lv0-skill-onboarding/SKILL.md"
        DocWriterRef       = "~/.codex/skills/lv0-doc-writer/SKILL.md"
    }
    claude = @{
        ToolName           = "Claude"
        WrapperNoun        = "skill"
        ToolHomeComponents = "skills"
        HomeToolDir        = "~/.claude/"
        RepoToolDir        = ".claude/"
        EntryRef           = "~/.claude/skills/lv0-instruction-core/SKILL.md"
        SkillOnboardingRef = "~/.claude/skills/lv0-skill-onboarding/SKILL.md"
        DocWriterRef       = "~/.claude/skills/lv0-doc-writer/SKILL.md"
    }
}

$selectedSkills = Resolve-RequestedNames -CatalogItems $catalog -Requested $Name

foreach ($skill in $selectedSkills) {
    $sourceSkillRoot = Join-Path $sharedSkillsRoot $skill.name
    $sharedBodyPath = Join-Path $sourceSkillRoot "shared.md"

    if (-not (Test-Path -LiteralPath $sharedBodyPath)) {
        throw "Missing shared skill body: $sharedBodyPath"
    }

    $sharedTemplate = Get-Content -Raw -LiteralPath $sharedBodyPath
    $sourceRelativePath = ".ai_shared/skills/$($skill.name)/shared.md"

    foreach ($toolKey in $toolContexts.Keys) {
        $context = @{
            DISPLAY_NAME         = [string]$skill.displayName
            TOOL_NAME            = [string]$toolContexts[$toolKey].ToolName
            WRAPPER_NOUN         = [string]$toolContexts[$toolKey].WrapperNoun
            TOOL_HOME_COMPONENTS = [string]$toolContexts[$toolKey].ToolHomeComponents
            HOME_TOOL_DIR        = [string]$toolContexts[$toolKey].HomeToolDir
            REPO_TOOL_DIR        = [string]$toolContexts[$toolKey].RepoToolDir
            ENTRY_REF            = [string]$toolContexts[$toolKey].EntryRef
            SKILL_ONBOARDING_REF = [string]$toolContexts[$toolKey].SkillOnboardingRef
            DOC_WRITER_REF       = [string]$toolContexts[$toolKey].DocWriterRef
        }

        $renderedBody = Render-Template -Template $sharedTemplate -Context $context

        switch ($toolKey) {
            "codex" {
                $targetSkillRoot = Join-Path $RepoRoot ".codex\skills\$($skill.name)"
                Reset-Directory -Path $targetSkillRoot
                Copy-SharedAssets -SourceSkillRoot $sourceSkillRoot -TargetSkillRoot $targetSkillRoot

                $skillMarkdownPath = Join-Path $targetSkillRoot "SKILL.md"
                $skillMarkdown = Build-MarkdownWrapper -Skill $skill -RenderedBody $renderedBody -FrontmatterName $skill.name -SourceRelativePath $sourceRelativePath
                Write-Utf8File -Path $skillMarkdownPath -Content $skillMarkdown

                $agentsRoot = Join-Path $targetSkillRoot "agents"
                Ensure-Directory -Path $agentsRoot
                $openAiYamlPath = Join-Path $agentsRoot "openai.yaml"
                $openAiYaml = @(
                    "interface:"
                    "  display_name: `"$([string](Escape-YamlValue $skill.displayName))`""
                    "  short_description: `"$([string](Escape-YamlValue $skill.codexShortDescription))`""
                    "  default_prompt: `"$([string](Escape-YamlValue $skill.codexDefaultPrompt))`""
                    ""
                    "policy:"
                    "  allow_implicit_invocation: true"
                    ""
                ) -join "`n"
                Write-Utf8File -Path $openAiYamlPath -Content $openAiYaml

                $mirrorSkillRoot = Join-Path $RepoRoot ".codex\.agents-home\skills\$($skill.name)"
                Copy-CodexMirror -SourceSkillRoot $targetSkillRoot -MirrorSkillRoot $mirrorSkillRoot
            }
            "claude" {
                $targetSkillRoot = Join-Path $RepoRoot ".claude\skills\$($skill.name)"
                Reset-Directory -Path $targetSkillRoot
                Copy-SharedAssets -SourceSkillRoot $sourceSkillRoot -TargetSkillRoot $targetSkillRoot

                $skillMarkdownPath = Join-Path $targetSkillRoot "SKILL.md"
                $skillMarkdown = Build-MarkdownWrapper -Skill $skill -RenderedBody $renderedBody -FrontmatterName $skill.name -SourceRelativePath $sourceRelativePath
                Write-Utf8File -Path $skillMarkdownPath -Content $skillMarkdown
            }
        }
    }
}
