# VNEXT-0001 — Subset / Element Eligibility Criteria

## 1. Purpose
This document defines the necessary and sufficient eligibility criteria for introducing Subsets and Elements in REPAC vNext. It constrains decomposition to preserve REPAC’s analytical integrity, non-prescriptive stance, and v1.0 semantics.

## 2. Global Constraints (Inherited)
All Subsets and Elements MUST:
- Preserve Superset necessity and non-sufficiency
- Be descriptive, not directive
- Avoid sequencing, stages, workflows, or maturity implications
- Introduce no new semantics conflicting with v1.0
- Remain domain-agnostic unless explicitly declared as an extension

## 3. Subset Eligibility Criteria (ALL REQUIRED)
A construct MAY be introduced as a Subset IFF:

1. Analytical Necessity  
   Represents a recurring analytical dimension required to explain variation within the Superset.

2. Superset Dependence  
   Has no meaning independent of its parent Superset.

3. Non-Redundancy  
   Does not duplicate another Subset or any Superset.

4. Cross-Case Stability  
   Stable across cases and contexts.

5. Explanatory, Not Operational  
   Explains what must be accounted for, not how work is done.

6. Decomposability Potential  
   Can plausibly support future Element-level decomposition.

## 4. Element Eligibility Criteria (ALL REQUIRED)
A construct MAY be introduced as an Element IFF:

1. Atomic Analytical Unit  
   Cannot be meaningfully decomposed further.

2. Subset Anchoring  
   Belongs to exactly one Subset.

3. Observable or Inferable  
   Can be identified or evidenced in analysis.

4. Non-Procedural  
   Does not encode actions, steps, roles, or decisions.

5. No Normative Force  
   Does not imply correctness, quality, or desirability.

## 5. Explicit Exclusions (Hard Guardrails)
Never eligible as Subsets or Elements:
- Roles or personas
- Activities or steps
- Capabilities or competencies
- Best practices or anti-patterns
- Metrics or KPIs
- Maturity levels or stages

## 6. Governance Rule
Eligibility decisions are structural, not convenience-based.  
Failure of any criterion disqualifies the construct.
