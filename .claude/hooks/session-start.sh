#!/bin/bash
# Install project dependencies at session start.
# Stack-agnostic: delegates to scripts/install.sh, which each repo fills in.
cd "$CLAUDE_PROJECT_DIR" || exit 0
if [ -x scripts/install.sh ]; then
  scripts/install.sh >&2 || echo "scripts/install.sh failed; continuing" >&2
fi
exit 0
