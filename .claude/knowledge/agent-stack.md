# Agent Stack

## Purpose
Reduce folder overhead by giving the home-root Claude system one shared routing map while keeping repo-local continuity and overrides in each repository.

## Layer Order
1. `lv0-instruction-core`
   Common routing rules and the folder decision guide. Every other skill should read this first.
2. `lv0` onboarding and specialist skills
   - `lv0-repo-onboarding`: map a repository and build durable context before deeper work
   - `lv0-skill-onboarding`: guide creation and extension of shared skills and agents
   - `lv0-code-polisher`: pure code quality, refactoring, naming, structure, testability, and maintainability work
   - `lv0-doc-writer`: technical documentation, README updates, runbooks, architecture notes, and usage guides
3. `lv1` task skills
   - `lv1-feature-dev`
   - `lv1-defect-fix`
   - `lv1-code-review`
   - `lv1-github-repo-readiness`
4. Repo-specific skills
   Keep these thin and compose them from the layers above.

## Folder Decision Guide
- `~/.claude/workflows/`, `~/.claude/templates/`, `~/.claude/checklists/`, and `~/.claude/skills/`: reusable shared defaults
- `~/.claude/knowledge/`: shared cross-repo system notes such as `agent-stack.md`, `agent-authoring.md`, and naming rules
- `.claude/knowledge/`: repo-local durable facts, repo maps, the running `progress-tracker.md`, and the todo-focused `future-plan.md`
- `.claude/templates/`, `.claude/checklists/`, `.claude/workflows/`, and thin repo-local `.claude/skills/`: repo-specific overrides when this repo needs different behavior

## Composition Rules
1. Start with `lv0-instruction-core`.
2. Add any needed `lv0` onboarding or specialist skill before deeper task work.
3. Add the narrowest `lv1` task skill that matches the job.
4. Keep `.claude/knowledge/progress-tracker.md` and `.claude/knowledge/future-plan.md` in every repo and update them as part of normal task flow.
5. Put repo-specific rules, templates, checklists, workflows, and thin wrappers in the repo-local `.claude/` tree instead of the home folder.

## Example Stacks
- Repo and skill setup work: `lv0-instruction-core` + `lv0-repo-onboarding` + `lv0-skill-onboarding`
- Code cleanup with no behavior change: `lv0-instruction-core` + `lv0-code-polisher`
- Feature plus docs or PRDs: `lv0-instruction-core` + `lv1-feature-dev` + optional `lv0-doc-writer` when the task needs a stronger PRD or other feature documentation
- GitHub hardening or publication prep: `lv0-instruction-core` + `lv1-github-repo-readiness` + optional `lv0-doc-writer`
- New repo-specific feature agent: `lv0-instruction-core` + one `lv0` specialist + one repo-specific `lv2` wrapper

## Maintenance Notes
- When a shared rule changes, update `lv0-instruction-core` first and keep higher-level skills short.
- When you want a new template or checklist, first check whether the current stack already covers the need.
- Initialize repo-local `.claude/knowledge/progress-tracker.md` and `.claude/knowledge/future-plan.md` when onboarding a repo and keep them current after meaningful work.
- For a step-by-step creation flow, read `agent-authoring.md`.
