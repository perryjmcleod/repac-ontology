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

`PUR-SUBSET-01-intentional-purpose`

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
- candidate subset files
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

`PUR-SUBSET-01-intentional-purpose.md`

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
- `SRC-SUBSET-03-documentary-source`
- `SRC-SUBSET-04-environmental-source`

### Collaboration

- `COLLAB-SUBSET-01-coordination`
- `COLLAB-SUBSET-02-cooperation`
- `COLLAB-SUBSET-03-collaboration`

### Governance

Governance Layer 1 subset identifiers must use the fixed `GOV` prefix and two-digit ordinal format. The current candidate subset inventory and freeze-aligned set remain governed by the Governance L1 files already present in the repository. Any non-canonical references must be normalized to the `GOV-SUBSET-XX-name` pattern during structural repair.

### Purpose

- `PUR-SUBSET-01-intentional-purpose`
- `PUR-SUBSET-02-declarative-purpose`

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

Scope Layer 1 is not yet normalized into individual canonical subset files. The current Scope structural draft remains in pre-validation state and must be normalized before canonical Scope subset identifiers are locked.

Current pre-validation Scope candidate subset labels:

1. Inclusion Boundary
2. Exclusion Boundary
3. Granularity Level
4. Actor Boundary
5. Artefact Boundary
6. Constraint Boundary

No canonical `SCOPE-SUBSET-XX-name` set is locked until the Scope subset normalization audit is completed.

### Work

- `WORK-SUBSET-01-task-work`
- `WORK-SUBSET-02-process-work`
- `WORK-SUBSET-03-outcome-work`

## Normalization Rules

### Rule 1 — Use the Canonical Pattern Only

Every Layer 1 subset identifier must follow:

`PREFIX-SUBSET-XX-name`

Any deviation must be repaired.

### Rule 2 — Use Two-Digit Ordinals

Correct examples:

- `SUBSET-01`
- `SUBSET-02`

Incorrect examples include single-digit numbering or non-padded ordinals.

### Rule 3 — Use Lowercase Kebab-Case Labels

Correct examples:

- `tangible-value`
- `formal-communication`
- `intentional-purpose`

Incorrect examples include camelCase, underscores, title case, or space-separated labels.

### Rule 4 — Match Filename to Identifier Exactly

The markdown filename must exactly equal the canonical identifier plus `.md`.

Correct example:

`VAL-SUBSET-01-tangible-value.md`

Incorrect forms include lowercase prefixes, underscore variants, non-padded ordinals, and mismatched descriptive labels.

### Rule 5 — Preserve Locked Prefixes

Do not substitute or shorten locked prefixes.

Correct examples:

- `SCOPE-SUBSET-01-name`
- `COLLAB-SUBSET-01-coordination`
- `PUR-SUBSET-01-intentional-purpose`

Incorrect forms include alternate prefixes such as shortened or legacy variants.

### Rule 6 — Normalize Legacy Variants to Canonical Prefixes

Legacy identifiers that use superset names rather than canonical prefixes must be normalized to the fixed prefix map defined in this document.

Examples of legacy forms include identifiers using the superset name (for example Source or Purpose) instead of the canonical short prefix. These legacy identifiers must be converted to the canonical `PREFIX-SUBSET-XX-name` format during structural repair.

### Rule 7 — Store Files in the Correct Superset Directory

Each subset markdown file must reside in its corresponding superset directory under:

`ontology/vNext/core-extension/{superset}/`

Example:

`ontology/vNext/core-extension/value/VAL-SUBSET-01-tangible-value.md`

## Audit Method

Normalization must be checked by reviewing both identifiers and filenames.

Suggested repository checks:

```bash
find ontology/vNext/core-extension -type f -name '*SUBSET*'
