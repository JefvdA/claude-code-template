# CLAUDE.md

Single-owner repository, worked on by parallel Claude Code sessions. The owner reviews from a phone, so keep everything small and easy to scan.

## Orientation (do this first)

1. Read `docs/context-map.md` and `docs/glossary.md`. Use glossary terms exactly in code, issues and PRs.
2. Read the issue you are working on, and its parent spec issue ("Part of #N").
3. Check `docs/adr/` for decisions that touch your area. Do not re-decide them differently.

## Workflow

Full rules: `.claude/rules/workflow.md`

- Work only from an issue. Specs carry the `spec` label; build only from specs that carry `approved`.
- **Never add the `approved` label.** Only the owner approves.
- Before writing code: check open PRs and branches for the same issue, then claim it (`in-progress` label plus a comment with your session link).
- Search before you create: reuse existing modules, types and helpers. If something similar exists, extend it or explain in the PR why not.
- One slice = one PR = one issue ("Closes #N"). About 400 changed lines max, excluding tests and generated files.
- If the spec does not cover something you need to decide: label the issue `needs-decision`, comment the question with options, and stop. Do not improvise.
- Unfinished features go behind a feature flag (see `.claude/rules/feature-flags.md`).

## Commits

- Conventional Commits: `feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:`, with an optional scope set to the bounded context, e.g. `feat(billing): ...`.
- Small commits that each build and pass tests. Tests ship in the same slice as the code.
- Never force-push, never push to `main`, never rewrite shared history.

## Design rules (DDD)

Full rules: `.claude/rules/ddd.md`

- Each bounded context owns its model. No reaching into another context's internals or tables.
- The domain layer has no framework, database or HTTP dependencies.
- Contexts talk only through the interfaces listed in `docs/context-map.md`.
- New or changed terms go into `docs/glossary.md` in the same PR. Significant decisions get an ADR (`/write-adr`).

## Definition of done

- [ ] Fast tests and lint pass (`scripts/test-fast.sh`, `scripts/format.sh`).
- [ ] PR is within the size cap, or explains why not.
- [ ] PR body links the issue (`Closes #N`) and lists which acceptance criteria it covers.
- [ ] Glossary and context map updated if terms or relationships changed.
- [ ] The `reviewer` subagent has reviewed the diff and its findings are fixed or answered.
- [ ] `review` label added to the PR so the independent reviewer runs.

## Stack

_Fill in when the stack is chosen._

- Language / framework: TBD
- Install: `scripts/install.sh`
- Format + lint: `scripts/format.sh`
- Fast tests: `scripts/test-fast.sh`
- Full tests: TBD
- Feature flags: location and usage in `.claude/rules/feature-flags.md`
