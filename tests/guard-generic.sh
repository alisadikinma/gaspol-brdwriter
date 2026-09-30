#!/usr/bin/env bash
# BRW-1 Phase A — skills/, references/, templates/, evals/ may hold GENERIC knowledge only.
# Client names, cities, personal identity, and knowledge-base addresses are runtime input
# (spec hard rule 2). A missing directory is a FAIL, never a silent pass.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1

DIRS="skills references templates evals"
for d in $DIRS; do
  [ -d "$d" ] || { echo "GUARD ERROR: $d/ tidak ada"; exit 1; }
done

# Client names, cities, personal identity.
PAT='indusia|irn[ -]?cargo|brd-irn|indrajaya|yafindo|ekaputra|tranzporter|global pratama|hub71|alisadikin|batam|pekanbaru|makassar'
# shellcheck disable=SC2086
hits=$(grep -rniE "$PAT" $DIRS 2>/dev/null || true)
if [ -n "$hits" ]; then
  echo "GUARD FAIL — client-specific content in $DIRS:"
  echo "$hits"
  exit 1
fi

# Knowledge-base addresses. Skills MAY say "look for a knowledge base"; they MUST NOT
# carry its address. Absolute paths and vault names are runtime input.
ADDR='/Users/|/home/[a-z]|C:\\Users|Drive-D|Obsidian-Vault|obsidian-vault|20-Projects|10-Identity|90-Inbox'
# shellcheck disable=SC2086
addr_hits=$(grep -rniE "$ADDR" $DIRS 2>/dev/null || true)
if [ -n "$addr_hits" ]; then
  echo "GUARD FAIL — hardcoded knowledge-base address (must be runtime input):"
  echo "$addr_hits"
  exit 1
fi

echo "guard OK — $DIRS generic, zero hardcoded addresses"
