# Home Copilot Agent System

## Purpose

Use the shared home-root Copilot system in `~/.github` as a self-sufficient setup for planning, inspection, implementation, review, verification, and summary.

## Shared Directories

- `~/.github/workflows/` holds reusable shared task processes. Repo-specific workflow overrides belong in the current repo's `.github/workflows/`.
- `~/.github/templates/` holds reusable shared response shapes. Repo-specific templates belong in the current repo's `.github/templates/`.
- `~/.github/checklists/` holds reusable shared quality gates. Repo-specific checklists belong in the current repo's `.github/checklists/`.
- `~/.github/knowledge/` holds shared cross-repo notes such as `agent-stack.md`, `agent-authoring.md`, and naming rules. Repo-specific knowledge belongs in the current repo's `.github/knowledge/`.
- `~/.github/agents/` holds actively discoverable Copilot custom agents.
- `~/.github/instructions/` holds path-specific instruction files that should attach automatically to matching files.

## Available Agents

These are the active home-level agents. Use them when the task matches, even if the user does not mention the agent name explicitly.

- `lv0-instruction-core`: shared routing agent that tells other agents which folders and layers to use
- `lv0-repo-onboarding`: map an unfamiliar repository and build reusable context before deeper work
- `lv0-skill-onboarding`: guide creation and extension of shared lv0, lv1, and repo-specific lv2 skills and agents
- `lv0-code-polisher`: improve code quality and maintainability without changing intended behavior
- `lv0-doc-writer`: write or refine technical documentation from verified repo facts
- `lv1-feature-dev`: implement scoped feature work and capture PRDs when requirements need to be recorded
- `lv1-defect-fix`: diagnose and fix bugs or regressions
- `lv1-code-review`: review diffs for correctness, regressions, and test gaps
- `lv1-github-repo-readiness`: audit or improve a repo for private or public GitHub use, publication prep, and contributor experience across repos
If the user seems unsure what to ask for, briefly surface the most relevant agent name and what it is for.

## Layering Rule

- Start with `lv0-instruction-core`.
- Add any needed `lv0` helper such as `lv0-repo-onboarding`, `lv0-skill-onboarding`, `lv0-code-polisher`, or `lv0-doc-writer`.
- Add the narrowest `lv1` task agent such as `lv1-feature-dev`, `lv1-defect-fix`, or `lv1-code-review`.
- Keep repo-specific agents thin and place durable repo facts in the current repo's `.github/knowledge/` instead of the home folder or duplicated shared instructions.

## Task Routing

### Feature work

1. Read `~/.github/agents/lv0-instruction-core.agent.md`.
2. Read `~/.github/workflows/workflow-feature.md`.
3. Read the relevant repo notes in `.github/knowledge/`, including `progress-tracker.md` and `future-plan.md`. Use `~/.github/knowledge/` only for shared cross-repo guidance when helpful.
4. Use `.github/templates/plan-template.md` when the repo defines one and the task is large enough to benefit from a short plan; otherwise use `~/.github/templates/plan-template.md`. Use the repo's existing PRD template when one exists; otherwise use `~/.github/templates/prd-template.md` when requirements, APIs, use cases, or acceptance criteria should be captured during the task.
5. Validate against `.github/checklists/feature-validation.md` and `.github/checklists/post-edit-checklist.md` when the repo defines them; otherwise use `~/.github/checklists/feature-validation.md` and `~/.github/checklists/post-edit-checklist.md`.

### Defect fixing

1. Read `~/.github/agents/lv0-instruction-core.agent.md`.
2. Read `~/.github/workflows/workflow-defect.md`.
3. Read the relevant repo notes in `.github/knowledge/`, including `progress-tracker.md` and `future-plan.md`. Use `~/.github/knowledge/` only for shared cross-repo guidance when helpful.
4. Use `.github/templates/defect-report-template.md` when the repo defines one and a written diagnosis is useful; otherwise use `~/.github/templates/defect-report-template.md`.
5. Validate against `.github/checklists/bugfix-verification.md` and `.github/checklists/post-edit-checklist.md` when the repo defines them; otherwise use `~/.github/checklists/bugfix-verification.md` and `~/.github/checklists/post-edit-checklist.md`.

### Code review

1. Read `~/.github/agents/lv0-instruction-core.agent.md`.
2. Read `~/.github/workflows/workflow-code-review.md`.
3. Read the relevant repo notes in `.github/knowledge/`, including `progress-tracker.md` and `future-plan.md`. Use `~/.github/knowledge/` only for shared cross-repo guidance when helpful.
4. Use `.github/templates/review-template.md` when the repo defines one and a structured review write-up helps; otherwise use `~/.github/templates/review-template.md`.
5. Present findings first, ordered by severity, with file references when possible.

### Repo onboarding

1. Read `~/.github/agents/lv0-instruction-core.agent.md`.
2. Read `~/.github/workflows/workflow-onboarding.md`.
3. Read shared authoring notes in `~/.github/knowledge/` when needed, then read and update the repo-local `.github/knowledge/repo-map.md`, `architecture.md`, `test-commands.md`, `progress-tracker.md`, and `future-plan.md`.
4. Route into `~/.github/agents/lv0-skill-onboarding.agent.md` when the repo itself is an agent or skill system.
5. Summarize the repo map, important commands, risky areas, and next files to inspect.

### Skill authoring

1. Read `~/.github/agents/lv0-skill-onboarding.agent.md`.
2. Read `~/.github/knowledge/agent-authoring.md`, `agent-stack.md`, and `naming-conventions.md`.
3. Reuse an existing shared skill or agent as the closest template before creating a new one.

## Operating Rules

- Prefer the smallest safe change that satisfies the task.
- Inspect local context before deciding on an implementation.
- Treat workflows, templates, checklists, knowledge folders, and instruction files as agent-owned implementation detail; users should be able to request outcomes directly.
- Reuse the shared workflows, templates, checklists, knowledge files, and path-specific instructions instead of inventing a new process each time.
- Keep repo-specific knowledge, templates, checklists, workflows, instructions, and thin wrappers in the current repo's `.github/` tree; keep only reusable cross-repo assets in `~/.github/`.
- Use the layered stack in `~/.github/knowledge/agent-stack.md` before adding new agents or instructions.
- Keep `.github/knowledge/progress-tracker.md` and `.github/knowledge/future-plan.md` updated for the current repo; save completed context in the progress tracker and unfinished work or todos in the future plan.
- Call out validation clearly, including when it could not be run.
- Keep summaries concise and practical.

## Maintenance Notes

- Keep shared workflow, checklist, template, and agent names aligned with the Codex and Claude mirrors unless the tool requires a different wrapper.
- Add durable repo facts to the current repo's `.github/knowledge/` when they will help future sessions.
- Bootstrap the repo-local `.github/knowledge/progress-tracker.md` and `.github/knowledge/future-plan.md` during repo onboarding if they do not exist yet.
- Add a new file under `~/.github/instructions/` only when the behavior should attach automatically to matching paths instead of staying inside a reusable custom agent.
