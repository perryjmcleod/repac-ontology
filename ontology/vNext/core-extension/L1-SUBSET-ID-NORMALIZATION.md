# REPAC vNext — L1 Subset ID Normalization Standard

## Purpose

This document defines the canonical identifier standard for Layer-1 Subsets across all REPAC supersets in the vNext core-extension repository.

The objective of this normalization is to:

- eliminate subset / element identifier drift
- enforce consistent identifier structure across supersets
- ensure diagrams, markdown, OWL, and SHACL artifacts reference the same identifiers
- stabilize Layer-1 before controlled element expansion

This standard applies to all artifacts located under:

`ontology/vNext/core-extension/`

## Canonical Identifier Rules

### Rule 1 — Subset Identifiers

All Layer-1 subsets must follow this identifier structure:

`PREFIX-SUBSET-NN`

Where:

- `PREFIX` = superset identifier
- `SUBSET` = indicates Layer-1 subset
- `NN` = two-digit ordinal sequence

Example:

`SOURCE-SUBSET-01`

### Rule 2 — Element Identifiers

Element-layer constructs must follow this structure:

`PREFIX-EL-NN`

These represent analytical constructs that exist below the subset layer.

Example:

`GOV-EL-01`

Elements must never be used as substitutes for subset identifiers.

### Rule 3 — Layer Separation

REPAC analytical layers must remain structurally distinct.

- **Superset**  
  Top analytical domain

- **Subset**  
  Primary analytical category within a superset

- **Element**  
  Analytical mechanism or construct used within subsets

- **Artifact**  
  Documentation or implementation representation

Subset artifacts must never reference element identifiers as subset identifiers.

## Superset Prefix Table

- Source → `SOURCE`
- Collaboration → `COLLAB`
- Governance → `GOV`
- Purpose → `PUR`
- Value → `VAL`
- Communication → `COMM`
- Imperative → `IMP`
- Scope → `SCOPE`
- Work → `WORK`

## Canonical L1 Subset Inventory

### Source

- `SOURCE-SUBSET-01 Human Source`
- `SOURCE-SUBSET-02 System Source`
- `SOURCE-SUBSET-03 Documentary Source`
- `SOURCE-SUBSET-04 Environmental Source`

### Collaboration

- `COLLAB-SUBSET-01 CoordinatedCollaboration`
- `COLLAB-SUBSET-02 EmergentCollaboration`

### Governance

Governance subset inventory is currently maintained in the authoritative diagram:

`ontology/vNext/core-extension/governance/diagrams/GOVERNANCE-L1-STRUCTURE.drawio`

Governance presently contains element-layer constructs using `GOV-EL` identifiers.

Governance subset normalization will occur during a later controlled repair phase.

No renaming is authorized during this stabilization pass.

### Purpose

- `PUR-SUBSET-01 IntentionalPurpose`
- `PUR-SUBSET-02 DeclarativePurpose`

### Value

- `VAL-SUBSET-01 TangibleValue`
- `VAL-SUBSET-02 IntangibleValue`

### Communication

- `COMM-SUBSET-01 Formal Communication`
- `COMM-SUBSET-02 Informal Communication`

### Imperative

Imperative subset normalization is temporarily deferred due to corruption discovered in earlier freeze artifacts.

The subset structure must be reconstructed before identifier normalization is applied.

### Scope

Scope currently uses element identifiers for its L1 analytical dimensions.

Current structure:

- `SCOPE-EL-01 Perspective`
- `SCOPE-EL-02 Boundary`
- `SCOPE-EL-03 Granularity`
- `SCOPE-EL-04 Interval`

A future normalization may convert these to:

- `SCOPE-SUBSET-01 Perspective`
- `SCOPE-SUBSET-02 Boundary`
- `SCOPE-SUBSET-03 Granularity`
- `SCOPE-SUBSET-04 Interval`

This conversion is not performed during the current repair pass.

### Work

- `WORK-SUBSET-01 Task Work`
- `WORK-SUBSET-02 Process Work`
- `WORK-SUBSET-03 Outcome Work`

## Normalization Scope

This identifier standard applies to:

- candidate subset files
- freeze decision files
- semantic audit files
- subset definition files
- structural documentation
- future ontology class identifiers

## Explicit Prohibitions

The following practices are not permitted:

- using element identifiers as subset identifiers
- renaming subsets outside freeze decisions
- introducing new subset identifiers without governance approval
- mixing subset-layer and element-layer constructs

## Status

REPAC vNext Structural Repair Pass  
Core-Extension Layer-1 Stabilization
