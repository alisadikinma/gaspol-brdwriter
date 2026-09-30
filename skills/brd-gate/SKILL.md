---
name: brd-gate
description: The blocking gate of gaspol-brdwriter. Use before any BRD is sent, shown, or signed — ours from brd-draft or one written by someone else — review BRD, cek BRD sebelum dikirim ke klien, audit dokumen kebutuhan bisnis, quality gate requirement. Checks every requirement against the 7 ISO/IEC/IEEE 29148 characteristics, vague words without a measurable bound, the BR → SR → FR/NFR trace chain, a source tag on every number, payment terms tied to verifiable milestones and summing to 100%, and open items in signed sections. Emits review.md with verdict PASS or BLOCKING plus a fix list, and loops back to brd-draft until PASS.
---

# brd-gate

> Paths to plugin files (`../../references/…`, `../../templates/…`) are relative to this
> skill's own folder, not to the working directory.

> The gate is the last reader who can still ask a question. After it, the client reads
> the document alone, and a builder codes whatever reading they happen to choose.

**Announce at start:**
> "I'm using brd-gate. I'll check brd.md against 8 checks and write review.md with PASS or BLOCKING. A BLOCKING verdict goes back to brd-draft; it is never softened."

## Input

- `brd.md` in the working folder, or the BRD file the user names. Missing → refuse.
- Load: `../../references/ieee29148-checklist.md`, `../../references/ambiguity-words.md`,
  `../../references/babok-classification.md`, `../../references/commercial-section.md`,
  `../../templates/traceability-matrix.md`.
- Section numbers below refer to `../../templates/brd-template.md` (`## 0.` to `## 22.`).

**A BRD written elsewhere** may use other IDs and headings. Map its items to the BABOK
classes and to the template sections, report what is missing as findings, and do **not**
rewrite it. Its author owns the fix.

## The 8 checks

Run all eight, every time, in order. Record every finding with the requirement ID (or
section number) and the line it sits on.

1. **IEEE 29148 characteristics.** Every requirement row (`BR-`, `SR-`, `FR-`, `NFR-`,
   `RULE-`, `DI-`, `TR-`) against necessary, unambiguous, complete, consistent,
   verifiable, feasible, traceable — plus singular and implementation-free — using the
   test questions in `../../references/ieee29148-checklist.md`. "Verifiable" means answered
   yes/no by a record or an event, not by someone's judgement. Also check duplicate IDs.
2. **Vague words.** Any word from `../../references/ambiguity-words.md` without a measurable
   bound (number + unit, or a named standard) in the same row. Also: comparatives without
   reference, missing actors, pronouns with two referents, compound requirements.
3. **Trace chain.** Every `SR-` has a parent `BR-`; every `FR-`/`NFR-` has a parent
   `SR-` or `BR-`; every `BR-` has at least one child; every Must `FR-` reaches an `AC-`.
   A requirement whose parent cell is empty, `-`, or names an ID that does not exist is an
   **orphan**. Check section 19 against the rows, not only the rows against section 19.
4. **Every number has a source.** Every price, tax rate, KPI baseline and target,
   threshold, and client operating figure (machines, vehicles, users, volumes) carries
   `[src: …]` or `[from: …]`. An untagged number is treated as invented. Numbers inside
   acceptance-criteria scenarios (section 17) are test data and are exempt.
5. **Payment terms.** In section 18.3, each term has a verifiable milestone (a signed
   document or an observable event) and the document that proves it. The percentages sum
   to exactly **100%** (decimals allowed: 33.3 + 33.3 + 33.4 = 100.0). Retention counts in
   the sum. Each value equals % × price. Offer validity date present (18.7).
6. **No `[OPEN]` in a signed section.** `[OPEN]` may appear only in section 21 (Pertanyaan
   Terbuka). Anywhere else it is a finding. `[ASSUMPTION]` in section 18 is also a finding:
   the client cannot sign an assumed price.
7. **No template leftovers.** Any `{{` remaining in the file.
8. **What, not how.** A requirement that prescribes stack, framework, database, table, API
   design, or architecture.

## Verdict

**BLOCKING** if any of these is true:

- any finding in checks **3, 4, 5, 6, or 7**;
- a duplicate requirement ID (check 1);
- any requirement fails **verifiable** or **unambiguous** (check 1);
- any vague word without a bound in an `NFR-` row or an acceptance criterion (check 2).

Otherwise **PASS**, with the remaining findings listed as advisory.

The verdict is never softened because the user is in a hurry, the client is waiting, or
"it is only a draft". A PASS on a BRD with an invented price is how a signed contract
ends up carrying a number nobody agreed to.

## review.md format

```markdown
**Verdict:** PASS | BLOCKING

**Reviewed:** brd.md version <x.y>, <YYYY-MM-DD>
**Round:** <n>

## Counts

| Check | Findings | Blocking |
|---|---|---|
| 1. IEEE 29148 characteristics | <n> | <n> |
| 2. Vague words | <n> | <n> |
| 3. Trace chain | <n> | <n> |
| 4. Number sources | <n> | <n> |
| 5. Payment terms | <n> | <n> |
| 6. [OPEN] in signed sections | <n> | <n> |
| 7. Template leftovers | <n> | <n> |
| 8. What, not how | <n> | <n> |

## Fix list (blocking)

1. <ID or section> — <check #> — <what is wrong> — <what the fix must do>

## Advisory

- <ID> — <check #> — <note>
```

The first line is always `**Verdict:** …` so the router and `brd-finish` can read it.

## After the verdict

- **BLOCKING** → hand the fix list to `brd-draft`. Re-run this gate on the revised
  `brd.md`; a new `review.md` replaces the old one and the round number goes up.
- **PASS** → hand off to `brd-finish`. If `brd.md` changes after this PASS, the PASS is
  stale and this gate runs again.
- A BLOCKING item that needs a fact only the user has (a price, a figure, a system name)
  is said to the user directly, in one line per item, not buried in the file.

## Self-check before writing review.md

- A finding of **absence** ("the BRD never says X") is reported only after searching the
  whole file, including synonyms.
- A finding of **contradiction** is reported only after confirming both passages talk
  about the same thing — two names for one thing can fake a contradiction.
- Every finding names an ID or a section and a line. A finding nobody can locate cannot be
  fixed.
