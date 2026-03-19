# WORK L1 — Element Reconciliation

## Objective

Establish the element layer for Work and align it with the frozen L1 subset structure.

## Constraints

- No conceptual expansion
- No ontology drift
- No OWL/TTL population
- Treat L1 subsets as authoritative

## Frozen Work L1 Subsets

1. `WORK-SUBSET-01-defined`
2. `WORK-SUBSET-02-emergent`

## Element Layer Requirement

Work requires an element layer.

Rationale:
- Work represents executable activity
- It must be decomposable into units
- These units must be reusable and referenceable

## Element Definition

### `WORK-EL` — Work Unit

Definition:
A discrete unit of action that can be performed within a work context.

## Element Type Consistency

All Work elements are instances of a single element type:

- `WORK-EL` — Work Unit

This element type is shared across all subsets.

Subsets do not define different element types.
They classify how Work Units arise:

- Defined → pre-specified Work Units
- Emergent → context-arising Work Units

## Characteristics

- Action-oriented
- Executable
- Context-independent at definition level
- Can be composed into larger work structures

## Examples

- "Validate input data"
- "Install component"
- "Respond to customer inquiry"
- "Analyse requirements"

## Subset Alignment

### Defined Work
- Work Units are pre-specified
- Work Units are organized into structured sequences, procedures, or plans

### Emergent Work
- Work Units arise dynamically during execution
- Work Units may not be predefined before activity begins

## Exclusions

Work elements do not represent:
- Roles
- Tools
- Outcomes
- Value
- Purpose

## Result

PASS — Work is confirmed as an element-bearing superset