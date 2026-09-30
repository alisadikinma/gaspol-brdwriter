#!/usr/bin/env bash
# BRW-1 — provenance, references, and templates the skills load must exist and carry
# their contract. Each block names the phase that owns it.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
fail=0

# --- Phase B: research provenance -------------------------------------------------
S=research/sources.md
if [ ! -f "$S" ]; then
  echo "MISSING: $S"; fail=1
else
  for repo in gerardogdonoso/brd-business-analyst takusaotome/claude-skills-library \
              jdm4pku/RE-Skills; do
    line=$(grep -F "$repo" "$S" | grep -E '[0-9a-f]{40}' | head -1)
    [ -n "$line" ] || { echo "UNPINNED: $repo has no 40-hex commit SHA in $S"; fail=1; continue; }
    printf '%s\n' "$line" | grep -qE 'MIT|none stated' \
      || { echo "NO LICENSE: $repo row lacks 'MIT' or 'none stated'"; fail=1; }
  done
fi
[ -f research/landscape-2026-09-30.md ] || { echo "MISSING: research/landscape-2026-09-30.md"; fail=1; }

[ "$fail" -eq 0 ] && echo "refs OK"
exit "$fail"
