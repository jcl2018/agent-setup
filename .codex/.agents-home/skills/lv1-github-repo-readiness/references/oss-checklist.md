# GitHub Repo Readiness Checklist

## GitHub Collaboration Surface

- Make the README work as a GitHub landing page, not just a local scratch note.
- Add or verify `.github/workflows` so collaborators can validate changes from fresh clones.
- Add issue templates and a pull request template when outside or cross-team collaboration is expected.
- Keep `CONTRIBUTING.md` and `SECURITY.md` close to the GitHub workflow so collaborators know how to work safely.

## Public-Release Requirements

- Add a real `LICENSE` file before publishing so reuse terms are explicit.
- Add `CONTRIBUTING.md` and `SECURITY.md` so outside contributors know how to work safely with the repo.
- Consider `CODE_OF_CONDUCT.md`, issue templates, and a pull request template once outside collaboration is expected.
- Replace personal names, screenshots, paths, and data values with neutral examples.
- Add repository metadata such as `Homepage`, `Repository`, and `Issues` when the package manifest supports them.

## Private Or Internal Collaboration Helpers

- Document local setup, test commands, and expected access prerequisites for teammates.
- Explain which secrets stay local and how collaborators request access safely.
- Explain how GitHub collaborators should report vulnerabilities or secret leaks privately.

## README Rubric

- State what the project does in the first paragraph.
- Show a working install command and a first successful run.
- Include example input and output when the GitHub audience needs a safe demo path.
- Explain the current scope and what is intentionally unsupported.
- Link to docs, tests, and contribution guidance.

## Packaging And Metadata Hints

- Add repository URLs such as `Homepage`, `Repository`, and `Issues` when the manifest supports them.
- Keep public-facing metadata such as `readme`, short description, and version fields populated.
- Document development dependencies and the main validation command where GitHub collaborators will see them.
