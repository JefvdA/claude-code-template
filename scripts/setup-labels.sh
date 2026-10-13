#!/bin/bash
# Create the workflow labels in a repo. GitHub templates don't copy labels, so run once per new repo:
#   scripts/setup-labels.sh <owner>/<repo>
# Safe to re-run: existing labels are updated.
set -euo pipefail
repo="${1:?usage: scripts/setup-labels.sh <owner>/<repo>}"

labels=(
  "spec|5319e7|Feature spec"
  "approved|0e8a16|Spec approved by the owner (owner only)"
  "slice|1d76db|One buildable slice of a spec"
  "ready|c2e0c6|Slice has no unfinished dependencies"
  "in-progress|fbca04|Claimed by a session"
  "needs-decision|d93f0b|Blocked on a question for the owner"
  "blocked|b60205|Blocked on another issue or external factor"
  "review|0052cc|PR ready for the independent reviewer"
)

for entry in "${labels[@]}"; do
  IFS='|' read -r name color description <<<"$entry"
  if gh api "repos/$repo/labels/$name" >/dev/null 2>&1; then
    gh api -X PATCH "repos/$repo/labels/$name" -f color="$color" -f description="$description" >/dev/null
    echo "updated $name"
  else
    gh api -X POST "repos/$repo/labels" -f name="$name" -f color="$color" -f description="$description" >/dev/null
    echo "created $name"
  fi
done
