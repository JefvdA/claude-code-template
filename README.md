# claude-code-template

Starting point for repositories worked on with Claude Code (cloud sessions and Projects).

It encodes a spec-first, issue-driven, Domain-Driven-Design way of working:

- **Specs** live in GitHub issues and are approved with the `approved` label.
- **Slices** are separate issues; one slice = one small PR (~400 changed lines).
- **Unfinished work** ships to `main` behind config-based feature flags.
- **Domain knowledge** (glossary, context map, ADRs) lives in `docs/`.
- **Review** happens twice: a reviewer subagent inside the thread, then an independent reviewer routine.

## Using this template

1. Create a new repo with **Use this template**.
2. Run `scripts/setup-labels.sh <owner>/<repo>` once (labels are not copied by GitHub templates).
3. Fill in the stack section of `CLAUDE.md` and the scripts in `scripts/` (`install.sh`, `format.sh`, `test-fast.sh`).
4. Install the Claude GitHub App on the new repo.
5. Create the reviewer routine from `docs/claude/reviewer-routine.md`.
