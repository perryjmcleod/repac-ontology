# VALUE L1 — Semantic Freeze Decision

## Status

FROZEN

## Decision

Value L1 semantic structure is frozen for REPAC vNext at the current subset level.

## Frozen Value L1 Subsets

1. `VAL-SUBSET-01-tangible`
2. `VAL-SUBSET-02-intangible`

## Scope of the Freeze

This freeze locks:

- the current Value L1 subset set
- the canonical identifiers for those subsets
- the semantic distinction between the two subsets

This freeze does not yet lock:

- Value element-layer population
- OWL/TTL class or property population
- deeper decomposition below the current subset layer

## Implications

- The frozen subset layer is authoritative for all subsequent Value reconciliation work
- No new Value L1 subsets may be introduced without explicit controlled revision
- Future element placement must conform to this subset freeze

## References

- `VALUE-L1-CANDIDATE-SUBSETS.md`
- `VALUE-L1-SEMANTIC-AUDIT.md`
- `VALUE-L1-FREEZE-DECISION.md`