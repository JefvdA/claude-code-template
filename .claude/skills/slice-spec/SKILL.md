---
name: slice-spec
description: Split an approved spec issue into slice issues (label `slice`, "Part of #N"), mark dependency-free slices `ready`, and add a slice checklist to the spec. Use when the owner says a spec is approved or asks to break a spec into tasks.
argument-hint: "[spec issue number]"
---

Slice spec issue #$ARGUMENTS into buildable issues.

## Steps

1. **Check approval.** Fetch the issue. It must have labels `spec` and `approved`, and no unchecked items under **Open questions**. If not, stop and report what is missing. Never add `approved` yourself.
2. **Check for existing slices.** Search for issues whose body contains `Part of #$ARGUMENTS`. If slices already exist, do not create duplicates; only fill gaps.
3. **Validate the slices** in the spec against the rules below. If a slice breaks a rule, comment on the spec with a proposed fix, label it `needs-decision`, and stop.
4. **Create one issue per slice** with the template below, label `slice`. Add `ready` to slices with no dependencies.
5. **Update the spec issue**: append a `## Slice issues` checklist (`- [ ] #<n> <title>`).
6. **Report** the slice issues, which are `ready`, and which can run in parallel (different contexts, no dependency between them).

## Slice rules

- Vertical: one observable behaviour end to end (domain → application → interface), not one layer.
- One bounded context per slice. A cross-context change is split at the interface.
- Independently mergeable to `main`; unfinished behaviour stays behind the spec's feature flag.
- Under ~400 changed lines excluding tests. Tests are part of the slice.
- The first slice creates the feature flag and adds new glossary terms. The last slice removes the flag.

## Slice issue template

Title: `<Context>: <behaviour in domain language>`

```markdown
Part of #<spec>

## Scope
<What this slice builds, in 2–4 sentences.>

## Acceptance criteria
<Copy the Given/When/Then scenarios this slice covers from the spec.>

## Bounded context
<Context> — layers touched: domain / application / infrastructure / interface

## Depends on
<#issue or "none">

## Feature flag
`<context>.<feature>` — <create | use | remove>

## Done when
- [ ] Scenarios above pass as tests
- [ ] Reviewer subagent passed, `review` label added
```
