#!/usr/bin/env bash
# BRW-1 Phase I — dependencies.
# anthropic-skills:docx is a claude.ai-provided skill with no local file to check, so this
# script cannot see it. What it CAN check is that brd-finish names it and STOPs when it is
# missing — the runtime check lives in the skill. mom-test is optional: absent is reported,
# never a failure.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
fail=0
F=skills/brd-finish/SKILL.md

if [ ! -f "$F" ]; then
  echo "MISSING skill: $F"; fail=1
else
  grep -qF 'anthropic-skills:docx' "$F" || { echo "$F: does not name anthropic-skills:docx"; fail=1; }
  grep -qE 'STOP' "$F" || { echo "$F: no STOP instruction for a missing docx skill"; fail=1; }
fi

if [ -e "$HOME/.claude/skills/mom-test/SKILL.md" ]; then
  echo "optional mom-test: present"
else
  echo "optional mom-test: absent (brd-interview stands alone)"
fi

[ "$fail" -eq 0 ] && echo "deps OK"
exit "$fail"
