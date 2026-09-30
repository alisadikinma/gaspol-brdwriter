#!/usr/bin/env bash
# BRW-1 — each skill must carry its contract. A grep per promise the spec makes, so a
# rewrite that drops a rule turns RED instead of shipping quietly.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
fail=0

# need <skill> <literal>... — every literal must appear in skills/<skill>/SKILL.md
need() {
  local s="$1"; shift
  local f="skills/$s/SKILL.md"
  [ -f "$f" ] || { echo "MISSING skill: $f"; fail=1; return; }
  for lit in "$@"; do
    grep -qiF -- "$lit" "$f" || { echo "$f: missing '$lit'"; fail=1; }
  done
}

# --- Phase F -------------------------------------------------------------------------
need gaspol-brdwriter 'brief.md' 'brd.md' 'review.md' 'brd-interview' 'brd-draft' \
  'brd-gate' 'brd-finish'
need brd-interview 'max 3 questions' '[CONFIRMED]' '[ASSUMPTION]' '[OPEN]' '[from:' \
  'brief.md' 'UU PDP' 'Step 0' 'domain-questions.md' 'playbook'

# --- Phase G -------------------------------------------------------------------------
need brd-draft 'refuse' 'brief.md' 'BR-' 'SR-' 'FR-' 'NFR-' 'RULE-' 'TR-' 'DI-' 'Given' \
  'MoSCoW' '[src:' 'commercial-section.md' 'traceability-matrix.md' '100%'

# --- Phase H -------------------------------------------------------------------------
need brd-gate 'PASS' 'BLOCKING' 'review.md' 'ieee29148-checklist.md' 'ambiguity-words.md' \
  '100%' '[src:' '[OPEN]' '{{' 'orphan'

# --- Phase I -------------------------------------------------------------------------
need brd-finish 'PASS' 'refuse' 'docx' 'BRD-' 'cover' 'Persetujuan' 'write-back'

# --- Phase J: evals -------------------------------------------------------------------
for e in evals/01-vague-idea.md evals/02-enhancement.md evals/03-iot-integration.md; do
  if [ ! -f "$e" ]; then echo "MISSING eval: $e"; fail=1; continue; fi
  for h in '## Prompt' '## Expected behaviour' '## Must not'; do
    grep -qxF "$h" "$e" || { echo "$e: missing heading '$h'"; fail=1; }
  done
done

[ "$fail" -eq 0 ] && echo "skill content OK"
exit "$fail"
