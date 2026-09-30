#!/usr/bin/env bash
# BRW-1 — gaspol-brdwriter test gate. Zero dependencies beyond bash + grep + awk.
# A missing script is RED, never a skip: a skipped gate is not a passed gate.
set -uo pipefail
cd "$(dirname "$0")" || exit 1
rc=0
for t in guard-generic.sh frontmatter.sh refs-present.sh fixture-shape.sh \
         deps-present.sh skill-content.sh; do
  echo "=== $t"
  [ -f "$t" ] || { echo "MISSING $t"; rc=1; continue; }
  bash "$t" || rc=1
done
[ "$rc" -eq 0 ] && echo "ALL GREEN" || echo "SOME RED"
exit "$rc"
