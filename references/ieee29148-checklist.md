# Requirement quality checklist (ISO/IEC/IEEE 29148:2018)

Summarised in own words. Loaded by `brd-gate`. Run against **every** requirement row
(`BR-`, `SR-`, `FR-`, `NFR-`, `RULE-`, `TR-`, `DI-`), then against the set as a whole.

## Per requirement — the 7 characteristics

| # | Characteristic | Test question | Failing example (ID) | Fixed |
|---|---|---|---|---|
| 1 | **Necessary** | Does removing it leave a parent need unmet? If not, why is it here? | `FR-012 Sistem menampilkan animasi logo saat login.` (no parent) | Remove, or write the need it serves |
| 2 | **Unambiguous** | Can two readers build two different things from it? | `NFR-002 Dashboard harus cepat.` | `NFR-002 Ketika supervisor membuka dashboard OEE, sistem harus menampilkan data shift berjalan dalam ≤ 3 detik (p95).` |
| 3 | **Complete** | Does it state actor, condition, behaviour, and bound — with no "TBD"? | `FR-020 Sistem mengirim notifikasi.` (to whom, when?) | `FR-020 Ketika mesin berhenti > 10 menit, sistem harus mengirim notifikasi ke supervisor shift.` |
| 4 | **Consistent** | Does it contradict another requirement, a rule, or the scope? | FR says "per shift", RULE says "per hari" for the same report | Pick one with the user; fix both rows |
| 5 | **Verifiable** | **With which record or event is it answered yes/no?** Not "how would we know" — a judgement is not a verification | `FR-030 Operator puas dengan tampilan.` | Replace with an observable event, or declare it prompt-only and hang no contractual consequence on it |
| 6 | **Feasible** | Can it be met within the stated constraints (budget, time, systems the user named)? | Real-time sync with a system the user said exports only a daily file | Bound it to what the named system allows, or raise it as a risk |
| 7 | **Traceable** | Does it name its parent, and does its parent name it? | `FR-009` parent `-` | Name the SR/BR it serves |

Additional per-requirement checks (29148 "singular" and "implementation-free"):

- **Singular** — one requirement, one rule. Split any row joined by "dan/atau", "and/or",
  or a list of behaviours. A compound requirement gets one test that covers two behaviours
  and leaves a third invisible.
- **Implementation-free** — no stack, framework, database, table, or architecture. A BRD
  states what, never how.
- **Every number with a unit declares its source** — `[src: …]` or `[from: …]`. A legal
  figure (retention period, tax rate, notice period) cites the regulation and article, from
  the official text, never from a summary or another jurisdiction.

## Across the set

| Check | What fails it |
|---|---|
| Complete | A section of the template is empty with no `[OPEN]` item explaining why |
| Consistent | Same term used for two things, or two terms for one thing — add a glossary line |
| Feasible | Sum of Must requirements exceeds the time or budget the user stated |
| Comprehensible | A reader outside the project cannot follow it without the author present |
| Able to be validated | The sponsor can read the business requirements and say "yes, this is what we want" |
| Bounded | Scope in and out are both written; out-of-scope is not empty |

## Acceptance criteria

- Form: `Given <state with concrete data> When <event> Then <observable result>`.
- An acceptance criterion **verifies** a requirement; it never introduces a decision no
  requirement states (a new metric, a new notice, a new charge). If the Then-clause cannot
  be traced to a requirement's text, either raise the decision into a requirement or cut
  the criterion.
- Keep the event (When) separate from the state (Given). "When the agent detects
  hostility" hides a model judgement inside an event and cannot be checked.
