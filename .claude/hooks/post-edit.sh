#!/bin/bash
# After Claude edits a file: format and lint it.
# Delegates to scripts/format.sh <file>. A non-zero exit there is fed back to Claude.
cd "$CLAUDE_PROJECT_DIR" || exit 0
[ -x scripts/format.sh ] || exit 0

file=$(jq -r '.tool_input.file_path // empty' 2>/dev/null)
[ -n "$file" ] && [ -f "$file" ] || exit 0

if ! output=$(scripts/format.sh "$file" 2>&1); then
  echo "Format/lint failed for $file:" >&2
  echo "$output" | tail -n 40 >&2
  exit 2
fi
exit 0
