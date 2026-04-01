# WORK ↔ COLLABORATION — Cross-Superset Integrity Audit

## Objective

Confirm a disciplined separation between:

* **Work** as executable action
* **Collaboration** as the structured or emergent interaction between actors working together

This audit ensures that collaborative interaction is not misclassified as execution, and execution is not misclassified as collaboration.

---

## Constraints

* No conceptual expansion
* No ontology drift
* No new supersets
* No subset restructuring
* No OWL/TTL redesign
* Treat all previously frozen subsets and elements as authoritative

---

## Locked Inputs

### Work

**Subsets**

1. `WORK-SUBSET-01-defined`
2. `WORK-SUBSET-02-emergent`

**Element Type**

* `WORK-EL`

---

### Collaboration

**Status**

Collaboration is an element-bearing superset (structure previously stabilized at L1).

**Expected Role**

Represents:

* Multi-actor interaction
* Joint effort structures
* Cooperative or coordinated engagement patterns

---

## Core Boundary Definition

### Work

Represents:

* Execution
* Tasks and activities
* Actions that produce outcomes

### Collaboration

Represents:

* Interaction between actors
* Joint engagement in a shared context
* The relational structure through which work may occur

---

## Structural Boundary Rule

**Work models execution. Collaboration models how multiple actors engage with each other around execution.**

---

## Audit Tests and Results

### 1. Superset Separation Test

**Question**

Do Work and Collaboration remain conceptually distinct?

**Result**

PASS

* Work = doing
* Collaboration = interacting

---

### 2. Execution vs Interaction Test

This is the critical boundary.

### Work must not absorb:

* Interaction structures
* Team dynamics
* Coordination relationships
* Participation patterns

### Collaboration must not absorb:

* The task itself
* The execution of activities
* Outcome-producing action

---

### Example Distinction

* “Build project plan” → Work
* “Team works together to build plan” → Collaboration + Work
* “Discuss project plan” → Collaboration (and Communication), not Work

---

**Result**

PASS

**Interpretive Rule**

* Execution belongs to Work
* Interaction between actors belongs to Collaboration

---

### 3. Subset-Level Separation Test

### Work subsets

* `defined` → planned execution
* `emergent` → adaptive execution

### Collaboration (conceptual)

* Does not classify execution
* Classifies interaction structure between actors

---

**Result**

PASS

No structural overlap.

---

### 4. Element Contamination Risk Test

---

#### Drift Risk A: “Teamwork = Work”

Incorrect.

* Work → the task
* Teamwork → Collaboration

---

#### Drift Risk B: “Working session = Work”

Usually incorrect.

* Session → Collaboration (and Communication)
* Output of session → Work

---

#### Drift Risk C: “Coordination = Collaboration vs Work”

Split case.

* Coordination activity → may involve Work
* Interaction enabling coordination → Collaboration

---

#### Drift Risk D: “Joint task = Collaboration”

Incomplete.

* Task → Work
* Multiple actors performing it → Collaboration + Work

---

#### Drift Risk E: “Participation = Work”

Incorrect.

* Participation → Collaboration
* Contribution → Work

---

**Result**

PASS with guardrails

---

## Cross-Superset Relationship Model

### Correct Interpretation

* Collaboration may **enable Work**
* Collaboration may **shape how Work is performed**
* Collaboration may **distribute Work across actors**

But:

* Collaboration is not Work
* Work is not Collaboration

---

### Valid Relations

* Work may be **performed collaboratively**
* Work may be **distributed across collaborators**
* Collaboration may **coordinate Work across actors**

---

### Invalid Relations

* Interaction is not execution
* Participation is not task completion
* A team is not a task

---

**Result**

PASS

---

## Special Boundary Cases

### Case 1 — Pair Work / Team Work

* Task → Work
* Joint execution → Collaboration + Work

---

### Case 2 — Workshops

* Interaction → Collaboration
* Outputs (e.g., artifacts) → Work

---

### Case 3 — Coordination

* Interaction patterns → Collaboration
* Execution of coordination tasks → Work

---

### Case 4 — Emergent Work vs Emergent Collaboration

Potential confusion.

* Emergent Work → new or adaptive execution
* Emergent Collaboration → new or adaptive interaction patterns

---

**Rule**

* Emergence of action → Work
* Emergence of interaction → Collaboration

---

**Result**

PASS

---

## Integrity Findings

1. Work and Collaboration remain structurally distinct
2. No subset restructuring required
3. No element remapping required
4. Collaboration frequently co-occurs with Work but does not become Work
5. Work may be individual or collaborative without changing its classification
6. Highest-risk overlap occurs in teamwork, workshops, and coordination
7. Interaction vs execution is the defining boundary

---

## Correction Decisions (Locked)

### CD-01 — Core Distinction

Work models execution.
Collaboration models interaction between actors.

---

### CD-02 — Interaction Rule

Interaction between actors belongs to Collaboration, not Work.

---

### CD-03 — Joint Execution Rule

A task performed by multiple actors remains Work, while the interaction between them is Collaboration.

---

### CD-04 — Co-Occurrence Rule

Work and Collaboration may co-occur but must not be modeled as the same construct.

---

### CD-05 — Participation Rule

Participation is Collaboration.
Contribution to task execution is Work.

---

### CD-06 — Emergence Rule

Emergent Work refers to execution.
Emergent Collaboration refers to interaction patterns.

---

## Audit Result

**Status:** PASS

**Outcome:**

* Structural separation is sound
* No refactor required
* No subset or element changes required

---

## Required Action

Lock these boundary rules to prevent:

* work/collaboration collapse
* misclassification of teamwork as execution
* semantic drift during later modelling phases

---

## Repository Impact

* No file movement required
* No element reassignment required
* No subset modification required

---

## Conclusion

Work and Collaboration are tightly coupled but fundamentally distinct:

* Work = execution
* Collaboration = interaction

Maintaining this separation preserves analytical clarity across REPAC.

---
