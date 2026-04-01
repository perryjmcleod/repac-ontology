# vNext — Release Boundary

## Objective

Define the authoritative scope of the REPAC vNext release.

This file distinguishes between:

- **authoritative ontology components**
- **supporting or non-authoritative materials**

This prevents misinterpretation of incomplete or exploratory artifacts as part of the formal ontology.

---

## Authoritative Components (Release-Critical)

The following directories and files constitute the **authoritative REPAC vNext ontology**:

### Core Ontology

- `core-extension/`

Including:

- All superset definitions
- All subset definition files (`*-SUBSET-*`)
- All element definition files (`*-EL-*`)
- All L1 freeze, reconciliation, and placement files
- All OWL/TTL ontology files (`repac-*.owl`, `repac-*.ttl`)
- `ONTOLOGY-MODELING-EXCEPTIONS.md`
- `CROSS-SUPERSET-BOUNDARY-RULES.md`

### Ontology Semantics

These files define the formal structure, constraints, and interpretation rules of REPAC vNext.

They are considered:

- complete
- stable
- authoritative

---

## Non-Authoritative Components (Supporting / In-Progress)

The following directories are **not part of the formal ontology release**:

- `cases/`
- `application/`
- `pilot/`
- `validation/`
- `docs/`
- `mappings/`
- `domain-profiles/`
- `formalization/`

These may contain:

- incomplete material
- exploratory work
- placeholder-replaced content
- analytical examples
- future extensions

---

## Interpretation Rule

Only content within **core-extension** and associated ontology files must be treated as:

- semantically authoritative
- structurally binding
- aligned with REPAC vNext modeling rules

All other content must be interpreted as:

- illustrative
- experimental
- non-binding

---

## Constraints

- No authoritative meaning may be inferred from non-authoritative directories
- No subset, element, or structural rules may be derived from case or application materials
- Ontology interpretation must be grounded in core-extension artifacts only

---

## Outcome

STABLE