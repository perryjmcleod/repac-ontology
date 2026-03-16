# IMPERATIVE L1 — Semantic Freeze Decision

## Status

FROZEN

## Decision

Imperative L1 semantic structure is frozen for REPAC vNext at the current subset level.

## Frozen Imperative L1 Subsets

1. `IMP-SUBSET-01-mandatory`
2. `IMP-SUBSET-02-discretionary`

## Scope of the Freeze

This freeze locks:

- the current Imperative L1 subset set
- the canonical identifiers for those subsets
- the semantic distinction between the two subsets

This freeze does not yet lock:

- Imperative element-layer population
- OWL/TTL class or property population
- deeper decomposition below the current subset layer

## Implications

- The frozen subset layer is authoritative for all subsequent Imperative reconciliation work
- No new Imperative L1 subsets may be introduced without explicit controlled revision
- Future element placement must conform to this subset freeze

## References

- `IMPERATIVE-L1-CANDIDATE-SUBSETS.md`
- `IMPERATIVE-L1-SEMANTIC-AUDIT.md`
- `IMPERATIVE-L1-FREEZE-DECISION.md`