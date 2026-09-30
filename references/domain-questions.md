# Domain question banks (generic)

Loaded by `brd-interview`. Pick only the bank that matches the project, then only the
questions the knowledge base and earlier answers left open. Max 3 questions per turn.

Questions marked **(NEVER INVENT)** ask for one of the three things this plugin never
supplies itself: price and payment terms, client operating numbers, client system names.
If the user cannot answer one, mark it `[OPEN]`; never fill it with a typical value.

## All projects

1. What happens today, step by step, and where does it hurt most? (as-is)
2. Who signs this document on the client side, and who pays? (sponsor)
3. What number would tell you in six months that this worked? Current value? **(NEVER INVENT)**
4. What is explicitly not part of this project?
5. Is personal data processed (names, phone numbers, IDs, location of people)? → UU PDP No. 27/2022
6. What price, payment terms, and offer validity have you agreed or want to propose? **(NEVER INVENT)**

## Manufacturing (MES, OEE, production reporting)

1. How many machines or lines are in scope, and of which types? **(NEVER INVENT)**
2. What shift pattern runs (shifts per day, hours, days per week)? **(NEVER INVENT)**
3. How is downtime recorded today, and which downtime reasons are used?
4. How are good parts, rejects, and rework counted today, and by whom?
5. What is the ideal cycle time per product, and who owns that number? **(NEVER INVENT)**
6. Which system holds production orders today (ERP, spreadsheet, paper)? **(NEVER INVENT)**
7. Who needs to see what: operator, supervisor, plant manager — on which device?

## IoT (sensors, machine connectivity, telemetry)

1. How many devices or sensors, and what do they measure? **(NEVER INVENT)**
2. How do machines expose data today (PLC protocol, digital I/O, none)? **(NEVER INVENT)**
3. What sampling rate is needed, and what latency from sensor to screen is acceptable?
4. What network is available on the floor (wired, Wi-Fi, cellular), and who manages it?
5. What must happen when the connection drops (buffer locally, alert, nothing)?
6. Who owns installation and maintenance of the hardware?

## Logistics (fleet, delivery, warehouse)

1. How many vehicles, drivers, or warehouses are in scope? **(NEVER INVENT)**
2. How many trips, orders, or shipments per day on a normal and a peak day? **(NEVER INVENT)**
3. How is proof of delivery captured today?
4. Which routes or zones, and who plans them?
5. Which customer or partner systems must receive status updates? **(NEVER INVENT)**

## Integration (any project touching another system)

1. Which system is the source of record for each data object? **(NEVER INVENT)**
2. Direction: into our solution, out of it, or both?
3. Frequency: event-driven, every N minutes, daily file?
4. Who owns the other system, and will they provide access and a test environment?
5. What happens when the other system is unavailable?

## Enhancement projects

1. Which existing system is being changed, and who maintains it today? **(NEVER INVENT)**
2. What must keep working exactly as it does now?
3. Is historical data migrated, recalculated, or left as is?
