# Workflow: Feature Development

## Purpose
Implement a new capability or meaningful enhancement with the smallest safe change set.

## Trigger
Use this workflow when the task asks for:
- new behavior
- expanded functionality
- user-facing improvements
- internal tooling that adds a new capability

## Inputs
- requested outcome or acceptance criteria
- affected repo area, files, or feature surface
- product-shaping details such as requirements, APIs, use cases, constraints, or open questions when they exist
- constraints such as compatibility, timing, style, or performance expectations

## Steps
1. Understand the task and restate the goal in concrete terms.
2. Inspect the relevant files, entry points, existing docs locations, and validation commands.
3. If the task introduces or changes product-shaping details such as requirements, APIs, use cases, acceptance criteria, or open questions, create or update a PRD in the repo's existing docs area. Prefer the established PRD path when one exists; otherwise use `docs/prd/<feature-name>.md` and the shared PRD template.
4. Propose the smallest safe approach that satisfies the request and the documented product intent.
5. Implement the change with scope discipline and `lv0-code-polisher` craftsmanship expectations while keeping the PRD aligned with important decisions, tradeoffs, and deferred items.
6. Run checks or describe what could not be run.
7. Review for regressions, edge cases, and follow-on impacts.
8. Update `.ai_shared/knowledge/progress-tracker.md` with what changed, PRD status, validation, and resume context.
9. Add unfinished follow-ups or deferred ideas to `.ai_shared/knowledge/future-plan.md`.
10. Summarize the result, PRD status, validation, and remaining risks.

## Output
The final response should include:
- what changed
- PRD touched or skipped
- important files touched
- validation status
- tracker or follow-up docs updated when relevant
- remaining risks or follow-up suggestions

## Stop Conditions
Stop when the requested behavior is unclear or contradictory, the likely implementation path is high-risk without more context, the product intent cannot be documented with reasonable confidence, required files, services, or credentials are unavailable, or the task would require broad unrelated refactors to proceed safely.
