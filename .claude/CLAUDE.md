# Home Claude Agent System

## Purpose

Use the shared home-root Claude system in `~/.claude` as a self-sufficient setup for planning, inspection, implementation, review, verification, and summary.

## Shared Directories

- `~/.claude/workflows/` holds the task process to follow.
- `~/.claude/templates/` holds reusable response shapes.
- `~/.claude/checklists/` holds lightweight quality gates.
- `~/.claude/knowledge/` holds durable notes such as architecture, repo maps, and test commands.
- `~/.claude/skills/` holds actively discoverable Claude skills.

## Available Skills

These are active home-level skills. Use them when the task matches, even if the user does not mention the skill name explicitly.

- `lv0-instruction-core`: shared routing skill that tells other skills which folders and layers to use
- `lv0-repo-onboarding`: map an unfamiliar repository and build reusable context before deeper work
- `lv0-skill-onboarding`: guide creation and extension of shared lv0, lv1, and repo-specific lv2 skills
- `lv0-code-polisher`: improve code quality and maintainability without changing intended behavior
- `lv0-doc-writer`: write or refine technical documentation from verified repo facts
- `lv1-feature-dev`: implement scoped feature work
- `lv1-defect-fix`: diagnose and fix bugs or regressions
- `lv1-code-review`: review diffs for correctness, regressions, and test gaps
If the user seems unsure what to ask for, briefly surface the most relevant skill name and what it is for.

## Layering Rule

- Start with `lv0-instruction-core`.
- Add any needed `lv0` helper such as `lv0-repo-onboarding`, `lv0-skill-onboarding`, `lv0-code-polisher`, or `lv0-doc-writer`.
- Add the narrowest `lv1` task skill such as `lv1-feature-dev`, `lv1-defect-fix`, or `lv1-code-review`.
- Keep repo-specific skills thin and place durable repo facts in `~/.claude/knowledge/` instead of duplicating shared instructions.

## Task Routing

### Feature work

1. Read `~/.claude/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.claude/workflows/workflow-feature.md`.
3. Read the relevant notes in `~/.claude/knowledge/`.
4. Use `~/.claude/templates/plan-template.md` when the task is large enough to benefit from a short plan.
5. Validate against `~/.claude/checklists/feature-validation.md` and `~/.claude/checklists/post-edit-checklist.md`.

### Defect fixing

1. Read `~/.claude/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.claude/workflows/workflow-defect.md`.
3. Read the relevant notes in `~/.claude/knowledge/`.
4. Use `~/.claude/templates/defect-report-template.md` when a written diagnosis is useful.
5. Validate against `~/.claude/checklists/bugfix-verification.md` and `~/.claude/checklists/post-edit-checklist.md`.

### Code review

1. Read `~/.claude/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.claude/workflows/workflow-code-review.md`.
3. Read the relevant notes in `~/.claude/knowledge/`.
4. Use `~/.claude/templates/review-template.md` when a structured review write-up helps.
5. Present findings first, ordered by severity, with file references when possible.

### Repo onboarding

1. Read `~/.claude/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.claude/workflows/workflow-onboarding.md`.
3. Read and update `~/.claude/knowledge/repo-map.md`, `architecture.md`, `test-commands.md`, `agent-stack.md`, and `agent-authoring.md` when useful.
4. Route into `~/.claude/skills/lv0-skill-onboarding/SKILL.md` when the repo itself is an agent or skill system.
5. Summarize the repo map, important commands, risky areas, and next files to inspect.

### Skill authoring

1. Read `~/.claude/skills/lv0-skill-onboarding/SKILL.md`.
2. Read `~/.claude/knowledge/agent-authoring.md`, `agent-stack.md`, and `naming-conventions.md`.
3. Reuse an existing shared skill or agent as the closest template before creating a new one.

## Operating Rules

- Prefer the smallest safe change that satisfies the task.
- Inspect local context before deciding on an implementation.
- Treat workflows, templates, checklists, and knowledge folders as agent-owned implementation detail; users should be able to request outcomes directly.
- Reuse the shared workflows, templates, checklists, and knowledge files instead of inventing a new process each time.
- Use the layered stack in `~/.claude/knowledge/agent-stack.md` before adding new skills or templates.
- Call out validation clearly, including when it could not be run.
- Keep summaries concise and practical.

## Maintenance Notes

- Keep shared workflow, checklist, template, and skill names aligned with the Codex and Copilot mirrors unless the tool requires a different wrapper.
- Add durable repo facts to `~/.claude/knowledge/` when they will help future sessions.
