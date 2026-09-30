# Commercial section — what the client signs

Loaded by `brd-draft` (to write section 18) and `brd-gate` (to check it). In this
plugin a BRD is also the signed commercial basis of the project: every invoice will
reference its number. This file is a structure, **not legal advice** — recommend the
client's legal review before signing.

**Never invented.** Price, tax treatment, payment terms, and validity come from the user
as `[CONFIRMED]` in `brief.md`. A value read from a note is an `[ASSUMPTION]` until the
user confirms it in this session. Missing → STOP and ask.

## Required parts, in this order

### 18.1 Paket & lingkup (package and scope)

- Package name as the user sells it.
- What is included: list the `BR-` IDs (and, where useful, `FR-` groups) the price covers.
- What is not included: explicit out-of-scope list (hardware, licences of third-party
  software, on-site travel, data cleansing beyond an agreed volume — whatever applies).
- Delivery assumptions the price depends on (client provides access, data, a counterpart).

### 18.2 Harga (price)

- Currency and amount, each with `[src: …]`.
- Tax treatment stated explicitly: whether the price includes or excludes VAT, and the
  rate **as the user gives it** with `[src: …]`. Never a hardcoded tax rate.
- Recurring costs separated from one-time costs (licence/subscription, support, hosting).

### 18.3 Termin pembayaran (payment terms)

Table, one row per term:

| Termin | % | Nilai | Milestone | Bukti milestone |
|---|---|---|---|---|
| T1 | 30% | Rp … [src: …] | BRD ditandatangani kedua pihak | BRD bertanda tangan |
| T2 | 50% | Rp … [src: …] | UAT lulus | Berita acara UAT ditandatangani |
| T3 | 20% | Rp … [src: …] | Go-live + hypercare 30 hari selesai | BAST ditandatangani |

Rules:

1. Percentages sum to **exactly 100%**. Retention, if any, is its own row and counts in
   the sum.
2. Every milestone is **verifiable**: it names a signed document or an observable event.
   Banned: "setelah progres 50%", "saat sistem jalan", "setelah pekerjaan hampir selesai".
3. Every Nilai equals % × price, and carries `[src: …]`.
4. State the invoice due period (e.g. "14 hari kalender sejak invoice diterima") as the
   user gives it.

### 18.4 Penerimaan (acceptance)

- UAT window in days, and who signs UAT for the client.
- Deemed acceptance: what happens if the client neither signs nor lists defects inside
  the window (e.g. "dianggap diterima setelah 10 hari kerja") — only if the user agrees.
- Which defect severity blocks acceptance (e.g. only Critical and High), and the
  definition of each severity.
- Acceptance criteria reference: the Given/When/Then criteria in section 17.

### 18.5 Perubahan lingkup (change requests)

- How a change is requested, estimated, approved, and priced; who signs.
- A change is never absorbed silently; it gets a new BRD version or an addendum.

### 18.6 Garansi & hypercare (warranty)

- Hypercare period after go-live, response times, what is covered.
- Warranty on defects against the signed requirements, its duration.

### 18.7 Masa berlaku penawaran (offer validity)

- A date after which price and terms must be re-confirmed.

### 18.8 Tanda tangan — see section 22

The sign-off table in section 22 carries both parties: nama, jabatan, tanggal, tanda
tangan. The commercial section is not binding without it.

## What the gate checks here

- Every Rp / currency amount carries `[src:]`.
- Termin sum = 100%.
- Every milestone names a verifiable document or event.
- No `[OPEN]` item in 18.1–18.7.
- Offer validity date present.
