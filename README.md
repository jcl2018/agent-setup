# Home Agent Setup

This repository is the git-backed mirror of the home-level AI tool setup that lives under:

- `~/.codex`
- `~/.claude`
- `~/.github`

The goal is to keep reusable agent instructions, workflows, templates, checklists, and knowledge files in version control so the setup can move across machines and keep evolving over time.

## What This Repo Tracks

- root instruction files such as `.codex/AGENTS.md`, `.claude/CLAUDE.md`, and `.github/copilot-instructions.md`
- shared workflows, templates, checklists, and knowledge notes
- reusable Codex and Claude skills
- reusable Copilot custom agents and path-specific instructions
- helper scripts for syncing the managed files to and from your home folder

## What This Repo Does Not Track

- auth tokens, session history, caches, sqlite files, or generated runtime state
- machine-local sandbox folders
- secrets and environment files
- project-specific one-off home skills that are not part of the shared cross-tool system yet

## Layout

```text
.
|-- .codex/
|-- .claude/
|-- .github/
`-- scripts/
```

- `.codex/` mirrors the managed part of `~/.codex`
- `.claude/` is the starter mirror for `~/.claude`
- `.github/` holds Copilot repository-wide instructions, path-specific instructions, and custom agents
- `scripts/` contains safe sync helpers that copy only the managed files

## Layered Agent Model

The shared setup now uses a simple stack so you do not have to remember every folder first:

1. `lv0-instruction-core` is the shared base layer. It routes work to the right workflow, knowledge note, template, and checklist.
2. `lv0` onboarding and specialist skills handle reusable foundation work:
   - `lv0-repo-onboarding` for mapping an unfamiliar repository and finding the right notes, workflows, and risky areas
   - `lv0-skill-onboarding` for creating or extending shared skills and agents
   - `lv0-code-polisher` for code quality, cleanup, and maintainability work
   - `lv0-doc-writer` for technical docs, READMEs, runbooks, and architecture notes
3. `lv1` task wrappers such as `lv1-feature-dev`, `lv1-defect-fix`, and `lv1-code-review` sit on top of that base.

When you add a repo-specific agent later, keep it thin and compose it from the shared layers instead of duplicating the general instructions again.

Step-by-step authoring guides live in:
- `.codex/knowledge/agent-authoring.md`
- `.claude/knowledge/agent-authoring.md`
- `.github/knowledge/agent-authoring.md`

## How To Ask

Ask for the outcome you want, not the internal folders to edit.

- Example outcome requests: "onboard this repo", "create a new lv0 skill for release notes", "fix this bug", "review this diff", or "add this feature and update docs".
- The agent should decide when to read or update workflows, knowledge notes, templates, checklists, and layered skills.
- Those folders are meant to be implementation detail for the agent system, not something you need to manage by hand during normal use.

## Onboarding Process

Use these two onboarding flows so creating or extending agents stops being a folder-memory problem:

### Repo Onboarding

Use `lv0-repo-onboarding` when you are new to a repository or returning after a while.

1. Start from `lv0-instruction-core`.
2. Run `lv0-repo-onboarding` to map the repo, identify key files and commands, and refresh shared notes.
3. If the repository is itself an agent or skill system, continue into `lv0-skill-onboarding`.

### Skill Onboarding

Use `lv0-skill-onboarding` when you want to create, rename, extend, or standardize a shared skill or agent.

1. Read the shared authoring notes in `.codex/knowledge/agent-authoring.md`, `agent-stack.md`, and `naming-conventions.md`.
2. Decide the layer:
   - `lv0` for reusable cross-cutting helpers such as onboarding, docs, testing, or code quality
   - `lv1` for reusable task wrappers such as feature work, defect fixing, or review
   - `lv2` for thin repo-specific wrappers built on top of the shared stack
3. Reuse the nearest existing skill or agent as the template before creating new files.
4. When the capability is shared, update Codex, Claude, and Copilot together, and mirror Codex skill changes into `.codex/.agents-home/skills/`.
5. Validate with `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -WhatIf`.

Common path for changing this repo itself:
- `lv0-instruction-core` -> `lv0-repo-onboarding` -> `lv0-skill-onboarding`

## Sync Commands

Preview a push from the repo into your home folder:

```powershell
pwsh ./scripts/sync-to-home.ps1 -WhatIf
```

Push all managed files into your home folder:

```powershell
pwsh ./scripts/sync-to-home.ps1
```

Pull managed files back from your home folder into the repo:

```powershell
pwsh ./scripts/sync-from-home.ps1
```

Sync only one tool:

```powershell
pwsh ./scripts/sync-to-home.ps1 -Tool codex
pwsh ./scripts/sync-from-home.ps1 -Tool claude
pwsh ./scripts/sync-to-home.ps1 -Tool copilot
```

## Git Setup

The repository is initialized locally on `main`. After you create a remote, add it with:

```powershell
git remote add origin <your-repo-url>
git add .
git commit -m "Initial home agent mirror"
git push -u origin main
```

## Notes

- Copilot path-specific instructions live in `.github/instructions/*.instructions.md`.
- Copilot task-specific behavior lives in `.github/agents/*.agent.md`.
- The sync scripts are intentionally non-destructive: they copy managed files, but they do not delete extra local runtime data in your home folder.
