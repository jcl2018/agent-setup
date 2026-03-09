# Agent Authoring

## Purpose
Explain how to add a new `lv0` or `lv1` Claude skill without breaking the shared hierarchy.

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

### New `lv0` Claude skill
1. Create `.claude/skills/lv0-<name>/SKILL.md`.
2. If the skill adds durable policy or decision rules, update `.claude/knowledge/agent-stack.md` and `.claude/knowledge/naming-conventions.md`.

### New `lv1` Claude skill
1. Create `.claude/skills/lv1-<name>/SKILL.md`.
2. Reuse an existing workflow in `.claude/workflows/` when possible.
3. Add a new workflow only if this is a genuinely new task class.

## Skill Template
- frontmatter `name` should exactly match the folder name
- short description focused on when to use the skill
- overview
- workflow
- output shape
- stop conditions

## Authoring Rules
1. Start every new `lv0` or `lv1` skill from `~/.claude/skills/lv0-instruction-core/SKILL.md`.
2. Prefer composing existing workflows, templates, and checklists before adding new ones.
3. Keep `lv0` skills concern-oriented and keep `lv1` skills task-oriented.
4. Do not put repo-specific facts into shared `lv0` or `lv1` skills.
5. Keep the Claude names aligned with Codex and Copilot unless the tool wrapper truly differs.

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
- Check that the new skill appears under `.claude/skills/`
- Scan for stale names with `Select-String`
- If you added a new shared pattern, update the docs that describe the stack
