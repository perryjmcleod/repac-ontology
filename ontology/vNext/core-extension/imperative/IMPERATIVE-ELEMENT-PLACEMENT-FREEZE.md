# IMPERATIVE — Element Placement Freeze

## Objective

Formally close the Imperative element layer and confirm that no element placement is authorized under the frozen L1 subset structure.

## Constraints

- No conceptual expansion
- No ontology drift
- Treat subset freeze as authoritative
- Treat cross-superset boundary rules as controlling
- No OWL/TTL population
- Do not introduce element-layer semantics into Imperative

## Frozen Imperative L1 Subsets

1. `IMP-SUBSET-01-mandatory`
2. `IMP-SUBSET-02-discretionary`

## Element Placement Decision

No Imperative element placement is authorized.

Imperative is a **subset-terminal, non-element-bearing superset**.

## Rationale

The frozen L1 subset structure fully represents Imperative:

- mandatory
- discretionary

No additional element layer is required or permitted.

## Boundary Enforcement (Authoritative)

Imperative must not absorb semantics from other supersets.

In particular, Imperative must not encode:

- execution structures (Work)
- authority or control (Governance)
- communication transmission (Communication)
- coordination structures (Collaboration)
- value attribution (Value)

Imperative defines normative force only.

## Placement Status

LOCKED — No Imperative element placement exists or is permitted under the current REPAC vNext model.