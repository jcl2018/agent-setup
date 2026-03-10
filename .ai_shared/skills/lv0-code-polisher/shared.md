# {{DISPLAY_NAME}}

## Overview

Use this {{WRAPPER_NOUN}} for cleanup and craftsmanship work that should stay focused on code quality rather than product behavior or documentation scope.

## Workflow

1. Read `{{ENTRY_REF}}`.
2. Read the most relevant repo-local context from `.ai_shared/knowledge/`, especially `coding-standards.md`, `naming-conventions.md`, `repo-map.md`, and `test-commands.md`. Use `~/.ai_shared/knowledge/` for shared cross-repo guidance when the repo has no local override.
3. Treat intended behavior as fixed unless the user explicitly asks for a behavior change.
4. Prefer small improvements to naming, duplication, control flow, structure, testability, and local comments.
5. Keep public contracts, data shapes, and file layout stable unless a change is required to make the cleanup safe.
6. Run the narrowest useful validation and call out any behavior assumptions clearly.

## Output Shape

- code-quality goal
- behavior-preservation assumptions
- validation run
- remaining cleanup or risk

## Stop Conditions

Stop when the requested cleanup would materially change product behavior, public contracts, or architecture without an explicit decision to do so.
