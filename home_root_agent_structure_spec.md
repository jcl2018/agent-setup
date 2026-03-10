# Home-Root Agent Configuration Spec

## Goal

Keep **three fully standalone agent systems** under the same home-level root structure:

- `~/.claude`
- `~/.codex`
- `~/.github`

Each tool must be able to operate as a **complete setup by itself**, without assuming another tool will handle planning, implementation, review, or verification.

---

## Design Principles

1. **One tool = one complete system**
   - Claude Code must be self-sufficient.
   - Codex must be self-sufficient.
   - Copilot must be self-sufficient.

2. **Same logic, different wrappers**
   - All three systems should share similar workflow ideas.
   - Each system should express them in its own native format.

3. **Home-root source of truth**
   - Keep reusable cross-repo agent configuration under the home directory.
   - Keep repo-specific knowledge, continuity docs, templates, checklists, workflows, and thin wrappers in each repo's local tool folder instead of the home folder.

4. **Modular over monolithic**
   - Do not put everything into one giant instruction file.
   - Split reusable knowledge into workflows, templates, checklists, and knowledge notes.

5. **Copyable across machines**
   - The whole structure should be easy to sync, back up, and move.
6. **Layered composition**
   - Keep one shared `lv0` instruction layer, then `lv0` specialist agents, then `lv1` task wrappers and repo-specific `lv2` wrappers.

---

## Final Preferred Root Structure

```text
~
Ã¢â€Å“Ã¢â€â‚¬ .claude/
Ã¢â€Å“Ã¢â€â‚¬ .codex/
Ã¢â€â€Ã¢â€â‚¬ .github/
```

This is the **human-facing structure** you want to keep.

---

## Recommended Folder Layout

```text
~
Ã¢â€Å“Ã¢â€â‚¬ .claude/
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ CLAUDE.md
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ settings.json
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ skills/
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ lv1-feature-dev/
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ SKILL.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ lv1-defect-fix/
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ SKILL.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ lv1-code-review/
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ SKILL.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ lv0-repo-onboarding/
Ã¢â€â€š  Ã¢â€â€š     Ã¢â€â€Ã¢â€â‚¬ SKILL.md
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ workflows/
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ workflow-feature.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ workflow-defect.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ workflow-code-review.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ workflow-onboarding.md
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ templates/
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ plan-template.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ defect-report-template.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ review-template.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ summary-template.md
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ checklists/
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ pre-edit-checklist.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ post-edit-checklist.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ bugfix-verification.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ feature-validation.md
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ knowledge/
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ architecture.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ coding-standards.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ naming-conventions.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ test-commands.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ repo-map.md
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ examples/
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ example-feature-request.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ example-defect-task.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ example-review-output.md
Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ tasks/                        # optional
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬ .codex/
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ AGENTS.md
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ config.toml
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ workflows/
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ workflow-feature.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ workflow-defect.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ workflow-code-review.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ workflow-onboarding.md
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ templates/
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ plan-template.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ defect-report-template.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ review-template.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ summary-template.md
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ checklists/
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ pre-edit-checklist.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ post-edit-checklist.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ bugfix-verification.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ feature-validation.md
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ knowledge/
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ architecture.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ coding-standards.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ naming-conventions.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ test-commands.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ repo-map.md
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ examples/
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ example-feature-request.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ example-defect-task.md
Ã¢â€â€š  Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ example-review-output.md
Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ tasks/                        # optional
Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ .agents-home/
Ã¢â€â€š     Ã¢â€â€Ã¢â€â‚¬ skills/
Ã¢â€â€š        Ã¢â€Å“Ã¢â€â‚¬ lv1-feature-dev/
Ã¢â€â€š        Ã¢â€Å“Ã¢â€â‚¬ lv1-defect-fix/
Ã¢â€â€š        Ã¢â€Å“Ã¢â€â‚¬ lv1-code-review/
Ã¢â€â€š        Ã¢â€â€Ã¢â€â‚¬ lv0-repo-onboarding/
Ã¢â€â€š
Ã¢â€â€Ã¢â€â‚¬ .github/
   Ã¢â€Å“Ã¢â€â‚¬ copilot-instructions.md
   Ã¢â€Å“Ã¢â€â‚¬ instructions/
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ feature.instructions.md
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ defect.instructions.md
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ review.instructions.md
   Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ onboarding.instructions.md
   Ã¢â€Å“Ã¢â€â‚¬ agents/
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ lv1-feature-dev.agent.md
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ lv1-defect-fix.agent.md
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ lv1-code-review.agent.md
   Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ lv0-repo-onboarding.agent.md
   Ã¢â€Å“Ã¢â€â‚¬ workflows/
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ workflow-feature.md
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ workflow-defect.md
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ workflow-code-review.md
   Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ workflow-onboarding.md
   Ã¢â€Å“Ã¢â€â‚¬ templates/
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ plan-template.md
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ defect-report-template.md
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ review-template.md
   Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ summary-template.md
   Ã¢â€Å“Ã¢â€â‚¬ checklists/
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ pre-edit-checklist.md
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ post-edit-checklist.md
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ bugfix-verification.md
   Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ feature-validation.md
   Ã¢â€Å“Ã¢â€â‚¬ knowledge/
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ architecture.md
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ coding-standards.md
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ naming-conventions.md
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ test-commands.md
   Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ repo-map.md
   Ã¢â€Å“Ã¢â€â‚¬ examples/
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ example-feature-request.md
   Ã¢â€â€š  Ã¢â€Å“Ã¢â€â‚¬ example-defect-task.md
   Ã¢â€â€š  Ã¢â€â€Ã¢â€â‚¬ example-review-output.md
   Ã¢â€Å“Ã¢â€â‚¬ tasks/                        # optional
   Ã¢â€â€Ã¢â€â‚¬ .copilot-home/
```

---

## Why These Extra Folders Exist

### `workflows/`
Stores the actual operating logic for major task types.

Use this for:
- feature development
- defect fixing
- code review
- repo onboarding
- documentation updates

These files describe the **process**, not just the prompt.

---

### `templates/`
Stores reusable output formats.

Use this for:
- implementation plans
- defect reports
- review summaries
- final handoff notes
- PR/commit summaries

Templates keep outputs consistent and easier to reuse.

---

### `checklists/`
Stores lightweight quality gates.

Use this for:
- pre-edit checks
- post-edit checks
- validation before completion
- bugfix verification
- feature verification

Checklists reduce sloppy execution.

---

### `knowledge/`
Stores persistent context.

Use this for:
- architecture notes
- coding standards
- naming conventions
- important commands
- repo map
- risky areas / do-not-touch zones

Use the home-folder `knowledge/` only for shared cross-repo system notes.
Use each repo's local `knowledge/` folder for repo-specific facts, `progress-tracker.md`, `future-plan.md`, and any templates or rules that differ by repository.

This is the long-lived memory layer for each tool.

---

### `examples/`
Stores sample inputs and outputs.

Use this for:
- example tasks
- example prompts
- example summaries
- example defect triage
- example review output

Examples help calibrate behavior without bloating the main instructions.

---

### `tasks/` (optional)
Stores persistent work items.

Use this only if you want the tool to keep track of:
- ongoing tasks
- queued tasks
- multi-step notes
- task state between sessions

If you do not need persistent task state, you can omit this folder.

---

## Tool-by-Tool Role of Each Root

## `~/.claude`
This is the complete standalone home setup for **Claude Code**.

### Main files
- `CLAUDE.md` = root behavior and global working rules
- `settings.json` = local configuration
- `skills/` = reusable skill modules

### Shared layers to maintain
- `lv0-instruction-core` = shared routing skill
- `lv0-repo-onboarding` = `lv0` repository-context helper
- `lv0-skill-onboarding` = `lv0` skill-authoring helper
- `lv0-code-polisher` = `lv0` code-quality specialist
- `lv0-doc-writer` = `lv0` documentation specialist
- `lv1-feature-dev`, `lv1-defect-fix`, `lv1-code-review` = `lv1` task wrappers

### Best use
- flexible coding workflows
- architecture exploration
- feature planning
- iterative debugging
- local project work

### Internal logic
Claude should be able to do all of the following by itself:
- plan
- inspect
- implement
- review
- verify
- summarize

---

## `~/.codex`
This is the complete standalone home setup for **Codex**.

### Main files
- `AGENTS.md` = root behavior and working rules
- `config.toml` = Codex config
- `.agents-home/skills/` = reusable skill modules for Codex

### Shared layers to maintain
- `lv0-instruction-core` = shared routing skill
- `lv0-repo-onboarding` = `lv0` repository-context helper
- `lv0-skill-onboarding` = `lv0` skill-authoring helper
- `lv0-code-polisher` = `lv0` code-quality specialist
- `lv0-doc-writer` = `lv0` documentation specialist
- `lv1-feature-dev`, `lv1-defect-fix`, `lv1-code-review` = `lv1` task wrappers

### Best use
- structured implementation tasks
- work-safe coding workflows
- scoped code changes
- bugfix loops
- deterministic development tasks

### Internal logic
Codex should be able to do all of the following by itself:
- plan
- inspect
- implement
- review
- verify
- summarize

---

## `~/.github`
This is the complete standalone home-style source-of-truth setup for **Copilot-related content**.

### Main files
- `copilot-instructions.md` = root instructions
- `instructions/` = scenario-specific instruction files
- `agents/` = custom agent definitions

### Shared layers to maintain
- `lv0-instruction-core` = shared routing agent
- `lv0-repo-onboarding` = `lv0` repository-context helper
- `lv0-skill-onboarding` = `lv0` skill-authoring helper
- `lv0-code-polisher` = `lv0` code-quality specialist
- `lv0-doc-writer` = `lv0` documentation specialist
- `lv1-feature-dev`, `lv1-defect-fix`, `lv1-code-review` = `lv1` task wrappers

### Best use
- repo-oriented work
- issue-to-implementation workflows
- review workflows
- repeatable coding tasks
- structured project guidance

### Internal logic
Copilot should be able to do all of the following by itself:
- plan
- inspect
- implement
- review
- verify
- summarize

---

## Workflow Set to Maintain in All Three Tools

Each tool should have its own version of the same core workflows.

Minimum set:

1. `workflow-feature.md`
2. `workflow-defect.md`
3. `workflow-code-review.md`
4. `workflow-onboarding.md`

Optional later:

5. `workflow-doc-update.md`
6. `workflow-refactor.md`
7. `workflow-test-hardening.md`
8. `workflow-release-note.md`

---

## Standard Workflow Shape

Use the same internal structure in every workflow file.

```md
# Workflow: <name>

## Purpose
What this workflow is for.

## Trigger
When the agent should use it.

## Inputs
What information is required.

## Steps
1. Understand the task.
2. Inspect relevant files and context.
3. Propose the smallest safe approach.
4. Implement changes.
5. Run checks or verification.
6. Review for risks and edge cases.
7. Summarize the result.

## Output
What the final response should include.

## Stop Conditions
When the agent should stop and ask for clarification or report blockers.
```

---

## Standard Template Set

Minimum template files:

- `plan-template.md`
- `defect-report-template.md`
- `review-template.md`
- `summary-template.md`

Recommended contents:

### `plan-template.md`
- goal
- affected areas
- approach
- risks
- validation plan

### `defect-report-template.md`
- issue summary
- reproduction
- likely cause
- fix approach
- validation
- remaining risk

### `review-template.md`
- scope reviewed
- correctness concerns
- edge cases
- test gaps
- final assessment

### `summary-template.md`
- what changed
- files touched
- validation status
- known limitations
- suggested next step

---

## Standard Checklist Set

Minimum checklist files:

- `pre-edit-checklist.md`
- `post-edit-checklist.md`
- `bugfix-verification.md`
- `feature-validation.md`

### Example checklist items

#### pre-edit
- Do I understand the task?
- Do I know the affected files?
- Am I making the smallest safe change?
- Do I understand test/build commands?

#### post-edit
- Did I keep scope controlled?
- Did I avoid unrelated refactors?
- Did I run or describe validation?
- Did I summarize risks clearly?

---

## Standard Knowledge Set

Minimum knowledge files:

- `architecture.md`
- `coding-standards.md`
- `naming-conventions.md`
- `test-commands.md`
- `repo-map.md`

Optional later:

- `danger-zones.md`
- `performance-guidelines.md`
- `release-process.md`
- `api-contracts.md`

---

## Naming Convention Rules

### File naming
Use lowercase kebab-case wherever possible.

Examples:
- `workflow-feature.md`
- `lv1-feature-dev.agent.md`
- `defect-report-template.md`

### Folder naming
Use short descriptive folder names.

Examples:
- `workflows`
- `templates`
- `checklists`
- `knowledge`
- `examples`

### Skill/agent names
Keep the same logical names across all tools.

Use:
- `lv0-instruction-core`
- `lv0-repo-onboarding`
- `lv0-skill-onboarding`
- `lv0-code-polisher`
- `lv0-doc-writer`
- `lv1-feature-dev`
- `lv1-defect-fix`
- `lv1-code-review`

This makes cross-tool maintenance easier.

---

## Setup Priority

Recommended order:

### Phase 1: create the structure
Create:
- `~/.claude`
- `~/.codex`
- `~/.github`

And add the common subfolders.

### Phase 2: add root instruction files
Create:
- `~/.claude/CLAUDE.md`
- `~/.codex/AGENTS.md`
- `~/.github/copilot-instructions.md`

### Phase 3: add workflow files
Start with:
- feature
- defect
- review
- onboarding

### Phase 4: add templates and checklists
These are small but high-value.

### Phase 5: add skills/agents
After the logic is stable, add:
- shared `lv0-instruction-core` skill or agent
- `lv0` onboarding helpers such as `lv0-repo-onboarding` and `lv0-skill-onboarding`
- `lv0` specialists such as `lv0-code-polisher` and `lv0-doc-writer`
- Claude skills
- Codex skills
- Copilot agents

### Phase 6: add examples and optional task persistence
Only after the base system is working.

---

## Minimum Viable Version

If you want the smallest useful version first, start with only this:

```text
~/.claude/
Ã¢â€Å“Ã¢â€â‚¬ CLAUDE.md
Ã¢â€Å“Ã¢â€â‚¬ workflows/
Ã¢â€Å“Ã¢â€â‚¬ templates/
Ã¢â€â€Ã¢â€â‚¬ knowledge/

~/.codex/
Ã¢â€Å“Ã¢â€â‚¬ AGENTS.md
Ã¢â€Å“Ã¢â€â‚¬ workflows/
Ã¢â€Å“Ã¢â€â‚¬ templates/
Ã¢â€â€Ã¢â€â‚¬ knowledge/

~/.github/
Ã¢â€Å“Ã¢â€â‚¬ copilot-instructions.md
Ã¢â€Å“Ã¢â€â‚¬ agents/
Ã¢â€Å“Ã¢â€â‚¬ workflows/
Ã¢â€â€Ã¢â€â‚¬ knowledge/
```

Then add:
- `checklists/`
- `examples/`
- `tasks/`
later.

---

## Portability Notes

To keep this easy to copy across machines:

- keep everything under the home folder
- avoid machine-specific absolute paths in the markdown files
- store commands as examples, not hardcoded environment assumptions
- keep personal and work variants in separate files if needed

Good pattern:

- `coding-standards-personal.md`
- `coding-standards-work.md`

or:

- `workflow-defect-personal.md`
- `workflow-defect-work.md`

only when your policies really differ.

---

## Recommended Next Step

After creating this structure, generate the actual contents for:

1. `~/.claude/CLAUDE.md`
2. `~/.codex/AGENTS.md`
3. `~/.github/copilot-instructions.md`
4. first workflow files:
   - feature
   - defect
   - review
5. first skill/agent files:
   - Claude `lv1-feature-dev` skill
   - Codex `lv1-feature-dev` skill
   - Copilot `lv1-feature-dev.agent.md`

That will give you the first fully usable version.
