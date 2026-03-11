# Home Codex Agent System

## Purpose

Use the home-root Codex wrapper in `~/.codex` together with the shared context layer in `~/.ai_shared` for planning, inspection, implementation, review, verification, and summary.

## Shared Directories

- `~/.ai_shared/skills/` holds canonical shared skill definitions that generate the tool-specific wrappers.
- `~/.ai_shared/workflows/` holds reusable shared task processes.
- `~/.ai_shared/templates/` holds reusable shared response shapes.
- `~/.ai_shared/checklists/` holds reusable shared quality gates.
- `~/.ai_shared/knowledge/` holds durable shared notes such as `agent-stack.md`, `agent-authoring.md`, naming rules, and cross-repo guidance.
- `~/.ai_shared/examples/` holds reusable examples.
- `~/.ai_shared/tasks/` holds optional shared task artifacts.
- `~/.codex/skills/` holds actively discoverable Codex skills.
- `~/.codex/.agents-home/skills/` is a home library copy of the same shared Codex skills.

## Layering Rule

- Start with `lv0-instruction-core`.
- On the first repo request during a new calendar week, run `lv0-home-auditor` if `~/.ai_shared/knowledge/progress-tracker.md` does not already show a current-week home audit.
- Add `lv0-run-transparency` at the start of every run so the user sees the selected skills, the repo-local `.ai_shared/` context, the home-level `~/.ai_shared/` defaults, and why that stack fits the task.
- For any task that changes code, add `lv0-code-polisher`.
- Add any other needed `lv0` helper such as `lv0-home-auditor`, `lv0-repo-onboarding`, `lv0-skill-onboarding`, or `lv0-doc-writer`.
- Add the narrowest `lv1` task skill such as `lv1-feature-dev`, `lv1-defect-fix`, or `lv1-code-review`.
- Treat `.ai_shared` as the canonical shared-context layer.
- Treat `.codex` as Codex-specific wrapper/config space only.

Lookup order:

1. Repo-local Codex override in `.codex/` when the behavior is truly Codex-specific.
2. Repo-local shared context in `.ai_shared/`.
3. Home shared defaults in `~/.ai_shared/`.
4. Home Codex wrapper/config in `~/.codex/`.

## Available Skills

These are active home-level skills. Use them when the task matches, even if the user does not mention the skill name explicitly.

- `lv0-instruction-core`: shared routing skill that tells other skills which folders and layers to use
- `lv0-run-transparency`: explain the selected skill stack and shared context at the start of each run
- `lv0-home-auditor`: weekly home-folder auditor for local config alignment, wrapper sync, access checks, and cleanup candidates
- `lv0-repo-onboarding`: map an unfamiliar repository and build reusable context before deeper work
- `lv0-skill-onboarding`: guide creation and extension of shared lv0, lv1, and repo-specific lv2 skills
- `lv0-code-polisher`: improve code quality and maintainability without changing intended behavior
- `lv0-doc-writer`: write or refine technical documentation from verified repo facts
- `lv1-feature-dev`: implement scoped feature work and capture PRDs when requirements need to be recorded
- `lv1-defect-fix`: diagnose and fix bugs or regressions
- `lv1-code-review`: review diffs for correctness, regressions, and test gaps
- `lv1-github-repo-readiness`: audit or improve a repo for private or public GitHub use, publication prep, and contributor experience across repos

## Task Routing

### Feature work

1. Read `~/.codex/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.codex/skills/lv0-code-polisher/SKILL.md`.
3. Use `.ai_shared/workflows/workflow-feature.md` when the repo defines one; otherwise use `~/.ai_shared/workflows/workflow-feature.md`.
4. Read the relevant repo notes in `.ai_shared/knowledge/`, including `progress-tracker.md` and `future-plan.md`.
5. Use `.ai_shared/templates/plan-template.md` or `.ai_shared/templates/prd-template.md` when the repo defines them; otherwise use the shared versions in `~/.ai_shared/templates/`.
6. Validate against repo-local `.ai_shared/checklists/` first, then `~/.ai_shared/checklists/`.

### Defect fixing

1. Read `~/.codex/skills/lv0-instruction-core/SKILL.md`.
2. Read `~/.codex/skills/lv0-code-polisher/SKILL.md`.
3. Use `.ai_shared/workflows/workflow-defect.md` when the repo defines one; otherwise use `~/.ai_shared/workflows/workflow-defect.md`.
4. Read the relevant repo notes in `.ai_shared/knowledge/`, including `progress-tracker.md` and `future-plan.md`.
5. Use `.ai_shared/templates/defect-report-template.md` when the repo defines one; otherwise use `~/.ai_shared/templates/defect-report-template.md`.
6. Validate against repo-local `.ai_shared/checklists/` first, then `~/.ai_shared/checklists/`.

### Code review

1. Read `~/.codex/skills/lv0-instruction-core/SKILL.md`.
2. Use `.ai_shared/workflows/workflow-code-review.md` when the repo defines one; otherwise use `~/.ai_shared/workflows/workflow-code-review.md`.
3. Read the relevant repo notes in `.ai_shared/knowledge/`, including `progress-tracker.md` and `future-plan.md`.
4. Use `.ai_shared/templates/review-template.md` when the repo defines one; otherwise use `~/.ai_shared/templates/review-template.md`.
5. Present findings first, ordered by severity, with file references when possible.

### Repo onboarding

1. Read `~/.codex/skills/lv0-instruction-core/SKILL.md`.
2. Use `.ai_shared/workflows/workflow-onboarding.md` when the repo defines one; otherwise use `~/.ai_shared/workflows/workflow-onboarding.md`.
3. Read and update `.ai_shared/knowledge/repo-map.md`, `architecture.md`, `test-commands.md`, `progress-tracker.md`, and `future-plan.md` when useful.
4. Route into `~/.codex/skills/lv0-skill-onboarding/SKILL.md` when the repo itself is an agent or skill system.
5. Summarize the repo map, important commands, risky areas, and next files to inspect.

### Skill authoring

1. Read `~/.codex/skills/lv0-skill-onboarding/SKILL.md`.
2. Read `~/.ai_shared/knowledge/agent-authoring.md`, `agent-stack.md`, and `naming-conventions.md`.
3. Reuse an existing shared skill or agent as the closest template before creating a new one.

## Operating Rules

- Prefer the smallest safe change that satisfies the task.
- Inspect local context before deciding on an implementation.
- Before deeper work, tell the user which skills are in play, which repo-local `.ai_shared/` files and home-level `~/.ai_shared/` defaults were consulted, and why those sources fit the task.
- On the first repo request handled during a calendar week, check `~/.ai_shared/knowledge/progress-tracker.md`; if no current-week `lv0-home-auditor` entry exists there, run the weekly home-folder audit and log the result before deeper task work.
- Treat workflows, templates, checklists, and knowledge folders as agent-owned implementation detail; users should be able to request outcomes directly.
- Keep repo-specific context, templates, checklists, workflows, and continuity docs in the current repo's `.ai_shared/`.
- Keep canonical shared skill definitions in `.ai_shared/skills/` and sync the generated wrappers from there.
- Keep only reusable cross-repo assets in `~/.ai_shared/`.
- Keep tool-specific wrappers, configs, and native integrations in `.codex/` or `~/.codex/`.
- Keep `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md` updated for the current repo. Reserve `~/.ai_shared/knowledge/progress-tracker.md` and `~/.ai_shared/knowledge/future-plan.md` for global `lv0-home-auditor` continuity instead of repo continuity.
- Use the layered stack in `~/.ai_shared/knowledge/agent-stack.md` before adding new skills or templates.
- Call out validation clearly, including when it could not be run.
- Keep summaries concise and practical.

## Maintenance Notes

- When a shared Codex skill is updated, keep the active copy in `~/.codex/skills/` aligned with the library copy in `~/.codex/.agents-home/skills/`.
- Add durable shared guidance to `~/.ai_shared/knowledge/`.
- Add repo-specific facts to the current repo's `.ai_shared/knowledge/`.
- Bootstrap `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md` during repo onboarding if they do not exist yet.
