#!/usr/bin/env bash
# Every plugin file a SKILL.md names must be written relative to the skill's own folder
# (../../references/..., ../../templates/...). An installed skill runs with the USER's
# project as working directory, so a bare "references/x.md" resolves to a file that does
# not exist there — and a model that cannot find a rubric tends to improvise one.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
fail=0; n=0

for f in skills/*/SKILL.md; do
  d=$(dirname "$f")
  # bare plugin paths (not preceded by ../../) are forbidden
  bare=$(grep -noE '(^|[^./])(references|templates)/[A-Za-z0-9_./-]+\.md' "$f" || true)
  if [ -n "$bare" ]; then
    echo "$f: plugin path not relative to the skill folder (use ../../):"
    printf '%s\n' "$bare"; fail=1
  fi
  # every ../../ path must exist
  for p in $(grep -oE '\.\./\.\./(references|templates)/[A-Za-z0-9_./-]+\.md' "$f" | sort -u); do
    n=$((n + 1))
    [ -f "$d/$p" ] || { echo "$f: broken path $p"; fail=1; }
  done
done

[ "$n" -gt 0 ] || { echo "refs-resolve: zero ../../ paths found"; fail=1; }
[ "$fail" -eq 0 ] && echo "refs resolve OK — $n paths"
exit "$fail"
