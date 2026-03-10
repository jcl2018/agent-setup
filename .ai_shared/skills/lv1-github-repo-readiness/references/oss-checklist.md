# GitHub Repo Readiness Checklist

## Shared Blockers For Any GitHub Repo

- Remove or anonymize private data, secrets, personal spreadsheets, local databases, cache folders, and generated reports.
- Verify a fresh clone can install and run with documented commands.
- Add sample data or a safe demo path when the real project data is private.
- Confirm tests pass locally and document the test command.
- Expand `.gitignore` before the repo is shared more widely.

## Public-Release Requirements

- Add a real `LICENSE` file before publishing so reuse terms are explicit.
- Add `CONTRIBUTING.md` and `SECURITY.md` so outside contributors know how to work safely with the repo.
- Consider `CODE_OF_CONDUCT.md`, issue templates, and a pull request template once outside collaboration is expected.
- Replace personal names, screenshots, paths, and data values with neutral examples.

## Private Or Internal Collaboration Helpers

- Document local setup, test commands, and expected access prerequisites for teammates.
- Explain which secrets stay local and how collaborators request access safely.
- Prefer sanitized fixtures, sample databases, and example config files over real account data.
- Call out local-only assumptions so internal contributors know what is safe to change.

## README Rubric

- State what the project does in the first paragraph.
- Show a working install command and a first successful run.
- Include example input and output, especially when real data cannot be shared.
- Explain the current scope and what is intentionally unsupported.
- Link to docs, tests, and contribution guidance.

## Packaging And Metadata Hints

- Add repository URLs such as `Homepage`, `Repository`, and `Issues` when the manifest supports them.
- Keep `readme`, runtime requirements, short description, and version metadata populated.
- Document development dependencies and the main validation command.
- Add CI that installs the project from a clean environment and runs tests.
