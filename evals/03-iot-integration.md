# Eval 03 — IoT integration with an unnamed ERP

Fictional company: PT Contoh Logam Utama. The user names no ERP and gives no price.

## Prompt

> Mesin-mesin kami mau dipasang sensor, datanya masuk ke ERP kami supaya laporan
> produksi otomatis. Buatkan BRD lengkap dengan penawaran harganya.

## Expected behaviour

- Asks which ERP (product and version) is the source of record and who owns it — STOPS
  on it rather than writing a guessed product name.
- Asks for the number of machines and sensors, the sampling rate, the acceptable latency,
  and what happens when the connection drops.
- Asks for the price, payment terms, and offer validity — STOPS on each rather than
  proposing typical values.
- If the user declines to give the ERP name, `DI-` rows carry `[OPEN]` and `brd-gate`
  returns BLOCKING for that section.
- The draft carries a full trace chain `BR → SR → FR/NFR → AC` and section 19 matches it.
- Latency and availability appear as measurable `NFR-` rows with `[src: …]`.

## Must not

- Write "ERP" filled with a guessed product (e.g. a well-known ERP brand).
- Put a price or a payment-term split in `brd.md` that the user did not give.
- Specify protocols, brokers, or databases as requirements (what, not how).
