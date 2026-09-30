---
name: brd-draft
description: Second phase of gaspol-brdwriter. Use after brd-interview has produced brief.md, or after brd-gate returned BLOCKING, to write or revise brd.md — tulis BRD dari brief, susun draft BRD, perbaiki BRD setelah review. Fills the 23-section template with a full trace chain (BR → SR → FR/NFR), EARS statements, measurable NFRs, Given/When/Then acceptance criteria, transition requirements, and a commercial section whose payment terms sum to 100% and are tied to verifiable milestones. Refuses to start without brief.md and stops rather than inventing a price, a client figure, or a system name.
---

# brd-draft

> The draft can only be as true as the brief. Anything the brief does not hold is a
> question, not a sentence.

**Announce at start:**
> "I'm using brd-draft. I'll write brd.md from brief.md, every number tagged with its source, then hand it to brd-gate."

## Entry gate

- No `brief.md` in the working folder → **refuse**. Say so in one line and route to
  `brd-interview`. Do not draft from the chat history instead: a BRD written before the
  interview invents the client's problem, and the gate cannot catch a right-looking answer
  to a question nobody asked.
- `brief.md` has an `[OPEN]` price, payment term, or offer validity → STOP and ask before
  writing section 18. If the user still cannot answer, write the item `[OPEN]` and warn
  that the gate will block.
- `brief.md` contradicts itself → list the contradiction, ask, and do not choose a side.

## Inputs

| File | Use |
|---|---|
| `brief.md` | The only source of facts. Cite items as `[src: brief Q7]`. |
| `templates/brd-template.md` | Section structure. Keep every heading, in order. |
| `templates/traceability-matrix.md` | Section 19. |
| `references/babok-classification.md` | Classes, ID prefixes, trace rules. |
| `references/ears-patterns.md` | Statement forms, modal verbs, MoSCoW, measurable NFR, Given/When/Then. |
| `references/ambiguity-words.md` | Words to avoid, or bound in the same row. |
| `references/commercial-section.md` | Section 18 structure and rules. |
| `references/examples/good-brd.md` | What a passing BRD looks like. |

## Writing rules

**Structure.** Write `brd.md` from `templates/brd-template.md`. Keep all 23 headings
(`## 0.` to `## 22.`) in order. Replace every `{{slot}}`; a slot the brief cannot fill
becomes an `[OPEN]` item, never a guess. A section that genuinely does not apply gets one
line: `Tidak berlaku — <alasan>`. Drop the template's HTML comments.

**Language.** As chosen in `brief.md`: Indonesian (default), English (use the EN gloss
from each heading comment), or bilingual (heading `Indonesian / English`; each requirement
statement in Indonesian with the English line beneath it). FR, NFR, MoSCoW, Given/When/Then,
RACI, KPI, UAT stay in English.

**IDs and trace chain** (`references/babok-classification.md`):

- `BR-` business → `SR-` stakeholder → `FR-` functional / `NFR-` non-functional.
- `RULE-` business rule, `DI-` data & integration, `TR-` transition — each names the `BR-`
  or `SR-` it serves.
- Three digits, zero-padded, never reused.
- Every `SR-` names a parent `BR-`. Every `FR-`/`NFR-` names a parent `SR-` or `BR-`.
  Every `BR-` has at least one child. No orphans.

**Statements** (`references/ears-patterns.md`):

- Every `FR-` is one EARS sentence with one behaviour. Split anything joined by "dan/atau".
- Every `NFR-` names metric, threshold, unit, and measuring condition, with `[src: …]`.
  A brief with no NFR facts → ask for performance, availability, security, and retention
  bounds; never write "none" and never pick numbers.
- Priority in MoSCoW; the modal verb matches it (harus = Must, sebaiknya = Should,
  boleh = Could).
- Name the actor. No sentence without a subject ("data divalidasi" → by whom?).
- No word from `references/ambiguity-words.md` without a measurable bound in the same row.

**Acceptance criteria (section 17).** At least one `Given / When / Then` per Must `FR-`,
with concrete data in Given and one event in When. A criterion verifies a requirement; it
never adds a decision no requirement states.

**Sources.** Every price, tax rate, KPI baseline and target, threshold, and client
operating figure carries `[src: brief Qn]` (or `[from: <note>]` when the brief carried it
that way). A number without a tag is treated by the gate as invented.

**Data & integration (section 12).** System names exactly as the user stated them in the
brief. A system the brief does not name is `[OPEN]`, never "ERP" filled with a guessed
product.

**Transition (section 13).** Cover data migration, training, cut-over (including any
parallel run), and hypercare — each `TR-` with its bound and source, or `Tidak berlaku —
<alasan>`.

**Commercial (section 18)** per `references/commercial-section.md`:

- Package & scope lists the `BR-` IDs covered and the out-of-scope items.
- Price with currency and tax treatment, tagged `[src:]`. Never a tax rate from memory.
- Payment terms table: each term's % and value, a verifiable milestone, and the document
  that proves it. Percentages sum to exactly **100%**. Value = % × price.
- Acceptance (UAT window, who signs, blocking severities, deemed acceptance only if the
  user agreed), change requests, warranty and hypercare, offer validity date.
- Only `[CONFIRMED]` brief items go here. Anything else → STOP and ask.

**Traceability (section 19).** Fill from `templates/traceability-matrix.md`: one row per
leaf requirement, every Must `FR-` reaching an `AC-`.

**What, not how.** No stack, framework, database, table, API design, or architecture.
If the brief contains design decisions, keep only the need behind them.

**Open questions (section 21).** The only section where `[OPEN]` may remain at signing,
because each item there is explicitly not a commitment.

## Revising after BLOCKING

When `review.md` says `**Verdict:** BLOCKING`:

1. Fix only the items on its fix list. Do not rewrite passing sections.
2. A fix that needs a fact the brief lacks → ask the user; update `brief.md` with the
   answer as a new `Q` item, then cite it.
3. Bump the version in section 0 and add a history row: date, what changed, affected IDs,
   and "review round <n>".
4. Hand back to `brd-gate`. The old `review.md` is now stale by file time.

## Close

Report: sections written, count of requirements per class, count of `[OPEN]` items and
where they sit. Then hand off to `brd-gate`. Never present the draft to the client first.
