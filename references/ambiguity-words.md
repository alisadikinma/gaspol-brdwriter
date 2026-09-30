# Banned vague words (Indonesian + English)

Loaded by `brd-draft` (avoid) and `brd-gate` (detect). A word on this list is allowed in a
requirement **only** when the same requirement also carries a measurable bound — a number
with a unit, or a reference to a named standard. Without the bound it is a finding; in an
`NFR-` or an acceptance criterion it is BLOCKING.

Match whole words, case-insensitive. Words used in both languages are listed in both
sections on purpose.

## Indonesian

- cepat, secepatnya, segera, sesegera mungkin
- mudah, gampang, sederhana
- user-friendly, ramah pengguna, intuitif
- fleksibel, dinamis
- efisien, efektif, optimal, maksimal, minimal
- handal, andal, stabil, robust
- aman, terjamin
- sesuai kebutuhan, bila perlu, jika memungkinkan, sebisa mungkin
- memadai, cukup, wajar, layak
- real-time, langsung
- sebagian besar, beberapa, banyak, sedikit
- dll, dsb, dan lain-lain, dan sebagainya, antara lain
- mendukung (without saying what is supported and how far)
- terintegrasi (without naming the systems and direction)
- modern, canggih, terkini
- selalu, tidak pernah, semua, setiap saat (absolutes — test whether they are really meant)

## English

- fast, quick, quickly, as soon as possible, ASAP, immediately
- easy, simple
- user-friendly, intuitive
- flexible, dynamic
- efficient, effective, optimal, maximum, minimal
- robust, reliable, stable
- secure, safe
- as needed, if possible, where appropriate, as appropriate
- adequate, sufficient, reasonable
- real-time, instant
- most, several, many, few
- etc, and so on, among others, including but not limited to
- support (without saying what is supported and how far)
- integrated, seamless (without naming the systems and direction)
- state-of-the-art, modern, cutting-edge
- always, never, all, every (absolutes — test whether they are really meant)
- TBD, TBC

## Classes the gate also flags (no fixed word list)

| Class | Example | Fix |
|---|---|---|
| Comparative without reference | "lebih cepat", "better than" | Say than what, by how much |
| Pronoun with two possible referents | "Supervisor mengirim laporan ke manajer setelah ia menyetujuinya." | Name the noun |
| Missing actor | "Data divalidasi." — by whom? | Name the actor |
| Ambiguous enumeration scope | "Operator memilih A, B dan C dari daftar C." | Say which items come from the list |
| Compound requirement | "… dan/atau …" joining two behaviours | Split into two IDs |

## Allowed with a bound — examples

- `cepat` → `≤ 3 detik (p95)` in the same row: allowed.
- `real-time` → `latensi data ≤ 5 detik dari sensor ke dashboard`: allowed.
- `aman` → `sesuai kontrol akses berbasis peran, ekspor tercatat di log audit`: allowed.
