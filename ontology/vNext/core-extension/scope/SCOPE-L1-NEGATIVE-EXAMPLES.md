# Scope Superset  
## Layer-1 Negative Examples (Drift Prevention)  
### Purpose: Enforce Non-Prescriptive, Non-Colliding Boundaries  
### Status: Active Guardrail Document

---

## Enforcement Rule

If a Scope statement contains any of the below semantic patterns,
it must be revised before Layer-1 freeze.

Scope bounds consideration.
It does not:
- justify,
- mandate,
- control,
- execute,
- prioritize,
- enforce,
- decompose,
- or evaluate.

---

# 1. Inclusion Boundary — Prohibited Drift

## ❌ Do NOT Write:

- “What matters most”
- “What should be considered”
- “What must be included”
- “Key stakeholders”
- “Primary stakeholders”
- “Critical components”
- “Required elements”
- “Core deliverables”
- “Necessary steps”

## Why Prohibited

These shift Inclusion into:
- **Purpose** (teleology: what matters)
- **Imperative** (must/should)
- **Work** (steps/deliverables)
- **Governance** (requirements)

## Replace With

- “In-frame”
- “Treated as eligible for consideration”
- “Within the analytical frame”

---

# 2. Exclusion Boundary — Prohibited Drift

## ❌ Do NOT Write:

- “Not allowed”
- “Prohibited”
- “Non-compliant”
- “Out of policy”
- “Should not”
- “Improper”
- “Invalid”

## Why Prohibited

These encode:
- **Governance enforcement**
- **Imperative prohibition**
- Normative judgement

Exclusion is not punishment.
It is analytic delimitation.

## Replace With

- “Out-of-frame”
- “Not treated as part of this analytic surface”
- “Excluded from the current explanatory boundary”

---

# 3. Granularity Level — Prohibited Drift

## ❌ Do NOT Write:

- “Break down into tasks”
- “Step-by-step”
- “Detailed execution plan”
- “Work breakdown”
- “Operational layers”
- “Implementation stages”
- “Maturity level”

## Why Prohibited

These collapse Granularity into:
- **Work decomposition**
- **Method modelling**
- **Process sequencing**

Granularity is resolution, not execution structure.

## Replace With

- “Resolution treated as”
- “Level of explanation”
- “Analytical resolution”

---

# 4. Actor Boundary — Prohibited Drift

## ❌ Do NOT Write:

- “Responsible for”
- “Accountable for”
- “Authorized to”
- “Reports to”
- “Owns”
- “RACI”
- “Governance body”
- “Decision rights”

## Why Prohibited

These encode:
- **Governance (authority/control)**
- **Work (role-task assignment)**
- **Imperative (obligation)**

Actor Boundary identifies who is considered,
not who controls or executes.

## Replace With

- “Actors considered in-frame”
- “Actor category treated as part of the analytic surface”

---

# 5. Artefact Boundary — Prohibited Drift

## ❌ Do NOT Write:

- “Required documentation”
- “Mandated artefacts”
- “Deliverables”
- “Approval forms”
- “Compliance record”
- “Project documentation”
- “Artifacts to be produced”

## Why Prohibited

These collapse Artefact Boundary into:
- **Work outputs**
- **Governance mandates**

Artefact Boundary identifies objects considered,
not required outputs.

## Replace With

- “Artefacts treated as part of the analytic frame”
- “Objects considered”

---

# 6. Constraint Boundary — Prohibited Drift (Highest Risk)

## ❌ Do NOT Write:

- “Must comply with”
- “Policy requires”
- “Legally obligated”
- “Mandatory”
- “Not permitted”
- “Governed by”
- “Enforced by”
- “Due to budget limitations” (if framed causally)
- “Because leadership decided”

## Why Prohibited

These drift into:
- **Imperative (obligation)**
- **Governance (control/rule)**
- **Purpose (justification)**
- **Context reification**

Constraint Boundary captures:
Limiting conditions treated as delimiters for analysis.

It does not encode:
- rule enforcement,
- obligation,
- or causation claims.

## Replace With

- “Treated as a limiting condition”
- “Captured as a boundary condition”
- “Operates as a delimiter within the analytic frame”

---

# Final Freeze Condition

Layer-1 Scope cannot freeze unless:

- No negative examples appear in definitions.
- No subset encodes:
  - teleology,
  - obligation,
  - workflow,
  - authority,
  - enforcement,
  - or context as object.
- All case instantiations survive negative-pattern audit.

---

Status: ACTIVE DRIFT PREVENTION
