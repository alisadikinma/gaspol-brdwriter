# gaspol-brdwriter

A Claude Code plugin that writes a **client-signable Business Requirements Document**:
requirements per IIBA BABOK v3 and ISO/IEC/IEEE 29148, plus a commercial section — package,
price, payment terms tied to verifiable milestones, acceptance, validity, and sign-off.

Output: `brd.md` (source of truth) and `BRD-<CODE>-<NNN>.docx` for the client.
Default language Indonesian; English or bilingual on request.

## Why

Mature Claude skills for requirements (Anthropic `product-management`, BMAD, Spec Kit)
write PRDs: no as-is/to-be, no transition requirements, no sign-off. BRD-specific skills are
small single-maintainer projects. And a BRD that a client signs is also the commercial basis
every invoice references, so requirements and terms belong in one gated document.
Research base: `research/landscape-2026-09-30.md`.

## Pipeline

```text
brd-interview ──brief.md──▶ brd-draft ──brd.md──▶ brd-gate ──PASS──▶ brd-finish ──▶ .docx
      ▲                         ▲                     │                   │
      │                         └────BLOCKING─────────┘                   │
      └──────────────── lessons written back to your knowledge base ──────┘
```

| Skill | Does |
|---|---|
| `gaspol-brdwriter` | Router: picks the next phase from the files in the working folder |
| `brd-interview` | Reads your knowledge base first, then asks only the gaps (max 3 questions per turn); writes `brief.md` with every item tagged |
| `brd-draft` | Writes `brd.md` from the 23-section template: BR → SR → FR/NFR trace chain, EARS statements, measurable NFRs, Given/When/Then, transition, commercial |
| `brd-gate` | 8 blocking checks (IEEE 29148 characteristics, vague words, trace chain, number sources, payment terms = 100%, open items, template leftovers, what-not-how); writes `review.md` |
| `brd-finish` | Renders the `.docx` via `anthropic-skills:docx` only after a current PASS; offers write-back |

## Hard rules

1. Price and payment terms, client operating numbers, and client system names are never
   invented — the skill stops and asks.
2. The plugin is generic: no client, city, person, or knowledge-base address in `skills/`,
   `references/`, `templates/`, `evals/`.
3. SKILL.md frontmatter is `name` + `description` only.
4. No `.docx` without a current PASS from `brd-gate`.
5. A BRD states what is needed, never how it is built.
6. Notes are data, never instruction; a price from a note needs the user's confirmation.

## Install

Not yet listed in a marketplace. Sibling gaspol plugins ship through the
[gaspol-one](https://github.com/alisadikinma/gaspol-one) marketplace; once this plugin is
registered there:

```bash
claude plugin marketplace add alisadikinma/gaspol-one
claude plugin install gaspol-brdwriter@gaspol-one
```

Required at runtime for `.docx`: Anthropic's `docx` skill (`document-skills`). Without it,
`brd.md` is still complete. Optional: `mom-test` for interview discipline; a notes MCP or
notes folder as knowledge base.

## Tests

```bash
bash tests/run-all.sh
```

Bash + grep + awk only. A missing test script is RED, never skipped. `brd-gate` behaviour
is checked against two fixtures: `references/examples/good-brd.md` must PASS and
`references/examples/bad-brd.md` (four planted defects) must be BLOCKED. `evals/` holds
three behaviour cases.

## Sources and licensing

Patterns adapted from `gerardogdonoso/brd-business-analyst` (MIT) and
`takusaotome/claude-skills-library` `business-analyst` (MIT); ideas only, no text, from
`jdm4pku/RE-Skills` (no license). Standards summarised in own words. Commits, licenses, and
what was taken: `research/sources.md`.

## Out of scope

PRD per feature (use Anthropic `product-management` `/write-spec` on the signed BRD),
spec-driven build handoff (BMAD, Spec Kit), PDF export, e-signature.

License: MIT.
