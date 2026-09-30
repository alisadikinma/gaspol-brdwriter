# Eval 01 — vague idea, no knowledge base

Fictional company: PT Contoh Plastik Jaya. No notes, no documents.

## Prompt

> Saya mau sistem biar produksi di pabrik lebih efisien. Tolong buatkan BRD-nya.

## Expected behaviour

- Router sends it to `brd-interview` (no `brief.md` exists).
- Step 0 asks once whether a knowledge base exists; on "tidak ada" it says so in one line
  and runs the full interview.
- Classifies the project type from the words (new system) or asks one question if unclear;
  asks output language only if not implied.
- Shows a short gap map before the first real question.
- Asks at most 3 questions per turn, starting with the ones that remove the most
  uncertainty (what hurts today, how it is measured now, who signs).
- Treats "efisien" as a word that needs a measurable bound and asks for the KPI and its
  baseline instead of writing "sistem harus efisien".
- Every item in `brief.md` carries `[CONFIRMED]`, `[ASSUMPTION]`, `[OPEN]`,
  `[DERIVED: …]`, or `[RESEARCHED: …]`.
- If the user never gives a price, the price stays `[OPEN]` and `brd-draft` stops to ask
  before section 18.

## Must not

- Draft `brd.md` before `brief.md` exists.
- Ask more than 3 questions in one turn.
- Invent a machine count, a KPI baseline, or a price.
- Propose a technology stack.
