# Home-Root Agent Configuration Spec

## Goal

Keep one canonical shared context layer plus three fully usable tool wrappers:

- `~/.ai_shared`
- `~/.codex`
- `~/.claude`
- `~/.github`

Each tool should remain usable on its own, but shared context should only be maintained once.

## Design Principles

1. One shared context layer
   - Put reusable workflows, templates, checklists, knowledge, examples, and optional shared tasks in `.ai_shared`.

2. Thin tool wrappers
   - Keep `.codex`, `.claude`, and `.github` focused on tool-native wrappers, configs, skills, agents, and auto-attached instructions.

3. Repo-local before home
   - Use each repo's local `.ai_shared/` for repo-specific shared context.
   - Use `~/.ai_shared/` only for cross-repo defaults.

4. Continuity is repo-local
   - Keep `progress-tracker.md` and `future-plan.md` only in each repo's `.ai_shared/knowledge/`.

5. Same logic, different wrappers
   - The shared layer should stay aligned across tools.
   - Each tool should express wrapper behavior in its own native format.

## Preferred Structure

### Home

```text
~
|-- .ai_shared/
|   |-- skills/
|   |-- workflows/
|   |-- templates/
|   |-- checklists/
|   |-- knowledge/
|   |-- examples/
|   `-- tasks/
|-- .codex/
|   |-- AGENTS.md
|   |-- config.toml
|   |-- skills/
|   `-- .agents-home/
|-- .claude/
|   |-- CLAUDE.md
|   |-- settings.json
|   `-- skills/
`-- .github/
    |-- copilot-instructions.md
    |-- agents/
    `-- instructions/
```

### Repo

```text
<repo>/
|-- .ai_shared/
|   |-- skills/
|   |-- workflows/
|   |-- templates/
|   |-- checklists/
|   `-- knowledge/
|       |-- progress-tracker.md
|       |-- future-plan.md
|       |-- repo-map.md
|       |-- architecture.md
|       `-- test-commands.md
|-- .codex/
|   |-- AGENTS.md
|   `-- optional Codex-only overrides
|-- .claude/
|   |-- CLAUDE.md
|   `-- optional Claude-only overrides
`-- .github/
    |-- copilot-instructions.md
    |-- agents/
    `-- optional Copilot-only overrides
```

## Lookup Order

When any tool needs instructions or context, resolve in this order:

1. Repo-local tool override such as `.codex/`, `.claude/`, or `.github/` when the behavior is truly tool-specific.
2. Repo-local `.ai_shared/`.
3. Home `~/.ai_shared/`.
4. Home tool wrapper such as `~/.codex/`, `~/.claude/`, or `~/.github/`.

## What Belongs Where

### `.ai_shared`

Use for:

- canonical shared skill definitions
- shared workflows
- shared templates
- shared checklists
- shared knowledge notes
- examples
- repo continuity docs
- repo-specific shared overrides

Do not use for:

- tool-native config files
- Codex/Claude skills or Copilot agents
- Copilot auto-attached instruction wrappers
- secrets, caches, or runtime state

### `.codex`

Use for:

- `AGENTS.md`
- `config.toml`
- Codex skills
- Codex-only wrapper behavior

### `.claude`

Use for:

- `CLAUDE.md`
- `settings.json`
- Claude skills
- Claude-only wrapper behavior

### `.github`

Use for:

- `copilot-instructions.md`
- custom agents
- path-specific instruction files
- Copilot-only wrapper behavior

## Shared Workflow Set

Maintain these shared workflows in `.ai_shared/workflows/`:

1. `workflow-home-audit.md`
2. `workflow-feature.md`
3. `workflow-defect.md`
4. `workflow-code-review.md`
5. `workflow-onboarding.md`

## Shared Template Set

Maintain these shared templates in `.ai_shared/templates/`:

- `plan-template.md`
- `prd-template.md`
- `defect-report-template.md`
- `review-template.md`

## Shared Checklist Set

Maintain these shared checklists in `.ai_shared/checklists/`:

- `home-audit-checklist.md`
- `post-edit-checklist.md`
- `bugfix-verification.md`
- `feature-validation.md`

## Shared Knowledge Set

Maintain these shared knowledge notes in `.ai_shared/knowledge/`:

- `agent-stack.md`
- `agent-authoring.md`
- `naming-conventions.md`
- `architecture.md`
- `repo-map.md`
- `test-commands.md`

Repo-local `.ai_shared/knowledge/` should additionally own:

- `progress-tracker.md`
- `future-plan.md`

## Layered Model

Use the same logical layers across tools:

- `lv0-instruction-core`
- `lv0-home-auditor`
- `lv0` onboarding and specialist helpers
- `lv1` task wrappers
- optional thin repo-specific `lv2` wrappers

## Setup Priority

1. Create `.ai_shared/`.
2. Create the thin tool wrappers under `.codex`, `.claude`, and `.github`.
3. Add shared workflows, templates, checklists, and knowledge to `.ai_shared/`.
4. Add skills and agents to the tool wrappers.
5. Keep repo-local continuity files in each repo's `.ai_shared/knowledge/`.

## Sync Rules

- Sync `.ai_shared/` between the repo mirror and `~/.ai_shared/`.
- Sync tool wrappers between the repo mirror and their home locations.
- Exclude `progress-tracker.md` and `future-plan.md` when syncing `.ai_shared/knowledge/` into `~/.ai_shared/`.
- Do not delete unmanaged runtime files from the home folders.
