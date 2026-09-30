# Sources and provenance

Every pattern this plugin borrows is recorded here with the repository, the exact commit
read, its license, and what was taken. Fetched 2026-09-30. Clones live in `research/raw/`
(gitignored) and are never shipped.

**Audit rule:** every script in a fetched repository is read before any of its text is
read into the plugin. No fetched script is ever executed.

SKILL.md audit (2026-09-30): gerardogdonoso `SKILL.md` read lines 1–582 in full and
583–757 by heading; takusaotome `skills/business-analyst/SKILL.md` scanned by heading and
for run instructions, plus the headings of its BRD template and BABOK reference. Run
instructions found: takusaotome tells the agent to run `python scripts/business_analysis.py`
(the audited local calculator); gerardogdonoso references `python tools/cazador-obsoletos.py`,
a tool that is not in the repository. Neither instruction was copied into this plugin, and
this plugin ships no scripts outside `tests/`.

## Repositories

| Repo | Commit | License | Scripts audited | What this plugin takes |
|---|---|---|---|---|
| https://github.com/gerardogdonoso/brd-business-analyst | 5b7c826dc4c65a0712a0608d1cfcc07f1ea1740d | MIT | scripts: 0, executed: 0 | Adapted and translated from Spanish: stage flow (land → explore → consolidate), auto-detected mode, gap map before questions, max 3 questions per turn, status tags (`[CONFIRMADO]/[SUPUESTO]/[DERIVADO]/[INVESTIGADO]` → `[CONFIRMED]/[ASSUMPTION]/[DERIVED: IDs]/[RESEARCHED]`), the "I don't know → research or orient" protocol, "verifiable = answered yes/no by a record or event", "every number with a unit declares its source", "an acceptance criterion verifies a rule and never legislates one", vague-word classes (subjective, loophole, comparative, open-ended, absolute, ambiguous enumeration scope), one requirement = one rule. |
| https://github.com/takusaotome/claude-skills-library (path `skills/business-analyst`) | 0fe30cb1a61ed55604b7df2e01f1d6fa281d258b | MIT | scripts: 1 (`scripts/business_analysis.py` — local numpy/pandas ROI/NPV calculator, no network, no subprocess), executed: 0 | Adapted: BABOK v3 structure, BRD section order (document control, problem/opportunity, objectives + KPI, scope, stakeholder register, as-is with pain points and root cause, to-be with gap analysis, business rules, integration, risks, implementation and training, acceptance, glossary, traceability appendix). |
| https://github.com/jdm4pku/RE-Skills | 8229afd8da1e8836e5f2ba29049e69165700e8c6 | none stated | scripts: 0, executed: 0 | **Ideas only, no text copied** (no license grants reuse): EARS as the requirement-statement form, 29148 review checklist as a gate, MoSCoW, requirements traceability as a separate artifact. |

Research base (landscape, options compared, recommended structure):
`research/landscape-2026-09-30.md` — the user's research document, saved verbatim.

## Standards (summarised in own words, never quoted at length)

| Standard | Status as of 2026-09-30 | Used for |
|---|---|---|
| IIBA BABOK Guide v3 | Current | Requirement classes (business, stakeholder, solution, transition) and the trace chain |
| ISO/IEC/IEEE 29148:2018 | Confirmed 2024; stage 90.92 "to be revised"; successor DIS 29148 at stage 40.00 — watch for a new edition | The 7 requirement characteristics, set-level checks, BRS/StRS/SRS information items |
| EARS (Easy Approach to Requirements Syntax, Mavin et al.) | Public method | Requirement statement templates |
| ISO/IEC 25010 | Current | NFR quality categories |
| UU No. 27 Tahun 2022 (Pelindungan Data Pribadi) | In force | Compliance prompt when personal data is processed |

## Not used

| Source | Why not |
|---|---|
| deanpeters/Product-Manager-Skills | CC BY-NC-SA 4.0 — non-commercial; BRDs here are paid deliverables |
| Anthropic `product-management`, BMAD, Spec Kit | PRD/spec-centric; named as downstream tools in the router, not borrowed from |
| Unverified repos (BASkill-Claude, doc-brd, brd by cwijayasundara) | Not verified on GitHub at research time |
