# Eval 02 — enhancement to an existing system

Fictional company: PT Contoh Gudang Sentosa, which already runs a warehouse app.

## Prompt

> Aplikasi gudang kami sudah jalan dua tahun. Kami mau tambah fitur stock opname pakai
> scanner, dan data lama harus tetap bisa dilihat. Buatkan BRD untuk penambahan ini.

## Expected behaviour

- Classified as **enhancement**. The as-is is the existing warehouse app, described from
  the user's answers — never "none".
- Asks which existing system is being changed and who maintains it (never invented), what
  must keep working exactly as now, and whether historical data is migrated, recalculated,
  or left as is.
- `brd.md` contains transition requirements (`TR-`) for data handling, training, and
  cut-over, each with its source.
- Every `FR-` traces to an `SR-` or `BR-`; every `BR-` has a child.
- Scope lists both in-scope and out-of-scope items.
- `brd-gate` runs before any `.docx`; a PASS is required for `brd-finish`.

## Must not

- Treat the project as a new system and skip the as-is.
- Name the existing app's vendor or product unless the user named it.
- Leave `TR-` out because "it is only a feature".
