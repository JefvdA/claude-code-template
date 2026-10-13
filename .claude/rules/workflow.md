# Workflow rules

## Labels

| Label | Meaning | Who sets it |
| :- | :- | :- |
| `spec` | Issue is a feature spec | Claude or owner |
| `approved` | Spec is approved for building | **Owner only** |
| `slice` | Issue is one buildable slice of a spec | Claude |
| `ready` | Slice has no unfinished dependencies | Claude |
| `in-progress` | A session has claimed the issue | The claiming session |
| `needs-decision` | Blocked on a question for the owner | Claude |
| `blocked` | Blocked on another issue or external factor | Claude |
| `review` (PRs) | PR is ready for the independent reviewer | Claude, after the reviewer subagent passes |

## Lifecycle

1. **Idea** → `/write-spec` creates a spec issue (`spec`). Open questions are listed in the issue.
2. **Approval** → owner adds `approved` once open questions are resolved.
3. **Slicing** → `/slice-spec #N` creates slice issues (`slice`, "Part of #N"), marks those without dependencies `ready`, and adds a checklist of slices to the spec issue.
4. **Build** → a session claims one `ready` slice, builds it on a `claude/` branch, and opens a PR that `Closes #<slice>`.
5. **Review** → reviewer subagent first, then add the `review` label for the independent reviewer.
6. **Merge** → owner merges. When a slice merges, the next session marks dependants `ready`.
7. **Finish** → the last slice removes the feature flag and the spec issue is closed.

## Claiming an issue

Before writing any code:

1. Check the issue has no `in-progress` label and no open PR or `claude/` branch referencing it. If it does, stop and report.
2. Add `in-progress` and comment: `Claimed by session: <session link>`.
3. If you abandon the work, remove `in-progress` and comment why.

GitHub access: use the built-in GitHub tools or `gh api repos/{owner}/{repo}/...` (REST). `gh issue` and `gh pr` use GraphQL and are blocked in cloud sessions.

## Size cap

About 400 changed lines per PR, excluding tests, lockfiles and generated files.
If a slice will not fit, split it: comment on the slice issue with a proposed split and stop, rather than opening a large PR.
Exceptions (e.g. a mechanical rename) are fine when the PR body says why.

## Spec gaps

When you need a decision the spec does not make (behaviour, naming, a new dependency, a new context relationship):

1. Label the issue `needs-decision`.
2. Comment the question, two or three options, and your recommendation.
3. Stop. Do not choose silently, and do not build around the gap.
