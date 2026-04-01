# ONTOLOGY — Modeling Exceptions

## Objective

Document intentional deviations from the canonical REPAC vNext modeling pattern.

This file exists to prevent misinterpretation during future audits, normalization passes, and extensions of the ontology.

## Canonical Modeling Pattern

The default REPAC vNext modeling pattern is:

- Superset → `owl:Class`
- Subset → `owl:Class`, `rdfs:subClassOf` Superset
- Element → `owl:Class`, `rdfs:subClassOf` Subset

This pattern applies unless explicitly overridden and documented in this file.

---

## Exception 01 — Work Element Placement

### Description

Work elements are modeled at the **superset level**, not under subsets.

### Standard Pattern (Not Used for Work)


### Work Pattern (Authoritative)


### Affected Elements

- `WORK-EL-01-execution`
- `WORK-EL-02-validation`
- `WORK-EL-03-inquiry`
- `WORK-EL-04-configuration`

### Rationale

The Work superset defines element constructs as **shared types**, not subset-specific entities.

From the authoritative Work freeze:

- Elements are shared across contexts
- Elements are not exclusive to subsets
- Subsets define **context of execution**, not element type

Therefore:

- Duplicating elements under subsets would introduce ontology drift
- Subset-specific element placement would violate boundary rules
- Element identity must remain invariant across Defined and Emergent contexts

### Constraint

- Work elements must not be duplicated under subsets
- Work elements must not be split into subset-specific variants
- Subsets must not be interpreted as containers of element types

### Integrity Rule

Work elements are **contextually interpreted through subsets**, not structurally placed within them.

---

## Exception 02 — Subset-Terminal Supersets

### Description

Certain supersets are explicitly **non-element-bearing** and must not contain an element layer.

### Affected Supersets

- Source
- Collaboration
- Purpose
- Value
- Communication
- Imperative
- Scope

### Rationale

These supersets function as **analytical lenses**, not compositional structures.

Introducing elements would:

- create artificial decomposition
- violate cross-superset boundary rules
- introduce ontology drift

### Constraint

- No `*-EL-*` classes may exist within these supersets
- No future expansion may introduce element layers without explicit reclassification

---

## Exception 03 — Scope-Relative Interpretation (Source)

### Description

Source subsets (`internal`, `external`) are **scope-relative**, not absolute categories.

### Rationale

Source is interpreted through the Scope superset, specifically:

- `SCOPE-SUBSET-02-boundary`

Therefore:

- Internal vs External is determined by analytical boundary
- The same source may be internal or external depending on scope definition

### Constraint

- Source must not be interpreted as a fixed taxonomy
- Source must not be reified into absolute categories
- Boundary must remain the controlling construct

### Integrity Rule

Source classification is dependent on Scope and must remain analytically relative.

---

## Exception 04 — Minimal Ontology Annotation

### Description

REPAC vNext intentionally uses **minimal OWL annotation**.

### Allowed Annotations

- `rdfs:label`
- `rdfs:comment`

### Excluded (by design)

- Object properties
- Data properties
- Restrictions
- Disjoint axioms
- Individuals

### Rationale

The ontology is designed as a **structural semantic model**, not a fully axiomatized reasoning system.

This ensures:

- clarity of hierarchy
- inspectability
- alignment with analytical intent
- reduced risk of unintended inference

### Constraint

Additional OWL constructs must not be introduced without a formal modeling phase.

---

## Integrity Check

- All exceptions are intentional and documented
- No exception introduces conceptual expansion
- No exception violates cross-superset boundary rules
- Exceptions preserve semantic clarity and structural integrity

---

## Outcome

STABLE
