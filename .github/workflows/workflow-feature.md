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
- constraints such as compatibility, timing, style, or performance expectations

## Steps
1. Understand the task and restate the goal in concrete terms.
2. Inspect the relevant files, entry points, and validation commands.
3. Propose the smallest safe approach that satisfies the request.
4. Implement the change with scope discipline.
5. Run checks or describe what could not be run.
6. Review for regressions, edge cases, and follow-on impacts.
7. Summarize the result, validation, and remaining risks.

## Output
The final response should include:
- what changed
- important files touched
- validation status
- remaining risks or follow-up suggestions

## Stop Conditions
Stop when the requested behavior is unclear or contradictory, the likely implementation path is high-risk without more context, required files, services, or credentials are unavailable, or the task would require broad unrelated refactors to proceed safely.
