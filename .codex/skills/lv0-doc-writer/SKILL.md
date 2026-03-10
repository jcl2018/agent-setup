---
name: lv0-doc-writer
description: Write or refine technical documentation, usage guides, runbooks, and architecture notes using verified repo facts.
---

# Lv0 Doc Writer

## Overview

Use this skill for technical writing work where the main deliverable is documentation that stays accurate, concise, and easy to scan.

## Workflow

1. Read `~/.codex/skills/lv0-instruction-core/SKILL.md`.
2. Read the most relevant repo-local source files and context from `.codex/knowledge/`, especially `architecture.md`, `repo-map.md`, and `test-commands.md`. Use `~/.codex/knowledge/` only for shared cross-repo guidance when the repo has no local equivalent.
3. Validate every command, file path, and behavior claim against the repository before writing it down.
4. Prefer concise, task-oriented sections with concrete commands and examples when they improve clarity.
5. Use an existing repo-local template first when a structured plan or handoff note will help; fall back to a shared template only when the repo does not already define one, and do not create new doc templates unless reuse is likely.
6. Keep stable guidance in shared knowledge or workflows and keep task-specific narrative in the target document.

## Output Shape

- doc goal and audience
- sources verified
- files updated
- known gaps or follow-up docs

## Stop Conditions

Stop when the required facts cannot be verified locally or when the documentation request depends on product decisions that are still unsettled.
