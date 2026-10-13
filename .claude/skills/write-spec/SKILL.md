---
name: write-spec
description: Turn a rough feature idea into a spec GitHub issue (label `spec`) with goal, bounded contexts, Given/When/Then acceptance criteria, scope, slices and open questions. Use when the owner describes a new feature or asks for a plan or spec.
argument-hint: "[rough idea]"
---

Write a spec issue for this idea: $ARGUMENTS

## Steps

1. **Understand the domain first.** Read `docs/context-map.md`, `docs/glossary.md`, relevant ADRs in `docs/adr/`, and the code in the contexts this likely touches.
2. **Check for overlap.** Search open and closed issues and open PRs (REST: `gh api repos/{owner}/{repo}/issues?state=all&labels=spec`). If an existing spec covers this, comment there instead and stop.
3. **Ask before writing** if the goal, the users affected or the main behaviour is unclear. Ask at most five sharp questions at once. Anything still unclear goes into **Open questions**.
4. **Write the issue** using the template below. Use glossary terms; mark new terms as **new**.
5. **Create it** with labels `spec` (never `approved`). Title: `Spec: <feature in domain language>`.
6. **Report** the issue link and the open questions the owner must answer before approving.

## Template

```markdown
## Goal
<The problem, who has it, and why it matters. 2–4 sentences.>

## Bounded context(s)
- <Context>: <what changes here>
- New terms: <term — meaning> (added to the glossary in the first slice)
- Context map changes: <none | new relationship + pattern>

## Behaviour (acceptance criteria)
### Scenario: <name>
- Given <state>
- When <action>
- Then <observable outcome>

## Out of scope
- <What this spec deliberately does not do>

## Feature flag
`<context>.<feature>` (off in production until the last slice)

## Slices
1. **<name>** — <scope>. Covers: <scenarios>. Depends on: none.
2. **<name>** — <scope>. Covers: <scenarios>. Depends on: 1.
<Each slice is vertical, inside one context, under ~400 changed lines excluding tests. The last slice removes the flag.>

## Open questions
- [ ] <question> — options: A / B; recommendation: A because …
<Must be empty or all checked before approval.>
```

## Quality bar

- Every scenario is testable and observable from outside the domain.
- Every scenario is covered by exactly one slice.
- Slices in the same context are ordered; slices in different contexts can run in parallel.
- No implementation detail beyond what the owner must agree on (APIs between contexts, data ownership, new dependencies).
