# Skill & Plugin Claude untuk Menulis BRD Profesional: Riset & Rekomendasi (per 30 September 2026)

**Jawaban singkat: saya tidak menemukan satu pun Claude skill/plugin BRD yang sudah matang dan dipakai luas. Yang matang (Anthropic `product-management`, BMAD, Spec Kit, deanpeters) berfokus pada PRD/spec, bukan BRD formal. Skill yang benar-benar khusus BRD masih proyek perorangan dengan 0–22 stars.** Langkah terbaik untuk Anda: buat custom BRD skill sendiri dengan menggabungkan pola dari 2–3 repo di bawah, lalu pakai `docx` skill resmi Anthropic untuk output Word.

## TL;DR
- **Belum ada BRD skill yang "production-grade".** Kandidat terbaik khusus BRD adalah `gerardogdonoso/brd-business-analyst` (16 section, traceable IDs, anti-hallucination tags, evals; tapi 0 stars dan berbahasa Spanyol) dan `jdm4pku/RE-Skills` (44 skill requirements engineering berbasis Wiegers & IEEE 29148; 22 stars). Library BA umum seperti `takusaotome/claude-skills-library` (business-analyst skill "aligned with BABOK v3") punya template BRD, tapi adopsinya sangat kecil.
- **Yang matang dan terawat justru berorientasi PRD:** plugin resmi Anthropic `product-management` (`/write-spec`, repo ~23.9k stars), BMAD-METHOD (~52–54k stars, agent Analyst→PM→Architect), GitHub Spec Kit (~139k stars), dan deanpeters/Product-Manager-Skills (~7k stars, lisensi non-komersial). Semuanya bagus sebagai komponen, tapi tidak menghasilkan BRD gaya BABOK (business/stakeholder/solution/transition requirements).
- **Rekomendasi:** (1) bangun custom skill `brd-writer` sendiri (struktur ada di bagian akhir) dengan meminjam pola wawancara dari gerardogdonoso dan checklist kualitas dari RE-Skills; (2) instal plugin `product-management` resmi Anthropic untuk PRD turunan; (3) pakai BMAD atau Spec Kit hanya kalau BRD akan langsung diteruskan ke build dengan Claude Code.

## Key Findings

### Tabel perbandingan opsi utama (ekosistem Claude)

| # | Nama / Sumber | Output | Maturity (terverifikasi) | Install | Fit untuk BRD profesional |
|---|---|---|---|---|---|
| 1 | **brd-business-analyst**: github.com/gerardogdonoso/brd-business-analyst | BRD 16 section dengan ID (OB-, RN-, CA-…), status [CONFIRMADO]/[SUPUESTO], MoSCoW, Given/When/Then, traceability matrix, handoff block | 0 stars, 0 forks, 40 commits, MIT, ada folder `evals` | `git clone` ke `$env:USERPROFILE\.claude\skills\...` (README menyertakan perintah PowerShell); dipanggil manual `/business-analyst-vibecoding` | **Tinggi secara desain, rendah secara adopsi.** Alur fase & aturan anti-hallucination-nya paling cocok untuk BRD. Kekurangan: ID dan tag berbahasa Spanyol; perlu diadaptasi. |
| 2 | **RE-Skills**: github.com/jdm4pku/RE-Skills | 44 skill RE (vision-and-scope, stakeholder-analysis, business-rule, srs-document, writing-requirements dengan EARS, traceability, review checklist) + 9 slash command (mis. `write-srs`) | 22 stars, 1 fork, 3 commits, v1.0 Apr 2026; tanpa lisensi open-source eksplisit ("educational and professional use") | Salin folder `skills/` ke project | **Tinggi untuk rigor SRS/requirements** (Wiegers & Beatty, IEEE 29148, ISO 25010). Bukan BRD siap pakai, tapi referensi terbaik untuk kualitas requirement. |
| 3 | **business-analyst** (takusaotome/claude-skills-library) | BRD template (problem, objectives, scope, stakeholder, current/future state, requirements ber-ID, business rules, acceptance criteria), BPMN, gap analysis, business case (ROI/NPV via Python) | Star count kecil dan berbeda antar-snapshot (2–7 stars), 3 forks, MIT, ~360 commits, library 78 skill | `cp -r ./skills/business-analyst ~/.claude/skills/` | **Sedang–tinggi.** Paling dekat ke BABOK v3, tapi maintainer tunggal dengan adopsi minim. |
| 4 | **Product Management plugin (resmi Anthropic)**: github.com/anthropics/knowledge-work-plugins | `/write-spec` → PRD/feature spec (problem, goals, user stories, MoSCoW, success metrics, non-goals), plus roadmap, stakeholder update | Repo ~23.9k stars, ~2.9k forks; dikelola Anthropic | `claude plugin marketplace add anthropics/knowledge-work-plugins` lalu `claude plugin install product-management@knowledge-work-plugins` | **Sedang.** Paling terpercaya dan terawat, tapi PRD-sentris (tidak ada as-is/to-be, transition requirements, sign-off). |
| 5 | **BMAD-METHOD**: github.com/bmad-code-org/BMAD-METHOD | Project brief (Analyst) → PRD (PM) → architecture → epics/stories; ada skill `bmad-create-prd`, `bmad-validate-prd` | ~52.4k–53.6k stars, ~6k forks, MIT, rilis terbaru Sep 2026 | `npx bmad-method install` | **Sedang.** Sangat matang untuk spec-driven build; berlebihan kalau yang dibutuhkan hanya dokumen BRD untuk klien. |
| 6 | **GitHub Spec Kit**: github.com/github/spec-kit | `spec.md`, `plan.md`, tasks via `/speckit.specify`, `/speckit.clarify`, `/speckit.checklist` | ~139k stars, ~12.5k forks, MIT; dokumentasi menyebut Windows PowerShell kini didukung tanpa WSL | `uv tool install specify-cli --from git+https://github.com/github/spec-kit.git` lalu `specify init <project> --ai claude` | **Rendah–sedang untuk BRD.** Spec level fitur untuk engineering, bukan dokumen bisnis. |
| 7 | **Product-Manager-Skills**: github.com/deanpeters/Product-Manager-Skills | `prd-development` (problem → personas → solution → metrics → stories), user-story (Gherkin), 77 skill PM | ~7k stars, ~829 forks, v0.84 (Agu 2026); **lisensi CC BY-NC-SA 4.0 (non-komersial)** | `/plugin marketplace add deanpeters/Product-Manager-Skills` atau `npx skills add ...` | **Sedang.** Kualitas tinggi, tapi PRD-sentris, dan lisensi NC berisiko untuk pekerjaan konsultan berbayar. |
| 8 | **docx skill (resmi Anthropic)**: github.com/anthropics/skills | Membuat/mengedit .docx (heading, TOC, tabel, tracked changes, comments) | Resmi Anthropic; lisensi source-available (bukan open-source) | `/plugin marketplace add anthropics/skills` lalu `/plugin install document-skills@anthropic-agent-skills` | **Komponen wajib** untuk menyerahkan BRD dalam format Word ke klien Indonesia. |

### Temuan lain (lebih lemah atau belum terverifikasi)
- **BASkill-Claude (abhattachar5)**: IT BA skill untuk BRD/FRD, user stories, traceability, RACI, UAT, dengan domain insurance/financial services. **Belum terverifikasi di GitHub**; saya hanya menemukannya lewat artikel Medium penulisnya. Menurut artikel itu, repo berisi SKILL.md dan folder `references/` (12 file). Perlakukan sebagai "belum dikonfirmasi".
- **brd-frd-agent (saruno/business-analyst-skills)**: wawancara Socratic, gap AS-IS/TO-BE, BRD+FRD dengan Mermaid. Ini fork dari `phong-baruby/ba-skills` (0 stars) dan ditulis **dalam bahasa Vietnam**.
- **nayyarsan/business-requirements-agent**: skill `brd-gathering` dan `brd-structuring`, tapi berbasis **GitHub Copilot SDK**/VS Code, bukan Claude (1 star, v0.1.0, Jan 2026).
- **doc-brd (majiayu000/claude-skill-registry)** dan **brd (cwijayasundara/claude_harness_eng_v4)**: skill BRD yang tertanam di framework SDLC tertentu (ID seperti BRD.01.32.01, output JSON requirement). Menarik sebagai inspirasi, tapi terikat metodologinya masing-masing dan maturity-nya tidak saya verifikasi.
- **alirezarezvani/claude-skills** (~26.5k stars, MIT): folder `product-team/` punya `product-manager-toolkit` (template PRD) dan `code-to-prd` (reverse-engineer codebase jadi PRD). `code-to-prd` berguna untuk proyek brownfield/legacy, tapi tidak ada BRD skill khusus.
- **Direktori pihak ketiga** (mcpmarket, skills.lc, skillsmp, claudemarketplaces) hanya mengindeks ulang repo GitHub. Metrik di sana sering usang, jadi selalu cek repo aslinya.

### Alat AI lain (pembanding, singkat)
- **Microsoft Copilot in Word**: bisa men-draft dari prompt dan mereferensikan file. Menurut halaman Microsoft "Draft and add content with Copilot in Word", Anda cukup mengetik `/` di prompt dan bisa memilih "up to 20 items for Copilot to reference" (file Word, PowerPoint, PDF, atau TXT dari SharePoint/OneDrive). Copilot juga mempertahankan format dari template yang ada. Perlu lisensi Microsoft 365 Copilot. Cocok kalau klien Anda "hidup" di Word/SharePoint, tapi tidak punya metodologi BA bawaan.
- **Atlassian Confluence + Rovo**: template BRD gratis di Confluence dan "Create with Rovo" untuk PRD/spec dari source docs; Atlassian juga menyebut Product Requirements Agent yang menyinkronkan Jira↔Confluence. Halaman Atlassian "Rovo Plans and Trial" menyatakan Rovo, "including Search, Chat, and Studio apps as well as agents, is available to customers with a Standard, Premium, or Enterprise Cloud plan". Yang berbeda antar-plan adalah kuota kredit: 25 (Standard), 70 (Premium), dan 150 (Enterprise) kredit/user/bulan. Satu halaman marketing Atlassian yang lebih lama menyebut fitur penuh butuh Premium/Enterprise, jadi cek ulang saat membeli.
- **ClickUp Brain**: menurut blog resmi ClickUp, template BRD-nya punya "10 customizable subpages, functional & non-functional requirements, compliance & dependencies", plus AI BRD generator di dalam workspace.
- **ChatGPT custom GPTs**: ada banyak GPT/prompt BRD, tapi kualitasnya tidak merata. TechCrunch (20 Mar 2024) melaporkan "OpenAI's chatbot store is filling up with spam" di antara sekitar 3 juta GPT, termasuk GPT peniru dan GPT untuk menembus detektor AI. Tidak ada yang layak saya rekomendasikan secara spesifik.
- **Kesimpulan pembanding:** alat-alat ini unggul di kolaborasi dan distribusi dokumen, bukan di rigor requirements. Untuk workflow Anda yang berbasis Claude, lebih efisien menaruh metodologi di skill dan mengekspor ke .docx atau Confluence.

## Details: Standar yang Harus Diikuti Skill BRD

**IIBA BABOK Guide v3**, yang paling relevan untuk BRD:
- Klasifikasi requirement: **Business** (why: goals, objectives, outcomes), **Stakeholder** (kebutuhan tiap stakeholder; jembatan ke solusi), **Solution** (functional dan non-functional), dan **Transition** (sementara: data migration, training, business continuity saat cut-over).
- 6 knowledge area: Planning & Monitoring, Elicitation & Collaboration, Requirements Life Cycle Management, Strategy Analysis, Requirements Analysis & Design Definition, Solution Evaluation.
- Implikasi untuk skill: BRD harus punya rantai trace Business Need → Business Req → Stakeholder Req → Solution Req. Skill PRD umumnya melewatkan lapisan ini.

**ISO/IEC/IEEE 29148:2018**:
- Mendefinisikan information item: **BRS** (Business Requirements Specification), **StRS** (Stakeholder), **SyRS** (System), dan **SRS** (Software). Secara formal, BRD Anda ≈ BRS/StRS; SRS adalah turunannya.
- Karakteristik requirement yang baik: necessary, unambiguous, complete, consistent, verifiable, feasible, traceable. Ini ideal sebagai checklist review otomatis di skill.
- Status ISO: menurut iso.org, edisi 2018 "was last reviewed and confirmed in 2024" dan kini berstatus stage 90.92 ("to be revised"). Penggantinya, ISO/IEC/IEEE DIS 29148, berada di stage 40.00 ("DIS registered", tahap enquiry dengan anggota ISO). Edisi 2018 masih berlaku, tapi pantau terbitnya edisi baru.

**Praktik penulisan requirement** (dipakai RE-Skills): EARS templates, "shall/should/may", NFR terukur (contoh: "p95 < 200 ms pada 500 rps"), acceptance criteria Given/When/Then, prioritas MoSCoW.

## Recommendations

1. **Top 1: bangun custom skill `brd-writer` sendiri** (2–4 jam kerja dengan `skill-creator` Anthropic). Ambil: (a) alur fase, tag status, dan aturan "jangan mengarang, tanya dulu" dari gerardogdonoso; (b) BABOK classification dan business case dari takusaotome; (c) checklist kualitas IEEE 29148/EARS dan template traceability dari RE-Skills; (d) output .docx via `docx` skill resmi. Alasan: tidak ada opsi yang sekaligus BABOK-compliant, bilingual ID/EN, dan cocok untuk konteks manufaktur/IoT Indonesia.
2. **Top 2: instal plugin `product-management` Anthropic** sebagai pelengkap. Pakai `/write-spec` untuk menurunkan BRD yang sudah disetujui menjadi PRD per fitur. Ini paling aman dari sisi maintenance karena dikelola Anthropic.
3. **Top 3 (kondisional): BMAD-METHOD atau Spec Kit**, hanya jika Anda juga membangun solusinya dengan Claude Code. Masukkan BRD final sebagai input Analyst/PM (BMAD) atau `/speckit.specify`. Jangan jadikan alat ini penulis BRD utama.
4. **Hindari** memakai deanpeters/Product-Manager-Skills secara langsung dalam deliverable berbayar karena lisensi CC BY-NC-SA. Pelajari polanya saja.
5. **Keamanan:** audit setiap SKILL.md/script komunitas sebelum instal (terutama yang menjalankan Python/bash), karena skill dieksekusi dengan akses ke file Anda.

### Struktur yang disarankan untuk custom skill `brd-writer`

```
brd-writer/
├── SKILL.md                  ← frontmatter + workflow + aturan
├── templates/
│   ├── brd-template.md       ← section BRD (ID/EN)
│   └── traceability-matrix.md
├── references/
│   ├── babok-classification.md
│   ├── ieee29148-quality-checklist.md
│   ├── ears-patterns.md
│   └── domain-questions-manufacturing-iot.md
├── examples/sample-brd.md    ← 1 contoh bagus (mis. MES/OEE dashboard)
└── evals/                    ← 3–5 kasus uji (ide kabur, fitur, integrasi)
```

**Frontmatter SKILL.md (contoh):**
```yaml
---
name: brd-writer
description: Menyusun Business Requirements Document (BRD) profesional untuk proyek software/digital transformation (BABOK v3, ISO/IEC/IEEE 29148). Gunakan saat user minta BRD, business requirements, analisis kebutuhan, as-is/to-be, atau scope proyek klien.
disable-model-invocation: true
---
```

**Workflow di SKILL.md:**
1. **Fase 0, Klasifikasi:** sistem baru / enhancement / integrasi / perbaikan proses; bahasa output (ID, EN, atau bilingual).
2. **Fase 1, Konteks bisnis:** problem/opportunity, objectives SMART, KPI baseline→target, sponsor.
3. **Fase 2, Stakeholder & scope:** RACI, in-scope/out-of-scope, as-is process (Mermaid).
4. **Fase 3, Requirements:** BR-xxx → SR-xxx (stakeholder) → FR-xxx/NFR-xxx; business rules (RULE-xxx); data & integrasi (ERP/MES/SCADA/IoT).
5. **Fase 4, Transition:** migrasi data, training, cut-over, dukungan hypercare.
6. **Fase 5, Constraints, assumptions, risks, dependencies, open questions**; compliance lokal (mis. UU PDP No. 27/2022 bila ada data pribadi).
7. **Fase 6, Quality gate:** cek setiap requirement terhadap 7 karakteristik IEEE 29148, deteksi kata ambigu ("cepat", "mudah", "user-friendly"), cek traceability, lalu minta konfirmasi user.
8. **Fase 7, Output:** Markdown, lalu .docx via `docx` skill (cover, version history, approval/sign-off table).

**Aturan inti:** maksimal 3 pertanyaan per giliran; tandai setiap item [CONFIRMED]/[ASSUMPTION]/[OPEN]; jangan pernah mengarang angka atau nama sistem klien; pisahkan "what" (BRD) dari "how" (desain teknis).

**Section BRD minimal:** Document control & sign-off · Executive summary · Background & problem statement · Business objectives & KPI · Scope (in/out) · Stakeholders & RACI · As-is / To-be process · Business requirements · Stakeholder requirements · Functional requirements (high-level) · Non-functional requirements · Business rules · Data & integration requirements · Transition requirements · Assumptions, constraints, dependencies · Risks · Acceptance criteria · Traceability matrix · Glossary · Open questions.

## Caveats
- **Metrik GitHub** diambil dari halaman yang di-fetch pada September 2026 dan bisa berupa snapshot cache. Angka stars untuk takusaotome berbeda antar-sumber (2–7), dan BMAD 52.4k vs 53.6k. Tanggal last commit untuk sebagian besar repo tidak terlihat.
- **Belum terverifikasi langsung di GitHub:** BASkill-Claude (hanya via Medium), doc-brd (majiayu000), dan brd (cwijayasundara). Deskripsi di direktori pihak ketiga (mcpmarket dll.) bisa berupa marketing atau ringkasan otomatis.
- README gerardogdonoso menggunakan URL clone `business-analyst-vibecoding.git`, sedangkan repo aktualnya `brd-business-analyst`. Clone dari URL repo aktual.
- Lisensi berbeda-beda: MIT (gerardogdonoso, takusaotome, BMAD, Spec Kit, alirezarezvani), CC BY-NC-SA (deanpeters), source-available (Anthropic docx), dan tidak jelas (RE-Skills, nayyarsan). Periksa sebelum memakai ulang konten dalam deliverable komersial.
- Harga/lisensi Copilot, Rovo, dan ClickUp bisa berubah; cek halaman vendor sebelum membeli.
