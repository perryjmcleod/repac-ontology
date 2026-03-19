# WORK — Element Placement Freeze

## Objective

Lock the placement of Work elements relative to the frozen L1 subset structure.

## Constraints

- No conceptual expansion
- No ontology drift
- No OWL/TTL population
- Treat subset structure as authoritative

## Frozen Work L1 Subsets

1. `WORK-SUBSET-01-defined`
2. `WORK-SUBSET-02-emergent`

## Element Placement

### `WORK-SUBSET-01-defined`

- `WORK-EL-*` — Defined Work Units

### `WORK-SUBSET-02-emergent`

- `WORK-EL-*` — Emergent Work Units

## Structural Rule

- All Work elements are instances of `WORK-EL`
- Subsets do not introduce different element types
- Elements are classified by subset based on how they arise:
  - Pre-specified → Defined
  - Context-arising → Emergent

## Result

LOCKED — Work element structure stabilized for vNext pre-ontology phase