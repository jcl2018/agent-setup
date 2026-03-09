# Agent Authoring

## Purpose
Explain how to add a new `lv0` or `lv1` Copilot custom agent without breaking the shared hierarchy.

## Decide The Layer First
- Create an `lv0-*` agent when the behavior is cross-cutting and reusable across many tasks.
- Create an `lv1-*` agent when the behavior is a task wrapper such as feature work, defect fixing, review, or onboarding.
- Reserve `lv2-*` for repo-specific wrappers that compose the shared layers instead of replacing them.

## When To Create `lv0`
- The agent focuses on a stable concern such as code quality, docs, testing, release notes, or refactoring.
- The agent is an onboarding helper such as repository mapping or skill-authoring guidance.
- The agent should be composable with multiple `lv1` task agents.
- The agent usually does not need its own workflow file unless it introduces a brand-new process.

## When To Create `lv1`
- The agent represents a repeatable task type with a clear start-to-finish workflow.
- The agent should read `lv0-instruction-core` first, then route into a workflow, templates, checklists, and knowledge notes.
- The agent should stay generic enough to reuse across repositories.

## Files To Create

### New `lv0` Copilot agent
1. Create `.github/agents/lv0-<name>.agent.md`.
2. If the agent adds durable policy or decision rules, update `.github/knowledge/agent-stack.md` and `.github/knowledge/naming-conventions.md`.
3. Add a path-specific instruction under `.github/instructions/` only if the behavior should attach automatically to matching files.

### New `lv1` Copilot agent
1. Create `.github/agents/lv1-<name>.agent.md`.
2. Reuse an existing workflow in `.github/workflows/` when possible.
3. Add a new workflow only if this is a genuinely new task class.

## Agent Template
- frontmatter `name` should be readable in the Copilot picker
- short description focused on when to use the agent
- task summary sentence
- ordered steps
- explicit references to the shared workflow, knowledge, template, and checklist files when relevant

## Authoring Rules
1. Start every new `lv0` or `lv1` agent from `.github/agents/lv0-instruction-core.agent.md`.
2. Prefer composing existing workflows, templates, and checklists before adding new ones.
3. Keep `lv0` agents concern-oriented and keep `lv1` agents task-oriented.
4. Do not put repo-specific facts into shared `lv0` or `lv1` agents.
5. Keep the Copilot names aligned with Codex and Claude unless the tool wrapper truly differs.

## Example Stacks
- New reusable test-hardening agent:
  `lv0-instruction-core` + `lv0-test-hardener`
- Extending this agent repo itself:
  `lv0-instruction-core` + `lv0-repo-onboarding` + `lv0-skill-onboarding`
- New shared release task:
  `lv0-instruction-core` + `lv1-release-note-writer`
- New repo-specific backend feature wrapper:
  `lv0-instruction-core` + `lv0-code-polisher` + `lv1-feature-dev` + `lv2-backend-feature-dev`

## Validation
- Run `powershell -ExecutionPolicy Bypass -File .\scripts\sync-to-home.ps1 -WhatIf`
- Check that the new file appears under `.github/agents/`
- Scan for stale names with `Select-String`
- If you added a new shared pattern, update the docs that describe the stack
