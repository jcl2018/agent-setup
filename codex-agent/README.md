# Codex Agent Workspace

This `codex-agent/` folder is the git-backed mirror of a shared Codex-focused AI setup built around one canonical shared layer and one managed tool wrapper:

- `~/.ai_shared`
- `~/.codex`

The parent repo root is now a multi-tool container. Keep Codex-specific managed content in this folder, and add future tool workspaces as sibling folders beside `codex-agent/`.

The goal is to keep reusable shared context in version control once, while still preserving native wrapper files for Codex.

## What This Workspace Tracks

- the shared cross-tool layer in `.ai_shared/`
- the canonical shared skill definitions in `.ai_shared/skills/`
- root instruction files such as `.codex/AGENTS.md`
- reusable Codex skills
- helper scripts for syncing the managed files to and from your home folder

## What This Workspace Does Not Track

- auth tokens, session history, caches, sqlite files, or generated runtime state
- machine-local sandbox folders
- secrets and environment files
- repo-local continuity files that belong in some other repository's own `.ai_shared/knowledge/`

## Layout

```text
.
|-- .ai_shared/
|-- .codex/
`-- scripts/
```

- `.ai_shared/` is the canonical shared layer for workflows, templates, checklists, knowledge, examples, and optional shared tasks.
- `.ai_shared/skills/` holds the canonical shared skill definitions that feed the generated Codex wrappers.
- `.codex/` holds Codex-native wrappers and config.
- `scripts/` contains sync helpers that copy only the managed files.

At the container root, this workspace now sits at `codex-agent/`.

## Home Vs Repo-Local

- Home `~/.ai_shared/` is for reusable cross-repo shared defaults.
- Home `~/.ai_shared/skills/` is for canonical shared skill definitions that should stay aligned with the generated tool wrappers.
- Repo-local `.ai_shared/` is the canonical shared context for that repository across all tools.
- `progress-tracker.md` and `future-plan.md` are always repo-local continuity docs under `.ai_shared/knowledge/`.
- Repo-specific templates, checklists, workflows, knowledge notes, and other shared context should live in that repo's `.ai_shared/`.
- Tool folders inside a repo such as `.codex/` should stay thin and only hold tool-specific wrappers, configs, or native integrations.
- The sync scripts intentionally skip `progress-tracker.md` and `future-plan.md` when copying `.ai_shared/knowledge/` into the live home folder so stale home-level continuity files do not come back.

## Lookup Order

When a tool needs context, use this order:

1. Repo-local tool override such as `.codex/` when the behavior is truly tool-specific.
2. Repo-local `.ai_shared/`.
3. Home `~/.ai_shared/`.
4. Home tool wrapper such as `~/.codex/`.

## Layered Agent Model

The shared setup uses a simple stack so you do not have to remember every folder by hand:

1. `lv0-instruction-core` is the shared routing layer.
2. `lv0-home-auditor` is the weekly home-folder alignment helper that should run on the first repo request of a new calendar week when no audit is logged yet.
3. Other `lv0` onboarding and specialist helpers handle reusable foundation work.
4. `lv1` task wrappers such as `lv1-feature-dev`, `lv1-defect-fix`, and `lv1-code-review` sit on top.
5. Repo-specific `lv2` wrappers stay thin and compose the shared layers when a repo needs extra tool-native behavior.

Shared authoring guidance lives in `.ai_shared/knowledge/agent-authoring.md`, `.ai_shared/knowledge/agent-stack.md`, and `.ai_shared/knowledge/naming-conventions.md`.

## How To Ask

Ask for the outcome you want, not the internal folders to edit.

- Example outcome requests: "onboard this repo", "create a new lv0 skill for release notes", "fix this bug", "review this diff", or "add this feature and update docs".
- Example outcome requests also include "audit the home setup" or "check whether the local agent folders are aligned".
- The agent should decide when to read or update workflows, knowledge notes, templates, checklists, wrappers, and layered skills.
- The agent should keep the current repo's `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md` current as work happens.

## Onboarding Process

### Repo Onboarding

Use `lv0-repo-onboarding` when you are new to a repository or returning after a while.

1. Start from `lv0-instruction-core`.
2. Run `lv0-repo-onboarding` to map the repo, identify key files and commands, and refresh `.ai_shared/knowledge/`.
3. If the repository is itself an agent or skill system, continue into `lv0-skill-onboarding`.

### Weekly Home Audit

Use `lv0-home-auditor` on the first request handled in a repo during a new calendar week when that repo's `.ai_shared/knowledge/progress-tracker.md` does not already show a current-week audit.

1. Start from `lv0-instruction-core`.
2. Run `lv0-home-auditor` to verify shared-folder placement, wrapper sync, shared-path access, and cleanup candidates.
3. Update the repo continuity docs with the audit result before continuing into the deeper task.

### Skill Onboarding

Use `lv0-skill-onboarding` when you want to create, rename, extend, or standardize a shared skill or agent.

1. Read the shared authoring notes in `.ai_shared/knowledge/agent-authoring.md`, `agent-stack.md`, and `naming-conventions.md`.
2. Decide the layer:
   - `lv0` for reusable cross-cutting helpers such as onboarding, docs, testing, or code quality
   - `lv1` for reusable task wrappers such as feature work, defect fixing, or review
   - `lv2` for thin repo-specific wrappers built on top of the shared stack
3. Reuse the nearest existing skill or agent as the template before creating new files.
4. When the capability is shared, update the Codex wrappers and mirror Codex skill changes into `.codex/.agents-home/skills/`.
5. Validate with `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -WhatIf`.

## Sync Commands

Preview a push from the repo into your home folder:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -WhatIf
```

Push all managed files into your home folder:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1
```

Pull managed files back from your home folder into the repo:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\sync-from-home.ps1
```

Sync only one tool wrapper and the shared layer it depends on:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -Tool codex
powershell -ExecutionPolicy Bypass -File .\scripts\sync-from-home.ps1 -Tool codex
```

## Notes

- Important rule: this repo is Codex-only. Do not add or regenerate managed `.claude/` wrapper content here.
- This repo no longer manages the old `.github` wrapper set; the active managed tool surface is Codex.
- The sync scripts are intentionally non-destructive: they copy managed files, but they do not delete extra local runtime data in your home folder.
