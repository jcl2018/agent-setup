# Agent Authoring

## Purpose
Explain how to add a new `lv0` or `lv1` Codex skill without breaking the shared hierarchy.

## Decide The Layer First
- Create an `lv0-*` skill when the behavior is cross-cutting and reusable across many tasks.
- Create an `lv1-*` skill when the behavior is a task wrapper such as feature work, defect fixing, review, or onboarding.
- Reserve `lv2-*` for repo-specific wrappers that compose the shared layers instead of replacing them.

## When To Create `lv0`
- The skill focuses on a stable concern such as code quality, docs, testing, release notes, or refactoring.
- The skill is an onboarding helper such as repository mapping or skill-authoring guidance.
- The skill should be composable with multiple `lv1` task wrappers.
- The skill usually does not need its own workflow file unless it introduces a brand-new process.

## When To Create `lv1`
- The skill represents a repeatable task type with a clear start-to-finish workflow.
- The skill should read `lv0-instruction-core` first, then route into a workflow, templates, checklists, and knowledge notes.
- The skill should stay generic enough to reuse across repositories.

## Files To Create

### New `lv0` Codex skill
1. Create `.codex/skills/lv0-<name>/SKILL.md`.
2. Create `.codex/skills/lv0-<name>/agents/openai.yaml`.
3. Mirror the same files into `.codex/.agents-home/skills/lv0-<name>/`.
4. If the skill adds durable policy or decision rules, update `.codex/knowledge/agent-stack.md` and `.codex/knowledge/naming-conventions.md`.

### New `lv1` Codex skill
1. Create `.codex/skills/lv1-<name>/SKILL.md`.
2. Create `.codex/skills/lv1-<name>/agents/openai.yaml`.
3. Mirror the same files into `.codex/.agents-home/skills/lv1-<name>/`.
4. Reuse an existing workflow in `.codex/workflows/` when possible.
5. Add a new workflow only if this is a genuinely new task class.

## Skill Template

### `SKILL.md`
- frontmatter `name` should exactly match the folder name
- short description focused on when to use the skill
- overview
- workflow
- output shape
- stop conditions

### `openai.yaml`
- `display_name` should be readable in the picker
- `short_description` should explain the outcome
- `default_prompt` should call the skill by its exact `$lv0-*` or `$lv1-*` name
- keep `allow_implicit_invocation: true` unless you have a strong reason not to

## Authoring Rules
1. Start every new `lv0` or `lv1` skill from `~/.codex/skills/lv0-instruction-core/SKILL.md`.
2. Prefer composing existing workflows, templates, and checklists before adding new ones.
3. Keep `lv0` skills concern-oriented and keep `lv1` skills task-oriented.
4. Do not put repo-specific facts into shared `lv0` or `lv1` skills.
5. If the change affects shared behavior, update both `.codex/skills/` and `.codex/.agents-home/skills/` in the same pass.

## Example Stacks
- New reusable test-hardening skill:
  `lv0-instruction-core` + `lv0-test-hardener`
- Extending this agent repo itself:
  `lv0-instruction-core` + `lv0-repo-onboarding` + `lv0-skill-onboarding`
- New shared release task:
  `lv0-instruction-core` + `lv1-release-note-writer`
- New repo-specific backend feature wrapper:
  `lv0-instruction-core` + `lv0-code-polisher` + `lv1-feature-dev` + `lv2-backend-feature-dev`

## Validation
- Run `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -WhatIf`
- Check that the new skill appears under `.codex/skills/` and `.codex/.agents-home/skills/`
- Scan for stale names with `Select-String`
- If you added a new shared pattern, update the docs that describe the stack
