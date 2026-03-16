# L1-SUBSET-ID-NORMALIZATION.md

REPAC vNext — Core Extension Structural Repair Pass

## Objective

Normalize Layer 1 subset identifiers across all REPAC core-extension supersets so that every subset follows one canonical identifier pattern.

This normalization supports:

- deterministic file naming
- reliable repository search
- consistent markdown references
- clean OWL and TTL alignment
- repeatable audit logic
- stable structural reconstruction

This file is the authoritative normalization reference for Layer 1 subset identifiers in `ontology/vNext/core-extension`.

---

# Canonical Identifier Pattern

All Layer 1 subset identifiers must follow this pattern:

`PREFIX-SUBSET-XX-name`

Where:

- `PREFIX` = fixed superset prefix
- `SUBSET` = literal constant
- `XX` = two-digit ordinal
- `name` = lowercase kebab-case descriptive label

Example:

`PUR-SUBSET-01-intentional`

---

# Fixed Superset Prefix Map

The following prefixes are fixed and must not vary.

| Superset | Prefix |
|---|---|
| Source | SOURCE |
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

---

# File Naming Standard

Each subset definition file must use the canonical identifier as the filename, with `.md` appended.

Example:

`PUR-SUBSET-01-intentional.md`

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
- descriptive labels that repeat the superset name unnecessarily

---

# Canonical Layer 1 Subset Identifiers

## Source

- `SOURCE-SUBSET-01-human`
- `SOURCE-SUBSET-02-system`
- `SOURCE-SUBSET-03-documentary`
- `SOURCE-SUBSET-04-environmental`

## Collaboration

- `COLLAB-SUBSET-01-coordinated`
- `COLLAB-SUBSET-02-emergent`

## Governance

Governance Layer 1 subset identifiers will follow the canonical pattern:

`GOV-SUBSET-XX-name`

The final Governance subset set will be defined and frozen during the Governance L1 stabilization phase.

## Purpose

- `PUR-SUBSET-01-intentional`
- `PUR-SUBSET-02-declarative`

## Value

- `VAL-SUBSET-01-tangible`
- `VAL-SUBSET-02-intangible`

## Communication

- `COMM-SUBSET-01-formal`
- `COMM-SUBSET-02-informal`

## Imperative

- `IMP-SUBSET-01-mandatory`
- `IMP-SUBSET-02-discretionary`

## Scope

- `SCOPE-SUBSET-01-perspective`
- `SCOPE-SUBSET-02-boundary`
- `SCOPE-SUBSET-03-granularity`
- `SCOPE-SUBSET-04-interval`

## Work

- `WORK-SUBSET-01-task`
- `WORK-SUBSET-02-process`
- `WORK-SUBSET-03-outcome`

---

# Normalization Rules

## Rule 1 — Use the Canonical Pattern Only

Every Layer 1 subset identifier must follow:

`PREFIX-SUBSET-XX-name`

Any deviation must be repaired.

## Rule 2 — Use Two-Digit Ordinals

Correct examples:

- `SUBSET-01`
- `SUBSET-02`

Incorrect examples include single-digit numbering or non-padded ordinals.

## Rule 3 — Use Lowercase Kebab-Case Labels

Correct examples:

- `tangible`
- `formal`
- `intentional`

Incorrect examples include camelCase, underscores, title case, or space-separated labels.

## Rule 4 — Match Filename to Identifier Exactly

The markdown filename must exactly equal the canonical identifier plus `.md`.

Correct example:

`VAL-SUBSET-01-tangible.md`

Incorrect forms include lowercase prefixes, underscore variants, non-padded ordinals, and mismatched descriptive labels.

## Rule 5 — Preserve Locked Prefixes

Do not substitute or shorten locked prefixes.

Correct examples:

- `SCOPE-SUBSET-01-name`
- `COLLAB-SUBSET-01-coordinated`
- `PUR-SUBSET-01-intentional`

Incorrect forms include alternate prefixes or legacy abbreviations.

## Rule 6 — Avoid Redundant Superset Labels

Subset labels must not repeat the superset name.

Examples of redundant forms:

- `tangible-value`
- `formal-communication`
- `mandatory-imperative`
- `task-work`

These must be simplified to the differentiating concept only.

Correct examples:

- `tangible`
- `formal`
- `mandatory`
- `task`

## Rule 7 — Store Files in the Correct Superset Directory

Each subset markdown file must reside in its corresponding superset directory under:

`ontology/vNext/core-extension/{superset}/`

Example:

`ontology/vNext/core-extension/value/VAL-SUBSET-01-tangible.md`

---

# Audit Method

Normalization must be checked by reviewing both identifiers and filenames.

Suggested repository checks:

```bash
find ontology/vNext/core-extension -type f -name '*SUBSET*'