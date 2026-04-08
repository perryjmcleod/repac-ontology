# REPAC vNext — Interrogative Derivation Rules

## Objective

Define the formal rules governing how the REPAC viewer/tool layer derives answers to the six interrogatives:

- Who
- What
- When
- Where
- Why
- How

These interrogatives are **not ontology constructs**. They are a **derived interpretive layer** composed from existing REPAC supersets.

## Scope

This document governs:

- how interrogatives are mapped to supersets
- how viewer logic composes responses
- what is allowed and disallowed in derivation
- guardrails to prevent ontology drift

## Governing Principle

The interrogative layer must:

- **compose meaning from ontology**
- **never introduce new ontology structure**
- **never reinterpret ontology semantics**

The viewer answers questions by traversing REPAC structure, not by inventing it.

---

## Interrogative Mapping

Each interrogative maps to one or more supersets.

| Interrogative | Primary Supersets | Interpretation |
|--------------|------------------|----------------|
| Who | Governance, Collaboration | Authority, participation, and actor structure |
| What | Work, Value | Execution and resulting outcomes |
| Why | Purpose, Value | Intentional and declared purpose |
| How | Work, Communication | Execution method and expression |
| When | Scope (interval) | Temporal positioning |
| Where | Scope (boundary, perspective) | Contextual boundaries and viewpoints |

---

## Derivation Model

The viewer must derive interrogatives using **structured traversal**, not inference.

### Step 1 — Identify Source Entity

Input:

- superset
- subset
- or element

The entity must include:

- canonical ID
- parent relationship
- superset membership

---

### Step 2 — Determine Relevant Supersets

Using the interrogative mapping table:

- identify which supersets contribute to each interrogative
- include the source entity’s own superset where applicable

---

### Step 3 — Traverse Ontology Structure

The viewer may use:

- parent relationships
- child relationships
- sibling relationships (within same parent)
- cross-superset boundary links (authoritative only)

The viewer must NOT:

- create new relationships
- assume implicit connections not present in ontology or boundary-rule documents

---

### Step 4 — Aggregate Results

For each interrogative:

- collect related entities from mapped supersets
- preserve:
  - canonical IDs
  - labels
  - comments
  - provenance where applicable

---

### Step 5 — Present Without Mutation

The viewer must:

- present results grouped by interrogative
- maintain traceability to source ontology entities
- avoid summarizing in ways that alter meaning

---

## Interrogative Definitions

### WHO

Derived from:

- Governance (authority, decision rights, accountability)
- Collaboration (participation structure)

Represents:

- actors
- roles
- authority holders
- participants

---

### WHAT

Derived from:

- Work (execution)
- Value (outcomes)

Represents:

- actions being performed
- outputs produced
- outcomes realized

---

### WHY

Derived from:

- Purpose (intentional, declarative)
- Value (inherent, instrumental)

Represents:

- reason for existence
- intended outcomes
- justification for action

---

### HOW

Derived from:

- Work (execution method)
- Communication (formal, informal expression)

Represents:

- how work is performed
- how actions are communicated or expressed

---

### WHEN

Derived from:

- Scope (interval)

Represents:

- timing
- sequencing
- duration
- event triggers

---

### WHERE

Derived from:

- Scope (boundary, perspective)

Represents:

- organizational boundaries
- contextual limits
- viewpoints or perspectives

---

## Allowed Derivation Inputs

The viewer may use:

- ontology hierarchy (superset → subset → element)
- authoritative boundary-rule documents
- modeling exception documents (for clarification only)
- release-boundary classifications (for labeling only)

---

## Disallowed Behaviours

The viewer must not:

1. introduce new ontology entities
2. create synthetic relationships between entities
3. infer meaning not explicitly supported by ontology or authoritative documents
4. collapse multiple supersets into a single interpreted construct
5. present derived summaries as ontology truth

---

## Derived Output Classification

All interrogative outputs must be marked:

- `artifactType: derived_navigation`
- `authoritative: false`

This ensures:

- clear separation from ontology
- no ambiguity in interpretation

---

## Traceability Requirement

Each derived item must maintain:

- reference to source entity ID
- reference to originating superset
- optional link to source file

The viewer must allow users to navigate back to the original ontology entity.

---

## Guardrail Statement

The interrogative layer is:

- a **compositional lens**
- not a modeling layer
- not a taxonomy
- not an ontology extension

Any requirement that suggests:

- adding interrogative fields to ontology
- restructuring supersets for interrogative clarity
- introducing cross-superset shortcuts

must be rejected or routed through formal ontology governance.

---

## MVP Implementation Guidance

For initial release:

- implement interrogatives as:
  - tabs or sections on entity pages
- populate using:
  - direct relationships
  - parent/child traversal
  - boundary-rule references only

Do not implement:

- semantic inference
- ranking or weighting
- AI-generated summaries
- predictive linking

---

## Future Extension (Non-Authoritative)

Future enhancements may include:

- case-based interrogative walkthroughs
- guided learning paths
- comparative interrogative analysis across entities

These must remain:

- derived
- non-authoritative
- clearly separated from ontology structure

---

## Authority

This document is authoritative for all interrogative derivation behavior in the REPAC viewer/tool layer.