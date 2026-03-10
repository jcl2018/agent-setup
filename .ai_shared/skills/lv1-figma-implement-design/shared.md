# {{DISPLAY_NAME}}

## Overview

Use this shared `lv1` {{WRAPPER_NOUN}} when a repo needs UI work driven by a Figma frame, node, or screenshot-backed Figma handoff.

This capability is intentionally repo-agnostic:
- start with `lv0-instruction-core`
- use repo knowledge or a thin `lv2-*` wrapper for project-specific rules
- reuse the existing feature workflow instead of inventing a design-only process
- translate Figma output into the current repo's framework, tokens, and component conventions

## Workflow

1. Read `{{ENTRY_REF}}`.
2. Read `~/.ai_shared/workflows/workflow-feature.md`.
3. Read the most relevant repo-local context from `.ai_shared/knowledge/`, especially `architecture.md`, `repo-map.md`, `test-commands.md`, `progress-tracker.md`, and `future-plan.md`. Use `~/.ai_shared/knowledge/` for shared cross-repo guidance when the repo has no local override.
4. Confirm the Figma source:
   - a Figma design URL with a stable node target
   - a selected node in the Figma desktop app
   - or a repo-specific wrapper that already narrowed the target
5. Confirm the design-context path is available before implementation. If the needed Figma tooling is not configured, stop after providing the setup steps needed to continue safely.
6. Fetch design context before changing code:
   - inspect structured design data when available
   - capture or reuse a screenshot reference
   - inspect child nodes separately when the top-level frame is too large
7. Inspect the current UI surface before editing code. Reuse existing components, tokens, CSS primitives, layouts, and interaction patterns instead of pasting raw Figma output.
8. Translate the design into repo conventions without framework drift. Keep the repo's existing stack, folder structure, build system, and test style unless the user explicitly asks for broader changes.
9. Validate both implementation and fidelity:
   - run the normal repo validation from the shared feature workflow
   - compare the final UI against the Figma reference for layout, typography, color, spacing, states, and responsive behavior
10. Update `.ai_shared/knowledge/progress-tracker.md` and `.ai_shared/knowledge/future-plan.md` when the reusable workflow changes or follow-up design work remains.

## Output Shape

- chosen repo stack and Figma source
- UI surface reviewed or changed
- repo validation status
- visual-fidelity validation status
- remaining gap or next step

## Stop Conditions

Stop when no reliable Figma reference is available for a fidelity-critical request, when the needed design context is unavailable and the missing details would force guesswork, or when the requested change is really a broader product or information-architecture redesign rather than a scoped implementation task.
