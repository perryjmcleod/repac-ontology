# REPAC vNext — Extension Register

This register is the single intake mechanism for proposed vNext additions. All entries must be reviewable, versioned, and modular. v1.0 semantics remain immutable.

## How to use

For each proposed addition, add one row to the table below. Keep entries minimal and explicit. If an entry cannot be justified without implying prescription or weakening Superset necessity, it does not belong in vNext.

## Intake rules (vNext)

1. **Additive only.** No changes to v1.0 semantics or artifacts.
2. **One purpose per entry.** Do not bundle unrelated changes.
3. **Normativity must be explicit.** Only `core-extension/` can be normative.
4. **Supersets remain mandatory.** No entry may imply a Superset is optional or bypassable.
5. **No prescription.** No workflows, stages, maturity models, or “best practice” encoding.
6. **Boundary discipline.** Every entry must state exclusions and non-goals.
7. **Reviewability.** Every entry must be implementable as a discrete PR-sized change.

## Register

| ID | Type | Target Superset | Proposed construct | Normative? | Rationale (analytical pressure) | Boundary / exclusions | v1.0 compatibility note | Pilot? | Status |
|---|---|---|---|---|---|---|---|---|---|
| VNEXT-0001 | Governance | All | Subset/Element eligibility criteria (gate) | No | Prevent decomposition drift; ensure resolution is justified by repeated analytical pressure | Not a decomposition itself; no changes to v1.0; no prescriptive heuristics | Documentation only; imports v1.0 conceptually | Yes | Proposed |
| VNEXT-0002 | Governance | All | Subset/Element design template | No | Ensure additions are comparable, bounded, and auditable across Supersets | Template is not semantics; no implied taxonomy | Documentation only; additive | Yes | Proposed |
| VNEXT-0003 | Pilot | (TBD) | Pilot decomposition for one Superset (minimal Subsets) | Yes | Prove controlled resolution can add explanatory power without weakening Supersets | No workflow; minimal set; no cross-Superset explosion | Implemented as vNext module importing v1.0 | Yes | Proposed |
| VNEXT-0004 | Formalization | All | vNext modularization conventions (imports, naming, namespaces) | No | Support reviewability and downstream reuse; prevent accidental override of v1.0 | Not a new theory; no semantic reinterpretation | Conventions + folder structure; additive | No | Proposed |
| VNEXT-0005 | Validation | All | SHACL guardrails: “no Superset bypass” checks | No | Enforce non-prescriptive stance and Superset necessity with machine-checkable constraints | SHACL only; does not add domain content | Validation layer only; additive | No | Proposed |
| VNEXT-0006 | Mapping | Work/Value/Governance | Mapping scaffold to standards (informative layer) | No | Practitioners need translation to familiar language (PM/BA/management) | Mappings are not equivalence; no dependency claims | Non-normative mapping module | No | Proposed |
| VNEXT-0007 | Applications | All | Worked case series template (v1.0-only baseline + vNext comparison) | No | Demonstrate why/when vNext adds value without turning REPAC into a method | No intervention guidance; analysis only | Docs only; additive | Yes | Proposed |

## Status values

Proposed, In Review, Approved, Implementing, Implemented, Deferred, Rejected
