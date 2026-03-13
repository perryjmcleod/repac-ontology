# L1-SUBSET-ID-NORMALIZATION.md

REPAC vNext — Core Extension Structural Repair Pass

## Objective

Normalize Layer 1 subset identifiers across all nine REPAC core-extension supersets so that every subset follows one canonical identifier pattern.

This normalization supports:

- deterministic file naming
- reliable repository search
- consistent markdown references
- clean OWL and TTL alignment
- repeatable audit logic
- stable structural reconstruction

This file is the authoritative normalization reference for Layer 1 subset identifiers in `ontology/vNext/core-extension`.

## Canonical Identifier Pattern

All Layer 1 subset identifiers must follow this pattern:

`PREFIX-SUBSET-XX-name`

Where:

- `PREFIX` = fixed superset prefix
- `SUBSET` = literal constant
- `XX` = two-digit ordinal
- `name` = lowercase kebab-case descriptive label

Example:

`PUR-SUBSET-01-intent`

## Fixed Superset Prefix Map

The following prefixes are fixed and must not vary.

| Superset | Prefix |
|---|---|
| Source | SRC |
| Collaboration | COLLAB |
| Governance | GOV |
| Purpose | PUR |
| Value | VAL |
| Communication | COMM |
| Imperative | IMP |
| Scope | SCOPE |
| Work | WORK |

These prefixes must be used consistently across:

- subset markdown files
- freeze decisions
- packaging audits
- structural stubs
- diagram labels
- OWL entities
- TTL entities
- SHACL references
- grep and audit scripts

## File Naming Standard

Each subset definition file must use the canonical identifier as the filename, with `.md` appended.

Example:

`PUR-SUBSET-01-intent.md`

File names must match the canonical subset identifier exactly.

### Allowed

- uppercase prefix
- uppercase `SUBSET`
- two-digit numbering
- lowercase kebab-case descriptive label
- hyphens

### Not Allowed

- single-digit numbering
- spaces
- underscores
- camelCase
- title case labels
- prefix variation for the same superset
- descriptive labels that do not match the locked canonical form

## Canonical Layer 1 Subset Identifiers

### Source

- `SRC-SUBSET-01-human-source`
- `SRC-SUBSET-02-system-source`
- `SRC-SUBSET-03-document-source`

### Collaboration

- `COLLAB-SUBSET-01-coordination`
- `COLLAB-SUBSET-02-cooperation`
- `COLLAB-SUBSET-03-collaboration`

### Governance

- `GOV-SUBSET-01-authority-structure`
- `GOV-SUBSET-02-decision-rights`
- `GOV-SUBSET-03-accountability`
- `GOV-SUBSET-04-policy-constraints`
- `GOV-SUBSET-05-compliance-oversight`

### Purpose

- `PUR-SUBSET-01-intent`

### Value

- `VAL-SUBSET-01-tangible-value`
- `VAL-SUBSET-02-intangible-value`

### Communication

- `COMM-SUBSET-01-formal-communication`
- `COMM-SUBSET-02-informal-communication`

### Imperative

- `IMP-SUBSET-01-mandatory-imperative`
- `IMP-SUBSET-02-discretionary-imperative`

### Scope

- `SCOPE-SUBSET-01-perspective`
- `SCOPE-SUBSET-02-boundary`
- `SCOPE-SUBSET-03-timeframe`
- `SCOPE-SUBSET-04-constraints`

### Work

- `WORK-SUBSET-01-activity`
- `WORK-SUBSET-02-process`
- `WORK-SUBSET-03-deliverable`

## Normalization Rules

### Rule 1 — Use the Canonical Pattern Only

Every Layer 1 subset identifier must follow:

`PREFIX-SUBSET-XX-name`

Any deviation must be repaired.

### Rule 2 — Use Two-Digit Ordinals

Correct:

- `SUBSET-01`
- `SUBSET-02`

Incorrect:

- `SUBSET-1`
- `SUBSET-2`

### Rule 3 — Use Lowercase Kebab-Case Labels

Correct:

- `tangible-value`
- `formal-communication`

Incorrect:

- `TangibleValue`
- `tangible_value`
- `Formal-Communication`

### Rule 4 — Match Filename to Identifier Exactly

The markdown filename must exactly equal the canonical identifier plus `.md`.

Correct:

`VAL-SUBSET-01-tangible-value.md`

Incorrect:

- `val-subset-01-tangible-value.md`
- `VAL_SUBSET_01_tangible_value.md`
- `VAL-SUBSET-1-tangible-value.md`

### Rule 5 — Preserve Locked Prefixes

Do not substitute or shorten locked prefixes.

Correct:

- `SCOPE-SUBSET-01-perspective`
- `COLLAB-SUBSET-01-coordination`

Incorrect:

- `SCP-SUBSET-01-perspective`
- `COL-SUBSET-01-coordination`

### Rule 6 — Store Files in the Correct Superset Directory

Each subset markdown file must reside in its corresponding superset directory under:

`ontology/vNext/core-extension/{superset}/`

Example:

`ontology/vNext/core-extension/value/VAL-SUBSET-01-tangible-value.md`

## Audit Method

Normalization must be checked by reviewing both identifiers and filenames.

Suggested repository checks:

```bash
grep -RInE '\b(SRC|COLLAB|GOV|PUR|VAL|COMM|IMP|SCOPE|WORK)-SUBSET-[0-9]{2}-[a-z0-9-]+\b' ontology/vNext/core-extension
