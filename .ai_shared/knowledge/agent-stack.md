# Agent Stack

## Purpose
Give the home-root AI setup one shared routing map that Codex and Claude can both use without duplicating the same context twice.

## Layer Order
1. Tool entry wrappers
   - home entrypoints such as `~/.codex/AGENTS.md` and `~/.claude/CLAUDE.md`
   - repo-local tool overrides such as `.codex/` and `.claude/` when a repo needs tool-specific behavior
2. Shared `lv0` base and specialist layers
   Basic logistics, standards, audit, routing, and automation layers that can support many kinds of tasks.
   - `lv0-instruction-core`
   - `lv0-run-transparency`
   - `lv0-home-auditor`
   - `lv0-repo-onboarding`
   - `lv0-skill-onboarding`
   - `lv0-code-polisher`
   - `lv0-doc-writer`
3. Shared `lv1` task layers
   Reusable shared workflows that solve a class of work across many repos.
   - `lv1-feature-dev`
   - `lv1-figma-implement-design`
   - `lv1-defect-fix`
   - `lv1-code-review`
   - `lv1-github-repo-readiness`
4. Repo-specific wrappers
   Keep these thin, name them with a repo prefix such as `lv2-<repo>-<name>`, and compose them from the shared layers above.

## Folder Decision Guide
- `~/.ai_shared/`: shared cross-tool defaults for workflows, templates, checklists, knowledge notes, examples, and tasks
- `.ai_shared/`: repo-local shared context and shared overrides for the current repository
- `~/.codex/`, `~/.claude/`: tool-native home wrappers, config, and skills
- `.codex/`, `.claude/`: repo-local tool overrides and thin wrappers when a repo needs tool-specific behavior

## Lookup Order
1. Repo-local tool override
2. Repo-local `.ai_shared`
3. Home-level `~/.ai_shared`
4. Home-level tool wrapper or config

## Composition Rules
1. Start with the current tool's `lv0-instruction-core` wrapper.
2. Decide whether the weekly `lv0-home-auditor` gates need to run by checking `~/.ai_shared/knowledge/progress-tracker.md` for the global home pass and `.ai_shared/knowledge/progress-tracker.md` for the current repo's weekly audit pass.
3. Add `lv0-run-transparency` at the start of every run so the user sees the selected skills, the repo-local `.ai_shared/` files consulted, the home-level `~/.ai_shared/` defaults consulted, and why that stack fits the task.
4. For any task that changes code, add `lv0-code-polisher` before deeper task work.
5. Add any other needed `lv0` onboarding or specialist layer before deeper task work.
6. Add the narrowest `lv1` task layer that matches the job.
7. Keep `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md` in every repo and update them as part of normal repo task flow, including repo-specific weekly audit continuity.
8. Reserve `~/.ai_shared/knowledge/progress-tracker.md` and `~/.ai_shared/knowledge/future-plan.md` for the global `lv0-home-auditor` continuity across repos.
9. Put repo-specific shared rules, templates, checklists, workflows, and durable notes in repo-local `.ai_shared/`.
10. Put tool-only behavior, wrapper logic, and config in the matching repo-local tool folder.

## Example Stacks
- Weekly home-folder alignment check: tool wrapper + `lv0-instruction-core` + `lv0-run-transparency` + `lv0-home-auditor`
- Repo and skill setup work: tool wrapper + `lv0-instruction-core` + `lv0-run-transparency` + `lv0-repo-onboarding` + `lv0-skill-onboarding`
- Code cleanup with no behavior change: tool wrapper + `lv0-instruction-core` + `lv0-run-transparency` + `lv0-code-polisher`
- Defect fix: tool wrapper + `lv0-instruction-core` + `lv0-run-transparency` + `lv0-code-polisher` + `lv1-defect-fix`
- Feature plus docs or PRDs: tool wrapper + `lv0-instruction-core` + `lv0-run-transparency` + `lv0-code-polisher` + `lv1-feature-dev` + optional `lv0-doc-writer`
- Figma-driven UI work: tool wrapper + `lv0-instruction-core` + `lv0-run-transparency` + `lv0-code-polisher` + `lv1-figma-implement-design`
- GitHub hardening or publication prep: tool wrapper + `lv0-instruction-core` + `lv0-run-transparency` + `lv0-home-auditor` + `lv1-github-repo-readiness` + optional `lv0-doc-writer`
- New repo-specific wrapper: tool wrapper + `lv0-instruction-core` + `lv0-run-transparency` + one `lv0` specialist + one repo-specific `lv2-<repo>-<name>` override in `.codex/` or `.claude/`

## Maintenance Notes
- When a shared rule changes, update `.ai_shared/` first and keep the tool wrappers short.
- When you want a new template, checklist, workflow, or shared note, put it in `.ai_shared/` unless it is truly tool-specific.
- Initialize repo-local `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md` when onboarding a repo and keep them current after meaningful work.
- Keep the live home `~/.ai_shared/knowledge/progress-tracker.md` and `~/.ai_shared/knowledge/future-plan.md` for weekly home-audit continuity rather than repo continuity.
- Put repo-specific audit rules in repo-local `.ai_shared/workflows/workflow-home-audit.md`, `.ai_shared/checklists/home-audit-checklist.md`, and `.ai_shared/knowledge/home-audit-rules.md` when a repo needs extra audit coverage.
- Put generic local-repo audit logic in `lv0-home-auditor`; keep GitHub-facing visibility and publication logic in `lv1-github-repo-readiness`.
- For step-by-step creation rules, read `agent-authoring.md`.
