# gaspol-brdwriter — plugin rules (for Claude)

Writes client-signable Business Requirements Documents (BRD): requirements per
BABOK v3 / ISO/IEC/IEEE 29148 **plus** a commercial section (package, price,
payment terms tied to milestones, acceptance, sign-off). Design:
`docs/plans/2026-09-30-BRW-1-gaspol-brdwriter-spec.md`.

## Skills and what each reads

| Skill | Reads | Writes |
|---|---|---|
| `gaspol-brdwriter` (router) | run files in the working folder | nothing |
| `brd-interview` | `references/domain-questions.md`, `references/babok-classification.md`, `references/commercial-section.md`; user's knowledge base (optional) | `brief.md` |
| `brd-draft` | `brief.md`, `templates/*`, `references/babok-classification.md`, `ears-patterns.md`, `ambiguity-words.md`, `commercial-section.md` | `brd.md` |
| `brd-gate` | `brd.md`, `references/ieee29148-checklist.md`, `ambiguity-words.md`, `babok-classification.md`, `commercial-section.md`, `templates/traceability-matrix.md` | `review.md` |
| `brd-finish` | `brd.md`, `review.md`; skill `anthropic-skills:docx` | `BRD-<CODE>-<NNN>.docx`, knowledge-base notes |

## Contracts that tests enforce

- The 23 headings of `templates/brd-template.md` (`## 0.` … `## 22.`) are a contract with
  `brd-gate`. Renaming one breaks `tests/refs-present.sh` on purpose.
- `references/examples/bad-brd.md` keeps four planted defects (untagged price, NFR "cepat"
  with no bound, FR with no parent, terms summing to 90%). Never fix them;
  `tests/fixture-shape.sh` guards them.
- `research/sources.md` pins every borrowed repo to a commit SHA with its license.
  RE-Skills has no license: ideas only, never text.

## Tests

`bash tests/run-all.sh` — bash + grep + awk. A missing script is RED. Must print
`ALL GREEN` before any commit that touches `skills/`, `references/`, or `templates/`.

## gaspol Ticket Counter

Prefix: BRW
Last ticket: BRW-1
