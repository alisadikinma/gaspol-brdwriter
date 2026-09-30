#!/usr/bin/env bash
# BRW-1 Phase E — the bad fixture MUST keep its four planted defects; the good fixture
# MUST stay clean of them. brd-gate is judged against these two files, so a "fixed" bad
# fixture silently turns the gate's test into a pass.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
B=references/examples/bad-brd.md
G=references/examples/good-brd.md
fail=0

for f in "$B" "$G"; do
  [ -f "$f" ] || { echo "MISSING fixture: $f"; fail=1; }
done
[ "$fail" -eq 1 ] && exit 1

# Sum of the % column over payment-term rows (| T1 | 30% | ...) inside section 18.
termin_sum() {
  awk -F'|' '/^## 18\./{s=1;next} /^## 19\./{s=0} s && $2 ~ /^ *T[0-9]+ *$/ {
      v=$3; gsub(/[ %]/,"",v); gsub(/,/,".",v); t+=v } END{ printf "%g", t+0 }' "$1"
}
# Price lines (Rp followed by digits) that carry no [src: tag.
untagged_price() { grep -E 'Rp[ .]?[0-9]' "$1" | grep -vF '[src:' || true; }
# NFR rows using "cepat" with no digit once requirement IDs are stripped.
vague_nfr() {
  awk '/^\| NFR-[0-9]+/ && tolower($0) ~ /cepat/ { l=$0; gsub(/[A-Z]+-[0-9]+/,"",l);
       if (l !~ /[0-9]/) print }' "$1"
}
# FR/NFR rows whose parent cell (column 2) is empty or a dash.
orphan_rows() { grep -E '^\| (FR|NFR)-[0-9]+ \| *(-|—)? *\|' "$1" || true; }

# --- bad fixture: four planted defects must be present ------------------------------
[ -n "$(untagged_price "$B")" ] || { echo "bad fixture kehilangan cacat: harga tanpa [src:]"; fail=1; }
[ -n "$(vague_nfr "$B")" ]      || { echo "bad fixture kehilangan cacat: NFR 'cepat' tanpa angka"; fail=1; }
[ -n "$(orphan_rows "$B")" ]    || { echo "bad fixture kehilangan cacat: FR tanpa induk"; fail=1; }
[ "$(termin_sum "$B")" = "90" ] || { echo "bad fixture kehilangan cacat: termin harus total 90%, ada $(termin_sum "$B")%"; fail=1; }

# --- good fixture: clean of all four, and signable -----------------------------------
[ -z "$(untagged_price "$G")" ] || { echo "good fixture: harga tanpa [src:]:"; untagged_price "$G"; fail=1; }
[ -z "$(vague_nfr "$G")" ]      || { echo "good fixture: NFR 'cepat' tanpa angka"; fail=1; }
[ -z "$(orphan_rows "$G")" ]    || { echo "good fixture: FR/NFR tanpa induk:"; orphan_rows "$G"; fail=1; }
[ "$(termin_sum "$G")" = "100" ] || { echo "good fixture: termin total $(termin_sum "$G")%, harus 100%"; fail=1; }
grep -qF '{{' "$G" && { echo "good fixture: slot {{ tersisa"; fail=1; }
open_outside=$(awk '/^## 21\./{s=1;next} /^## 22\./{s=0} !s && /\[OPEN\]/' "$G")
[ -z "$open_outside" ] || { echo "good fixture: [OPEN] di luar bagian 21:"; echo "$open_outside"; fail=1; }

[ "$fail" -eq 0 ] && echo "fixture shape OK"
exit "$fail"
