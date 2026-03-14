# Codex Workspace Configuration Spec

## Goal

Keep one canonical shared context layer plus one fully usable Codex wrapper inside a dedicated `codex-agent/` workspace folder:

- `~/.ai_shared`
- `~/.codex`

Shared context should only be maintained once.

## Design Principles

1. One shared context layer
   - Put reusable workflows, templates, checklists, knowledge, examples, and optional shared tasks in `.ai_shared`.

2. Thin tool wrappers
   - Keep `.codex` focused on tool-native wrappers, configs, and skills.

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
```

### Repo Container

```text
<repo>/
|-- codex-agent/
|   |-- .ai_shared/
|   |   |-- skills/
|   |   |-- workflows/
|   |   |-- templates/
|   |   |-- checklists/
|   |   `-- knowledge/
|   |       |-- progress-tracker.md
|   |       |-- future-plan.md
|   |       |-- repo-map.md
|   |       |-- architecture.md
|   |       `-- test-commands.md
|   |-- .codex/
|   |   |-- AGENTS.md
|   |   `-- optional Codex-only overrides
|   `-- scripts/
`-- <future-tool-agent>/
```

## Lookup Order

When any tool needs instructions or context, resolve in this order:

1. Repo-local tool override such as `.codex/` when the behavior is truly tool-specific.
2. Repo-local `.ai_shared/`.
3. Home `~/.ai_shared/`.
4. Home tool wrapper such as `~/.codex/`.

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
- Codex skills
- secrets, caches, or runtime state

### `.codex`

Use for:

- `AGENTS.md`
- `config.toml`
- Codex skills
- Codex-only wrapper behavior

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
2. Create the thin Codex wrapper under `.codex`.
3. Add shared workflows, templates, checklists, and knowledge to `.ai_shared/`.
4. Add skills to the tool wrappers.
5. Keep repo-local continuity files in each repo's `.ai_shared/knowledge/`.

## Sync Rules

- Sync `.ai_shared/` between the repo mirror and `~/.ai_shared/`.
- Sync the Codex wrapper between the repo mirror and its home location.
- Exclude `progress-tracker.md` and `future-plan.md` when syncing `.ai_shared/knowledge/` into `~/.ai_shared/`.
- Do not delete unmanaged runtime files from the home folders.
