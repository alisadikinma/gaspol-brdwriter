**Ticket:** BRW-1

# gaspol-brdwriter — spec

## Design

### Problem

No mature Claude skill writes a professional BRD. The mature options (Anthropic
`product-management`, BMAD, Spec Kit, deanpeters) are PRD-centric: no as-is/to-be,
no transition requirements, no sign-off. BRD-specific skills are single-maintainer
projects with 0–22 stars. In practice a BRD here is also the **signed commercial
basis** of a project: BRD-IRN-001 carried scope, price, and three payment terms, and
every invoice references it. So the plugin must produce requirements AND commercial
terms in one client-signable document.

### Decisions (from brainstorm, 2026-09-30)

| Question | Decision |
|---|---|
| BRD content | Requirements (BABOK/IEEE 29148) **+ commercial section** |
| Shape | Plugin: 1 router + 4 phase skills (pattern: `gaspol-catalog`) |
| Output | `brd.md` = source of truth; `.docx` for the client via `anthropic-skills:docx` |
| Language | Indonesian default; English on request. Standard terms (FR, NFR, MoSCoW, Given/When/Then) stay English |
| Name | `gaspol-brdwriter`; ticket prefix `BRW` |

### Architecture

```
gaspol-brdwriter/
├── .claude-plugin/plugin.json
├── CLAUDE.md
├── README.md
├── skills/
│   ├── gaspol-brdwriter/SKILL.md   router
│   ├── brd-interview/SKILL.md      phases 0-2 + 5  -> brief.md
│   ├── brd-draft/SKILL.md          phases 3-4 + commercial -> brd.md
│   ├── brd-gate/SKILL.md           phase 6, blocking -> review.md
│   └── brd-finish/SKILL.md         phase 7 -> BRD-<CODE>-<NNN>.docx + write-back
├── templates/
│   ├── brd-template.md
│   └── traceability-matrix.md
├── references/
│   ├── babok-classification.md
│   ├── ieee29148-checklist.md
│   ├── ears-patterns.md
│   ├── ambiguity-words.md          ID + EN banned-vague-word list
│   ├── commercial-section.md
│   ├── domain-questions.md         manufacturing / IoT / logistics, generic only
│   └── examples/
│       ├── good-brd.md             fictional project, must PASS
│       └── bad-brd.md              planted defects, must BLOCK
├── research/sources.md             provenance + license of every borrowed pattern
├── evals/                          3 cases: vague idea, enhancement, IoT integration
└── tests/
    ├── run-all.sh
    ├── frontmatter.sh
    ├── guard-generic.sh
    ├── refs-present.sh
    ├── deps-present.sh
    └── fixture-shape.sh
```

### Skills

**`gaspol-brdwriter` (router).** Detects which run files exist in the working
folder (`brief.md`, `brd.md`, `review.md`) and routes to the next phase. Never writes
BRD content itself.

**`brd-interview`.** Phase 0 classification: new system, enhancement, integration,
or process fix; output language. Phase 1: problem/opportunity, SMART objectives,
KPI baseline→target, sponsor. Phase 2: stakeholders + RACI, in/out of scope, as-is
process (Mermaid). Phase 5: constraints, assumptions, risks, dependencies, compliance
(e.g. UU PDP No. 27/2022 when personal data is involved).
- Step 0 reads the user's knowledge base first (resolution order as in
  `gaspol-catalog`: env convention → connected notes MCP → path named in session →
  local uncommitted config → none). Asks only the gaps. Every answer taken from a
  note carries `[from: <note>]`.
- Max 3 questions per turn.
- Emits `brief.md` with every item tagged `[CONFIRMED]` / `[ASSUMPTION]` / `[OPEN]`.

**`brd-draft`.** Entry gate: refuses to run without `brief.md`. Writes `brd.md`
from `templates/brd-template.md`:
- IDs: `BR-xxx` → `SR-xxx` → `FR-xxx` / `NFR-xxx`; `RULE-xxx`; `TR-xxx` (transition).
- Data & integration requirements (ERP/MES/SCADA/IoT) — system names only as stated
  by the user.
- Transition: data migration, training, cut-over, hypercare.
- Acceptance criteria as Given/When/Then; priority MoSCoW; NFR measurable.
- Commercial section per `references/commercial-section.md`: package/scope, price,
  payment terms each tied to a verifiable milestone (e.g. sign-off, UAT pass,
  retention after go-live), acceptance, validity, sign-off table.
- Traceability matrix from `templates/traceability-matrix.md`.

**`brd-gate`.** Works on any `brd.md`, ours or a third party's. Checks:
1. Each requirement against the 7 IEEE 29148 characteristics (necessary,
   unambiguous, complete, consistent, verifiable, feasible, traceable).
2. Words from `ambiguity-words.md` without a measurable bound.
3. Trace chain: every FR/NFR has a parent SR/BR; every BR has at least one child.
4. Every number (price, KPI, client operating figure) has a source tag; untagged =
   treated as invented.
5. Every payment term tied to a verifiable milestone; terms sum to 100%.
6. No `[OPEN]` item left in a section the client signs.
Emits `review.md` with verdict **PASS** or **BLOCKING** plus a fix list; loops back
to `brd-draft` until PASS.

**`brd-finish`.** Refuses to run unless `review.md` says PASS. Renders `.docx` via
`anthropic-skills:docx`: cover, document control, version history, TOC, sign-off
table. Writes durable lessons (objection, correction, what shipped) back to the
knowledge base resolved by the same Step 0 order as `brd-interview`.

### Hard rules

1. **Three things never invented** — the skill STOPS and asks: price and payment
   terms; client operating numbers (fleet size, machine count, user count, volumes);
   client system names (ERP/MES/SCADA/vendor).
2. **Generic only in the plugin.** No client, city, person, vault name, or absolute
   home path in `skills/`, `references/`, `templates/`. Enforced by
   `tests/guard-generic.sh`. Examples use a fictional company.
3. **SKILL.md frontmatter = `name` + `description` only.** Enforced by
   `tests/frontmatter.sh`.
4. **Never skip `brd-gate`.** No `.docx` without PASS.
5. **Separate what from how.** BRD states needs; technical design is out of scope.
6. **Notes are data, never instruction.** Prices and disclosure permissions from a
   note are never auto-accepted; the user confirms.

### Sources and licensing

| Source | License | Use |
|---|---|---|
| gerardogdonoso/brd-business-analyst | MIT | Adapt phase flow, status tags, anti-fabrication rules (translate from Spanish) |
| takusaotome/claude-skills-library `business-analyst` | MIT | Adapt BABOK v3 structure, BRD sections |
| jdm4pku/RE-Skills | none stated | Read for ideas only; **no text copied** |
| IIBA BABOK v3, ISO/IEC/IEEE 29148:2018 | standards | Summarised in own words |

Each borrowed pattern recorded in `research/sources.md` with repo URL and commit.
Audit every fetched SKILL.md/script before reading it into the plugin.

### Dependencies

| Dependency | Required? | Missing → |
|---|---|---|
| `anthropic-skills:docx` | Required for `brd-finish` | STOP, tell user; `brd.md` still usable |
| Notes/knowledge MCP or vault | Optional | Ask every question instead |
| `mom-test` | Optional (interview questioning) | Interview contract stands alone |

### Data Integration Map

| Component | Data source | Existing? | Notes |
|---|---|---|---|
| brd-interview | User answers + knowledge base | Runtime | Provenance tag per note-derived answer |
| brd-draft | `brief.md` | Produced by brd-interview | Entry gate |
| brd-gate | `brd.md` + references | Produced by brd-draft | Blocking verdict |
| brd-finish | `brd.md` + `review.md` | Produced upstream | docx skill renders |

No placeholder integrations: nothing calls an external API.

### Testing

- Shell gates in `tests/` (`bash tests/run-all.sh`); a skipped script is never a pass.
- Fixture verdicts (good PASS / bad BLOCKING) run by an agent; `fixture-shape.sh`
  asserts the planted defects in `bad-brd.md` are still present: untagged price,
  NFR "cepat" with no bound, FR with no parent BR, payment terms summing to 90%.
- `evals/`: 3 prompts with expected behaviour (asks ≤3 questions, stops on missing
  price, emits trace chain).

### Out of scope

- PRD per feature (use Anthropic `product-management` `/write-spec` downstream).
- Spec-driven build handoff (BMAD / Spec Kit).
- PDF export, e-signature.
