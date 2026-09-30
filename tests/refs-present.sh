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

# --- Phase C: references ------------------------------------------------------------
for f in babok-classification.md ieee29148-checklist.md ears-patterns.md \
         ambiguity-words.md commercial-section.md domain-questions.md; do
  p="references/$f"
  if [ ! -f "$p" ]; then echo "MISSING ref: $p"; fail=1; continue; fi
  n=$(wc -l < "$p")
  [ "$n" -ge 20 ] || { echo "TOO THIN: $p ($n lines, minimum 20)"; fail=1; }
done
A=references/ambiguity-words.md
if [ -f "$A" ]; then
  for h in "## Indonesian" "## English"; do
    grep -qxF "$h" "$A" || { echo "MISSING heading in $A: $h"; fail=1; }
  done
fi
I=references/ieee29148-checklist.md
if [ -f "$I" ]; then
  for w in necessary unambiguous complete consistent verifiable feasible traceable; do
    grep -qiw "$w" "$I" || { echo "MISSING characteristic in $I: $w"; fail=1; }
  done
fi
C=references/commercial-section.md
if [ -f "$C" ]; then
  grep -qF '100%' "$C" || { echo "MISSING in $C: 100%"; fail=1; }
  grep -qi 'milestone' "$C" || { echo "MISSING in $C: milestone"; fail=1; }
fi

# --- Phase D: templates --------------------------------------------------------------
TPL=templates/brd-template.md
if [ ! -f "$TPL" ]; then
  echo "MISSING template: $TPL"; fail=1
else
  while IFS= read -r h; do
    grep -qxF "$h" "$TPL" || { echo "MISSING heading in brd-template: $h"; fail=1; }
  done <<'HEADINGS'
## 0. Kendali Dokumen
## 1. Ringkasan Eksekutif
## 2. Latar Belakang & Masalah
## 3. Tujuan Bisnis & KPI
## 4. Lingkup
## 5. Stakeholder & RACI
## 6. Proses As-Is & To-Be
## 7. Business Requirements
## 8. Stakeholder Requirements
## 9. Functional Requirements
## 10. Non-Functional Requirements
## 11. Business Rules
## 12. Data & Integrasi
## 13. Transition Requirements
## 14. Asumsi, Batasan & Dependensi
## 15. Risiko
## 16. Kepatuhan
## 17. Kriteria Penerimaan
## 18. Komersial
## 19. Matriks Keterlusuran
## 20. Glosarium
## 21. Pertanyaan Terbuka
## 22. Persetujuan
HEADINGS
fi
TM=templates/traceability-matrix.md
if [ ! -f "$TM" ]; then
  echo "MISSING template: $TM"; fail=1
else
  grep -qF '| BR | SR | FR/NFR | RULE | TR | Test/AC |' "$TM" \
    || { echo "MISSING header row in $TM"; fail=1; }
fi

[ "$fail" -eq 0 ] && echo "refs OK"
exit "$fail"
