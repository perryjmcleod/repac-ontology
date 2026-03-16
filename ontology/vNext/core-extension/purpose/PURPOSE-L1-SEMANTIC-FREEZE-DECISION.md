# PURPOSE L1 — Semantic Freeze Decision

## Status

FROZEN

## Decision

Purpose L1 semantic structure is frozen for REPAC vNext at the current subset level.

## Frozen Purpose L1 Subsets

1. `PUR-SUBSET-01-intentional`
2. `PUR-SUBSET-02-declarative`

## Scope of the Freeze

This freeze locks:

- the current Purpose L1 subset set
- the canonical identifiers for those subsets
- the semantic distinction between the two subsets

This freeze does not yet lock:

- Purpose element-layer population
- OWL/TTL class or property population
- deeper decomposition below the current subset layer

## Implications

- The frozen subset layer is authoritative for all subsequent Purpose reconciliation work
- No new Purpose L1 subsets may be introduced without explicit controlled revision
- Future element placement must conform to this subset freeze

## References

- `PURPOSE-L1-CANDIDATE-SUBSETS.md`
- `PURPOSE-L1-SEMANTIC-AUDIT.md`
- `PURPOSE-L1-FREEZE-DECISION.md`