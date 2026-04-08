# vNext — Protégé Verification Checklist

## Objective

Verify that the REPAC vNext ontology loads correctly, behaves as expected, and reflects the authoritative model without structural or semantic anomalies.

---

## Phase 1 — File Load Validation

### Load Strategy

- [ ] Open Protégé
- [ ] Load each `.ttl` file individually
- [ ] Load each `.owl` file individually

### Expected Result

- [ ] No load errors
- [ ] No missing namespace issues
- [ ] No unresolved references

---

## Phase 2 — Class Hierarchy Verification

### Superset Layer

- [ ] All 9 supersets appear as `owl:Class`:
  - Source
  - Collaboration
  - Governance
  - Purpose
  - Value
  - Communication
  - Imperative
  - Scope
  - Work

### Subset Layer

- [ ] Each superset contains the correct subsets
- [ ] Subsets are direct subclasses of their superset
- [ ] No extra or missing subsets exist

---

## Phase 3 — Element Layer Verification

### Governance

- [ ] All 8 Governance elements appear
- [ ] Each element is under the correct subset:
  - Authority
  - Decision Rights
  - Control
  - Accountability
- [ ] No element appears at the superset level

### Work (Critical Exception)

- [ ] All 4 Work elements appear:
  - Execution
  - Validation
  - Inquiry
  - Configuration
- [ ] All Work elements are subclasses of `Work`
- [ ] No Work elements appear under subsets

---

## Phase 4 — Structural Integrity

### Pattern Enforcement

- [ ] Subset-terminal supersets contain NO elements:
  - Source
  - Collaboration
  - Purpose
  - Value
  - Communication
  - Imperative
  - Scope

### Hierarchy Cleanliness

- [ ] No orphan classes exist
- [ ] No duplicate class names exist
- [ ] No unintended subclass relationships exist

---

## Phase 5 — Annotation Verification

### Labels

- [ ] Every class has a readable `rdfs:label`

### Comments

- [ ] Every class has a meaningful `rdfs:comment`
- [ ] Comments align with subset definitions (no drift)

---

## Phase 6 — Reasoner Check (HermiT)

### Execution

- [ ] Start HermiT reasoner
- [ ] Precompute class hierarchy

### Expected Result

- [ ] No inconsistencies detected
- [ ] No unsatisfiable classes
- [ ] No unexpected inferred relationships

---

## Phase 7 — Cross-File Consistency

### TTL vs OWL

- [ ] TTL and OWL versions show identical class structures
- [ ] No classes appear in one format but not the other

---

## Phase 8 — Visual Inspection

### Class Tree

- [ ] Hierarchy is intuitive and readable
- [ ] Superset → Subset → Element relationships are clear

### Spot Checks

- [ ] Open random classes and verify:
  - correct label
  - correct comment
  - correct parent

---

## Phase 9 — Final Sanity Check

- [ ] No structural surprises observed
- [ ] No modeling contradictions discovered
- [ ] Ontology reflects intended REPAC vNext design

---

## Outcome

- PASS → Ontology is validated and ready for viewer/tool layer
- FAIL → Fix issues before proceeding