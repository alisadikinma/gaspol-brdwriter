# Business Requirements Document — {{project-name}}

<!--
Template for brd-draft. Indonesian headings are the default. For English output use the
EN gloss in each heading comment; for bilingual output keep the Indonesian heading and add
the EN gloss after " / ". Every heading below is a contract with brd-gate — never rename,
reorder, or drop one; a section with nothing to say gets one [OPEN] or "Tidak berlaku —
<alasan>" line.
Slots are written {{like-this}}. brd-gate treats any {{ left in brd.md as BLOCKING.
Tags: [CONFIRMED] [ASSUMPTION] [OPEN] [DERIVED: IDs] [RESEARCHED]; numbers carry [src: …].
-->

**Nomor dokumen:** BRD-{{client-code}}-{{nnn}}
**Klien:** {{client-name}}
**Penyedia:** {{vendor-name}}

## 0. Kendali Dokumen
<!-- EN: Document Control -->

| Field | Isi |
|---|---|
| Versi | {{version}} |
| Tanggal | {{date}} |
| Status | Draft / Untuk review / Disetujui |
| Penyusun | {{author}} |
| Reviewer | {{reviewers}} |
| Sumber brief | brief.md tanggal {{brief-date}} |

Riwayat versi:

| Versi | Tanggal | Perubahan | ID terdampak | Disetujui oleh |
|---|---|---|---|---|
| {{version}} | {{date}} | Draft awal | — | — |

## 1. Ringkasan Eksekutif
<!-- EN: Executive Summary — problem, objective, scope, price headline, in ≤ 10 lines -->

{{executive-summary}}

## 2. Latar Belakang & Masalah
<!-- EN: Background & Problem Statement — the business need; include pain points and root cause -->

{{background}}

## 3. Tujuan Bisnis & KPI
<!-- EN: Business Objectives & KPI — SMART objectives -->

| KPI | Baseline | Target | Kapan diukur | Cara ukur |
|---|---|---|---|---|
| {{kpi}} | {{baseline}} [src: {{source}}] | {{target}} [src: {{source}}] | {{when}} | {{how}} |

## 4. Lingkup
<!-- EN: Scope -->

**Dalam lingkup:**

- {{in-scope}}

**Di luar lingkup:**

- {{out-of-scope}}

## 5. Stakeholder & RACI
<!-- EN: Stakeholders & RACI -->

| Stakeholder | Peran | Kepentingan | R | A | C | I |
|---|---|---|---|---|---|---|
| {{stakeholder}} | {{role}} | {{interest}} | | | | |

## 6. Proses As-Is & To-Be
<!-- EN: As-Is and To-Be Process; close with a gap list -->

As-is:

```mermaid
flowchart LR
  {{as-is}}
```

To-be:

```mermaid
flowchart LR
  {{to-be}}
```

Gap (as-is → to-be):

- {{gap}}

## 7. Business Requirements
<!-- EN: Business Requirements -->

| ID | Pernyataan | Prioritas | Status |
|---|---|---|---|
| BR-001 | {{business-requirement}} | Must | [CONFIRMED] |

## 8. Stakeholder Requirements
<!-- EN: Stakeholder Requirements -->

| ID | Induk | Stakeholder | Pernyataan | Prioritas | Status |
|---|---|---|---|---|---|
| SR-001 | BR-001 | {{stakeholder}} | {{stakeholder-requirement}} | Must | [CONFIRMED] |

## 9. Functional Requirements
<!-- EN: Functional Requirements — EARS statement, one behaviour per row -->

| ID | Induk | Pernyataan (EARS) | MoSCoW | Status |
|---|---|---|---|---|
| FR-001 | SR-001 | {{functional-requirement}} | Must | [CONFIRMED] |

## 10. Non-Functional Requirements
<!-- EN: Non-Functional Requirements — ISO/IEC 25010 category, measurable bound with source -->

| ID | Induk | Kategori | Pernyataan terukur | MoSCoW | Status |
|---|---|---|---|---|---|
| NFR-001 | SR-001 | {{category}} | {{measurable-requirement}} [src: {{source}}] | Must | [CONFIRMED] |

## 11. Business Rules
<!-- EN: Business Rules -->

| ID | Melayani | Aturan | Sumber | Status |
|---|---|---|---|---|
| RULE-001 | BR-001 | {{rule}} | [src: {{source}}] | [CONFIRMED] |

## 12. Data & Integrasi
<!-- EN: Data & Integration Requirements — system names only as the user stated them -->

| ID | Melayani | Objek data / sistem | Arah | Frekuensi | Pemilik | Status |
|---|---|---|---|---|---|---|
| DI-001 | BR-001 | {{system-or-data}} | {{direction}} | {{frequency}} | {{owner}} | [CONFIRMED] |

## 13. Transition Requirements
<!-- EN: Transition Requirements — data migration, training, cut-over, hypercare -->

| ID | Melayani | Jenis | Pernyataan | Status |
|---|---|---|---|---|
| TR-001 | BR-001 | {{migration-training-cutover-hypercare}} | {{transition-requirement}} | [CONFIRMED] |

## 14. Asumsi, Batasan & Dependensi
<!-- EN: Assumptions, Constraints & Dependencies -->

| Jenis | Isi | Status |
|---|---|---|
| Asumsi | {{assumption}} | [ASSUMPTION] |
| Batasan | {{constraint}} | [CONFIRMED] |
| Dependensi | {{dependency}} | [CONFIRMED] |

## 15. Risiko
<!-- EN: Risks -->

| Risiko | Dampak | Kemungkinan | Mitigasi | Pemilik |
|---|---|---|---|---|
| {{risk}} | Tinggi/Sedang/Rendah | Tinggi/Sedang/Rendah | {{mitigation}} | {{owner}} |

## 16. Kepatuhan
<!-- EN: Compliance — e.g. UU PDP No. 27/2022 when personal data is processed -->

{{compliance}}

## 17. Kriteria Penerimaan
<!-- EN: Acceptance Criteria — Given/When/Then; every Must FR has at least one -->

| ID | Menguji | Given | When | Then |
|---|---|---|---|---|
| AC-001 | FR-001 | {{state}} | {{event}} | {{observable-result}} |

## 18. Komersial
<!-- EN: Commercial — structure per references/commercial-section.md -->

### 18.1 Paket & Lingkup

{{package-and-scope}}

### 18.2 Harga

{{price}} [src: {{source}}]

### 18.3 Termin Pembayaran

| Termin | % | Nilai | Milestone | Bukti milestone |
|---|---|---|---|---|
| T1 | {{pct}}% | {{amount}} [src: {{source}}] | {{milestone}} | {{evidence}} |

### 18.4 Penerimaan

{{acceptance}}

### 18.5 Perubahan Lingkup

{{change-request}}

### 18.6 Garansi & Hypercare

{{warranty}}

### 18.7 Masa Berlaku Penawaran

{{validity-date}}

## 19. Matriks Keterlusuran
<!-- EN: Traceability Matrix — per templates/traceability-matrix.md -->

| BR | SR | FR/NFR | RULE | TR | Test/AC |
|---|---|---|---|---|---|
| BR-001 | SR-001 | FR-001 | RULE-001 | TR-001 | AC-001 |

## 20. Glosarium
<!-- EN: Glossary — one meaning per term -->

| Istilah | Arti |
|---|---|
| {{term}} | {{meaning}} |

## 21. Pertanyaan Terbuka
<!-- EN: Open Questions — the only section where [OPEN] may remain at signing; each item is not a commitment -->

| No | Pertanyaan | Siapa menjawab | Tenggat | Status |
|---|---|---|---|---|
| 1 | {{question}} | {{who}} | {{due}} | [OPEN] |

## 22. Persetujuan
<!-- EN: Sign-off — both parties -->

| Pihak | Nama | Jabatan | Tanggal | Tanda tangan |
|---|---|---|---|---|
| Klien | {{client-signatory}} | {{title}} | | |
| Penyedia | {{vendor-signatory}} | {{title}} | | |
