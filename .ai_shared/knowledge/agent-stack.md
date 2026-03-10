# Agent Stack

## Purpose
Give the home-root AI setup one shared routing map that Codex, Claude, and Copilot can all use without duplicating the same context three times.

## Layer Order
1. Tool entry wrappers
   - home entrypoints such as `~/.codex/AGENTS.md`, `~/.claude/CLAUDE.md`, and `~/.github/copilot-instructions.md`
   - repo-local tool overrides such as `.codex/`, `.claude/`, and `.github/` when a repo needs tool-specific behavior
2. Shared `lv0` base and specialist layers
   - `lv0-instruction-core`
   - `lv0-repo-onboarding`
   - `lv0-skill-onboarding`
   - `lv0-code-polisher`
   - `lv0-doc-writer`
3. Shared `lv1` task layers
   - `lv1-feature-dev`
   - `lv1-defect-fix`
   - `lv1-code-review`
   - `lv1-github-repo-readiness`
4. Repo-specific wrappers
   Keep these thin and compose them from the shared layers above.

## Folder Decision Guide
- `~/.ai_shared/`: shared cross-tool defaults for skills, workflows, templates, checklists, knowledge notes, examples, and tasks
- `.ai_shared/`: repo-local shared context, shared overrides, and canonical shared skill definitions for the current repository
- `~/.codex/`, `~/.claude/`, `~/.github/`: tool-native home wrappers, config, skills, agents, and instructions
- `.codex/`, `.claude/`, `.github/`: repo-local tool overrides and thin wrappers when a repo needs tool-specific behavior

## Lookup Order
1. Repo-local tool override
2. Repo-local `.ai_shared`
3. Home-level `~/.ai_shared`
4. Home-level tool wrapper or config

## Composition Rules
1. Start with the current tool's `lv0-instruction-core` wrapper.
2. Add any needed `lv0` onboarding or specialist layer before deeper task work.
3. Add the narrowest `lv1` task layer that matches the job.
4. Keep `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md` in every repo and update them as part of normal task flow.
5. Put repo-specific shared rules, templates, checklists, workflows, and durable notes in repo-local `.ai_shared/`.
6. Put tool-only behavior, wrapper logic, and config in the matching repo-local tool folder.

## Example Stacks
- Repo and skill setup work: tool wrapper + `lv0-instruction-core` + `lv0-repo-onboarding` + `lv0-skill-onboarding`
- Code cleanup with no behavior change: tool wrapper + `lv0-instruction-core` + `lv0-code-polisher`
- Feature plus docs or PRDs: tool wrapper + `lv0-instruction-core` + `lv1-feature-dev` + optional `lv0-doc-writer`
- GitHub hardening or publication prep: tool wrapper + `lv0-instruction-core` + `lv1-github-repo-readiness` + optional `lv0-doc-writer`
- New repo-specific wrapper: tool wrapper + one `lv0` specialist + one repo-specific override in `.codex/`, `.claude/`, or `.github/`

## Maintenance Notes
- When a shared rule changes, update `.ai_shared/` first and keep the tool wrappers short.
- Canonical shared skill and agent behavior lives in `.ai_shared/skills/`; regenerate `.codex/skills/`, `.claude/skills/`, and `.github/agents/` with `scripts/sync-shared-skills.ps1`.
- When you want a new template, checklist, workflow, or shared note, put it in `.ai_shared/` unless it is truly tool-specific.
- Initialize repo-local `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md` when onboarding a repo and keep them current after meaningful work.
- For step-by-step creation rules, read `agent-authoring.md`.
