# GOVERNANCE — Element Placement Freeze

## Status

FROZEN

Governance element placement relative to the Governance L1 subset layer is now frozen for REPAC vNext reconciliation purposes.

## Objective

Lock the authoritative placement of existing Governance elements under the frozen Governance L1 subset structure.

This freeze governs subsequent Governance element-layer normalization, directory cleanup, and future ontology population work.

## Constraints

- No conceptual expansion
- No ontology drift
- No OWL/TTL population yet
- Subset freeze remains authoritative
- Element placement is semantic first; physical file relocation may follow as a controlled implementation step

## Authoritative Governance L1 Subsets

1. `GOV-SUBSET-01-authority`
2. `GOV-SUBSET-02-decision-rights`
3. `GOV-SUBSET-03-control`
4. `GOV-SUBSET-04-accountability`

## Frozen Element Placement

### `GOV-SUBSET-01-authority`

- `GOV-EL-01-authority-structure`
- `GOV-EL-03-legitimacy-basis`
- `GOV-EL-08-informal-governance-overlay`

### `GOV-SUBSET-02-decision-rights`

- `GOV-EL-02-decision-rights-allocation`
- `GOV-EL-05-escalation-logic`

### `GOV-SUBSET-03-control`

- `GOV-EL-04-enforcement-mechanism`
- `GOV-EL-07-compliance-mechanism`

### `GOV-SUBSET-04-accountability`

- `GOV-EL-06-oversight-construct`

## Freeze Table

| Element ID | Frozen Subset Placement |
|---|---|
| `GOV-EL-01-authority-structure` | `GOV-SUBSET-01-authority` |
| `GOV-EL-02-decision-rights-allocation` | `GOV-SUBSET-02-decision-rights` |
| `GOV-EL-03-legitimacy-basis` | `GOV-SUBSET-01-authority` |
| `GOV-EL-04-enforcement-mechanism` | `GOV-SUBSET-03-control` |
| `GOV-EL-05-escalation-logic` | `GOV-SUBSET-02-decision-rights` |
| `GOV-EL-06-oversight-construct` | `GOV-SUBSET-04-accountability` |
| `GOV-EL-07-compliance-mechanism` | `GOV-SUBSET-03-control` |
| `GOV-EL-08-informal-governance-overlay` | `GOV-SUBSET-01-authority` |

## Locked Rules

1. Each Governance element belongs to exactly one Governance L1 subset.
2. No Governance element may remain semantically unplaced after this freeze.
3. Existing GOV-EL root placement is historical and non-authoritative if it conflicts with this freeze.
4. Later OWL/TTL population must follow this placement freeze unless superseded by an explicit future governance decision.
5. Future cleanup may normalize file placement and markup, but may not alter semantic placement without a formal revision decision.

## Structural Rule

The following Governance element-to-subset mappings are frozen for the current vNext stabilization phase.

Each Governance element belongs to exactly one frozen Governance L1 subset.

## Cleanup Notes

The following non-blocking normalization issues were observed during reconciliation:

- `GOV-EL-03-legitimacy-basis.md` has a markup pattern inconsistent with the other GOV-EL files
- `GOV-SUBSET-02-decision-rights.md` appears to be missing `## Notes`

These should be corrected in the next controlled Governance normalization pass without changing meaning.

## Outcome

Governance L1 subset-to-element reconciliation is complete.

Governance is ready for controlled element-layer normalization against this frozen placement.