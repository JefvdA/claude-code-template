#!/bin/bash
# Before Claude finishes a turn: run the fast tests, but only if code changed.
# Blocks once with the failure; if Claude is already continuing because of this hook, let it stop
# (stop_hook_active) so a broken test suite can never trap the session in a loop.
cd "$CLAUDE_PROJECT_DIR" || exit 0
[ -x scripts/test-fast.sh ] || exit 0

input=$(cat)
if [ "$(echo "$input" | jq -r '.stop_hook_active // false' 2>/dev/null)" = "true" ]; then
  exit 0
fi

# Nothing changed relative to main and nothing uncommitted: skip.
if git diff --quiet HEAD 2>/dev/null && git diff --quiet origin/main...HEAD 2>/dev/null; then
  exit 0
fi

if ! output=$(scripts/test-fast.sh 2>&1); then
  echo "Fast tests failed. Fix them before finishing, or explain why they cannot pass:" >&2
  echo "$output" | tail -n 60 >&2
  exit 2
fi
exit 0
