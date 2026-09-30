# Requirement classification (BABOK v3) and the trace chain

Summarised in own words from the IIBA BABOK Guide v3 and ISO/IEC/IEEE 29148:2018.
Loaded by `brd-draft` (to assign IDs) and `brd-gate` (to check the chain).

## The four classes

| Class | Answers | Lives while | ID prefix in this plugin |
|---|---|---|---|
| **Business** | Why the organisation is doing this: goals, objectives, measurable outcomes | The whole initiative | `BR-` |
| **Stakeholder** | What a named stakeholder group needs in order for the business requirement to be met | The whole initiative | `SR-` |
| **Solution — functional** | What the solution must do (behaviour, data it handles, rules it applies) | The solution's life | `FR-` |
| **Solution — non-functional** | How well it must do it: performance, availability, security, usability, compliance — each with a measurable bound | The solution's life | `NFR-` |
| **Transition** | What must happen once to move from the current state to the future state: data migration, training, cut-over, parallel run, hypercare | Only until go-live plus hypercare | `TR-` |

Two supporting families sit beside the classes:

| Family | What it is | ID prefix |
|---|---|---|
| Business rule | A policy or constraint the business already applies, independent of any system (e.g. "a batch is rejected when more than 3% of parts are short-shot") | `RULE-` |
| Data & integration | A data object, source of record, or interface to another system, named only as the user named it | `DI-` |

## The trace chain

```text
Business need (section 2) → BR → SR → FR / NFR → acceptance criterion (Given/When/Then)
                                   ↘ RULE, DI, TR point to the BR or SR they serve
```

Rules the gate enforces:

1. Every `SR-` names at least one parent `BR-`.
2. Every `FR-` and `NFR-` names at least one parent `SR-` or `BR-`.
3. Every `BR-` has at least one child. A BR with no child is a promise with no delivery.
4. Every `FR-` with priority Must has at least one acceptance criterion.
5. A requirement with no parent is an **orphan** and is BLOCKING: either it serves a need
   nobody wrote down (write the need) or it is scope creep (remove it).
6. `RULE-`, `DI-`, `TR-` each name the `BR-` or `SR-` they serve.

## IDs

- Three digits, zero-padded: `BR-001`. Never reused, even after deletion — a deleted ID
  stays in the version history with the reason.
- Assigned by whoever writes the requirement into `brd.md`, in order of writing.
- A requirement that turns out to be in the wrong class is not renumbered in place: it is
  withdrawn (history row) and re-created with a new ID in the right class.

## What a BRD is, in 29148 terms

ISO/IEC/IEEE 29148 names four information items: BRS (business requirements
specification), StRS (stakeholder), SyRS (system), SRS (software). A BRD as this plugin
writes it covers **BRS + StRS**, plus high-level solution requirements and transition
requirements so the client can sign scope and price against it. The SRS and technical
design are downstream work and are out of scope: a BRD states *what* is needed, never
*how* it is built (no stack, no database schema, no architecture).
