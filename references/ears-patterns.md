# Requirement statement patterns (EARS) and priority

EARS — Easy Approach to Requirements Syntax (Mavin et al.). Loaded by `brd-draft`.
Every `FR-` and `NFR-` statement uses one of the five forms below. The keyword order is
fixed so a reader can tell the trigger from the condition from the response.

## The five forms

| Form | English keyword | Indonesian rendering | Example (ID) |
|---|---|---|---|
| Ubiquitous (always) | The system shall … | Sistem harus … | Sistem harus mencatat setiap perubahan status mesin beserta waktu dan pengguna. |
| Event-driven | When <event>, the system shall … | Ketika <kejadian>, sistem harus … | Ketika mesin berhenti lebih dari 10 menit, sistem harus mengirim notifikasi ke supervisor shift. |
| State-driven | While <state>, the system shall … | Selama <keadaan>, sistem harus … | Selama mesin dalam status perawatan terjadwal, sistem harus mengecualikan waktu tersebut dari perhitungan availability. |
| Unwanted behaviour | If <unwanted condition>, then the system shall … | Jika <kondisi tidak diinginkan>, maka sistem harus … | Jika koneksi ke mesin terputus, maka sistem harus menyimpan data lokal dan mengirimkannya saat koneksi pulih. |
| Optional feature | Where <feature is included>, the system shall … | Apabila <fitur disertakan>, sistem harus … | Apabila modul kualitas disertakan, sistem harus mencatat jumlah reject per jenis cacat. |

Forms can combine: `Selama <keadaan>, ketika <kejadian>, sistem harus …`.

## Modal verbs and MoSCoW

| English | Indonesian | Meaning | MoSCoW |
|---|---|---|---|
| shall | harus | Mandatory; acceptance fails without it | **Must** |
| should | sebaiknya | Expected; can be traded with the sponsor's written agreement | **Should** |
| may | boleh | Optional; delivered if time allows | **Could** |
| — | tidak dalam lingkup ini | Agreed not to deliver now | **Won't (this time)** |

Use one modal per requirement. Never "harus atau sebaiknya".

## Measurable NFR

A non-functional requirement names a metric, a threshold, a unit, and the condition under
which it is measured.

| Weak | Measurable |
|---|---|
| Sistem harus cepat. | Sistem harus menampilkan dashboard shift berjalan dalam ≤ 3 detik (p95) dengan 50 pengguna bersamaan. |
| Sistem harus andal. | Sistem harus tersedia ≥ 99,5% per bulan pada jam operasional 06.00–22.00 WIB, di luar jadwal perawatan yang diumumkan 48 jam sebelumnya. |
| API harus responsif. | p95 < 200 ms pada 500 rps. |
| Data harus aman. | Hanya pengguna dengan peran Supervisor atau lebih tinggi yang dapat mengekspor data produksi; setiap ekspor tercatat di log audit. |

Every threshold carries `[src: …]` — who set it (user, a standard, a contract).

## Acceptance criteria — Given / When / Then

```text
Given  mesin M-07 berstatus RUN dan shift pagi berjalan
When   sinyal mesin berhenti selama 11 menit
Then   supervisor shift pagi menerima notifikasi berisi ID mesin, jam berhenti, dan durasi
```

Given = state with concrete data. When = one event. Then = one observable result.
