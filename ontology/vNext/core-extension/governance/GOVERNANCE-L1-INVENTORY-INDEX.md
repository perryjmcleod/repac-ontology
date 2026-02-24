# GOVERNANCE L1 — Inventory Index (Packaging)

## Purpose
This index enumerates Governance Layer 1 packaging artifacts and their locations.
This file is packaging-only and does not define or modify Governance semantics.

## Status
- Packaging scaffold: Created
- Semantics: Defined elsewhere (diagram + ontology assertions added later)

## Directory Structure
- `ontology/vNext/core-extension/governance/`
  - `diagrams/` — Governance L1 structural diagrams (source of semantic truth for node set)
  - `ontology/` — OWL/Turtle structural stubs (no semantic expansion in this scaffold)
  - `GOVERNANCE-L1-FREEZE-DECISION.md` — packaging freeze decision referencing authoritative diagram
  - `GOVERNANCE-L1-INVENTORY-INDEX.md` — this index

## Artifact List
### Diagrams
- `ontology/vNext/core-extension/governance/diagrams/GOVERNANCE-L1-STRUCTURE.drawio` — Governance L1 Structure (authoritative for subset inventory and naming)

### Decisions
- `ontology/vNext/core-extension/governance/GOVERNANCE-L1-FREEZE-DECISION.md` — Governance L1 Freeze Decision (packaging lock; references diagram)

### Ontology Stubs (Structural Only)
- `ontology/vNext/core-extension/governance/ontology/repac-governance.owl` — OWL stub (ontology header + imports only; no classes/properties asserted)
- `ontology/vNext/core-extension/governance/ontology/repac-governance.ttl` — Turtle stub (ontology header + prefixes only; no classes/properties asserted)

## Notes
- This scaffold intentionally avoids listing Governance L1 subsets by name to prevent drift.
- Subset inventory and naming remain authoritative in the diagram until explicitly locked.
