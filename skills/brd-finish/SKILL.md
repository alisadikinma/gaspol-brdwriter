---
name: brd-finish
description: Final phase of gaspol-brdwriter. Use once brd-gate has returned PASS to produce the client-ready Word file and close the loop — render BRD ke Word, buat docx BRD, finalisasi BRD untuk tanda tangan klien. Refuses without a current PASS, renders BRD-<CODE>-<NNN>.docx through the anthropic-skills:docx skill with cover, document control, version history, table of contents, and sign-off table, then offers to write the durable lessons back to the user's knowledge base.
---

# brd-finish

> The .docx is what the client signs and every invoice will cite. It is only ever made
> from a brd.md that passed the gate in its current form.

**Announce at start:**
> "I'm using brd-finish. I'll confirm the PASS is current, render the .docx, and then offer to record what we learned."

## Entry gate

Refuse unless **all** hold:

1. `review.md` exists and its first line is `**Verdict:** PASS`.
2. `review.md` is newer than `brd.md` (file modification time). An older PASS is stale:
   route to `brd-gate`.
3. The version in `review.md` ("Reviewed: brd.md version …") matches the version in
   `brd.md` section 0.

`**Verdict:** BLOCKING` → route to `brd-draft` with the fix list. Never render a
BLOCKING BRD "for internal review": files escape.

## Dependency check

This phase needs the skill **`anthropic-skills:docx`**. If it is not available in this
session: **STOP**, tell the user in one line that the Word file cannot be produced here and
how to install the skill (Anthropic `document-skills`), and point out that `brd.md` is
complete and usable as it is. Do not substitute a different converter silently.

## File name

`BRD-<CODE>-<NNN>.docx`

- `<CODE>` — the client or project code. Ask the user; never invent one. Reuse the code in
  `brd.md` ("Nomor dokumen") when present and confirm it.
- `<NNN>` — three digits. Ask the user for the next number, or read it from the knowledge
  base's record of earlier BRDs for this client.
- **Re-issuing a signed BRD** → never overwrite the signed file. Ask whether this is a new
  version of the same number (version bump in section 0) or a new number.

## Render

Through `anthropic-skills:docx`, from `brd.md`:

1. **Cover** — document number, title, client, vendor, version, date, status.
2. **Document control and version history** — section 0 as tables.
3. **Table of contents**.
4. **Sections 1–21** — headings as Heading 1/2, tables as real Word tables, Mermaid
   diagrams rendered as images where the docx skill supports it; otherwise as the ordered
   step list they describe.
5. **Section 22 — Persetujuan** — the sign-off table for both parties with empty signature
   cells, on its own page.

Language as in `brd.md` (Indonesian, English, or bilingual). Keep IDs, `[src: …]` tags,
and status tags visible — they are the audit trail the client may ask about.

After rendering, open the file's text once and confirm: the cover number matches, every
section heading 0–22 is present, section 18.3 percentages still sum to 100%, and the
sign-off table is present. Report the path and the `brd.md` version rendered.

## write-back — close the loop

Ask before writing anything:

> "Shall I record what we learned from this BRD in your knowledge base?"

If yes, resolve the knowledge base with the same order as `brd-interview` Step 0
(environment convention → connected notes MCP via its own listing tool → a path the user
names → `.gaspol/context-sources.md` → none). None found → say so in one line and skip.

Write only durable lessons, short, where the environment's own convention says notes go:

- the client's objections and corrections during the interview and review rounds;
- facts confirmed for this client (systems in place, signatories, commercial terms agreed);
- which gate findings recurred, so the next interview asks for them earlier;
- what shipped: document number, version, date.

Never write the whole BRD into the knowledge base, and never write a price the user has
not confirmed.

## Close

Report: `.docx` path, `brd.md` version, review round that passed, and whether write-back
ran. The BRD is ready for signatures.
