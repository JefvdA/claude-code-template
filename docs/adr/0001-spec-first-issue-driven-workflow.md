# 0001. Spec-first, issue-driven workflow with small slices

- **Status**: Accepted
- **Date**: 2026-10-14
- **Context(s)**: all
- **Issue**: n/a (template baseline)

## Context

Work is done mostly by parallel Claude Code sessions with one human owner reviewing from a phone.
Without a shared source of truth, sessions duplicate work, PRs grow large, and planning gaps are found only in review.

## Decision

- Every feature starts as a **spec issue** (label `spec`). It is approved only when the owner adds the `approved` label. Claude never adds `approved`.
- An approved spec is split into **slice issues** (label `slice`, body "Part of #N"). One slice is one PR that closes it.
- A session **claims** a slice issue before starting (label `in-progress` plus a comment with its session link) and checks open PRs and branches first.
- PRs stay under roughly **400 changed lines**, excluding tests and generated files. Exceptions are allowed when explained in the PR.
- Unfinished features merge to `main` behind **config-based feature flags**; branches are short-lived. The last slice of a spec removes its flag.
- A session that hits something the spec does not cover labels the issue `needs-decision`, comments the question, and stops.
- Domain knowledge lives in `docs/glossary.md`, `docs/context-map.md` and `docs/adr/`, changed through PRs.

## Alternatives considered

- **Specs as files approved by merging a PR**: rejected; issues fit the owner's way of working better.
- **Long-lived feature branches**: rejected; they bring back large PRs and merge conflicts.
- **GitHub Projects board for state**: not usable from cloud sessions (GraphQL is blocked), so state lives in labels.

## Consequences

- Labels must exist in every repo (`scripts/setup-labels.sh`).
- Claude acts with the owner's GitHub identity, so the `approved` rule is an instruction, not an enforced permission.
