---
name: write-adr
description: Record an architecture or domain decision as an ADR in docs/adr/. Use when a significant decision is made — a new dependency, a new bounded context or context relationship, a data ownership change, or a pattern future work must follow.
argument-hint: "[decision]"
---

Record this decision as an ADR: $ARGUMENTS

## Steps

1. Read `docs/adr/` and check no existing ADR already covers this. If one does and this changes it, the new ADR supersedes it: set the old one's status to `Superseded by NNNN`.
2. Copy `docs/adr/0000-template.md` to `docs/adr/NNNN-<kebab-title>.md`, using the next free number.
3. Fill in every section. Keep it under one screen. List at least one real alternative and why it lost.
4. Status is `Proposed` unless the owner has already agreed in an issue or PR; then `Accepted` and link that issue.
5. If the decision changes contexts or their relationships, update `docs/context-map.md` in the same change.
6. Commit as `docs(adr): <title>` in the current slice's PR, or open a small PR of its own if there is no current slice.
