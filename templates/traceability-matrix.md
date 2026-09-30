# Traceability matrix

Copied into section 19 of `brd.md` by `brd-draft`; checked by `brd-gate`. One row per
leaf requirement. A cell with more than one ID lists them comma-separated.

| BR | SR | FR/NFR | RULE | TR | Test/AC |
|---|---|---|---|---|---|
| BR-001 | SR-001 | FR-001, FR-002 | RULE-001 | — | AC-001, AC-002 |
| BR-001 | SR-002 | NFR-001 | — | — | AC-003 |
| BR-002 | SR-003 | FR-003 | — | TR-001 | AC-004 |

Worked example (fictional — PT Sinar Contoh Abadi, OEE dashboard): `BR-001` "Naikkan OEE
lini molding" → `SR-001` "Supervisor perlu tahu mesin berhenti saat itu juga" →
`FR-001` "Ketika mesin berhenti > 10 menit, sistem harus mengirim notifikasi ke supervisor
shift" → `AC-001` Given/When/Then that proves it.

## Rules

1. Every `FR-` and `NFR-` appears in a row that names its `SR-` or `BR-` parent.
2. Every `BR-` appears in at least one row with a child. A BR with no child is BLOCKING.
3. A requirement with no parent is an **orphan** and is BLOCKING.
4. Every Must `FR-` reaches at least one `AC-` in the last column.
5. `—` means "none for this row", never "unknown". Unknown is `[OPEN]` and blocks signing.
6. The matrix shows where each item traces; it does not prove the item is verified. The
   gate still reads each acceptance criterion against its requirement.
