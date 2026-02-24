# SCOPE-L1-SUBSETS.md
## Scope Superset — Level 1 Controlled Subsets

### Authority
This document defines the controlled Subsets of the Scope Superset at Level 1 (L1). These Subsets are structural and non-normative. They define the geometry of analytical delimitation and do not encode value judgement, governance authority, or domain-specific content.

A complete Scope assertion requires the following Subsets:
1. Perspective (SCOPE-EL-01)
2. Boundary (SCOPE-EL-02)
3. Granularity (SCOPE-EL-03)
4. Interval (SCOPE-EL-04)

Inclusion and Exclusion are properties of Boundary and are not independent Subsets.

## 1. Perspective

### Definition
Perspective is the analytical vantage that determines the class of entities eligible to be bounded and examined. It specifies what type of entity is under consideration (for example, process, organizational unit, output, event, defect) prior to boundary assertion.

Perspective conditions analysis but does not itself partition entities.

### What It Is Not
Perspective is not a value judgement, a goal statement, governance authority, stakeholder preference, or “context” treated as a first-class construct.

### Structural Role
Perspective determines what category of entities may be included or excluded and what counts as analytically relevant. Two analysts may assert different, internally coherent boundaries over the same situation due to differing Perspectives without either being structurally incorrect.

## 2. Boundary

### Definition
Boundary is the structural partition that defines what is inside versus outside the asserted scope, given a selected Perspective, Granularity, and Interval.

Boundary produces Inclusion and Exclusion as partition outcomes.

### What It Is Not
Boundary is not governance control, ownership, accountability, authority, or an enforcement mechanism.

### Structural Role
Boundary delimits the analytical universe, defines the set of entities subject to evaluation, and makes exclusion explicit. If exclusion cannot be stated, Boundary is underspecified.

Boundary remains singular at L1 and is not subtyped (for example, “organizational boundary,” “functional boundary”). Such distinctions are determined by Perspective.

## 3. Granularity

### Definition
Granularity is the resolution at which in-scope entities are treated and analyzed. It specifies the level of analytical detail applied to entities admitted by Boundary under the selected Perspective.

Granularity operates independently of Perspective.

### What It Is Not
Granularity is not hierarchical level as a separate construct, authority level, or organizational rank. “Level” collapses into Granularity unless independently justified.

### Structural Role
Granularity determines analytical resolution, explains disagreement caused by resolution mismatch, and enables coarse and fine analyses of the same bounded set. Granularity does not alter what is included; it alters how included entities are examined.

## 4. Interval

### Definition
Interval is the temporal span within which the asserted Scope is considered analytically valid. It specifies the beginning, end, or snapshot conditions under which the boundary applies.

Interval is required for coherent analysis. If omitted, it is implicitly assumed.

### What It Is Not
Interval is not schedule, milestone plan, deadline, risk window, or governance duration.

### Structural Role
Interval constrains the temporal applicability of the asserted Boundary, enables comparison across time, and prevents hidden temporal assumptions. The same Perspective, Boundary, and Granularity applied to different Intervals may yield different interpretations without structural contradiction.

## Persona Usability Check (Non-normative)

### UML / Business Analyst
Maps cleanly to modelling practice: selecting model vantage (Perspective), system boundary (Boundary), model resolution (Granularity), and analysis window (Interval).

### Project Manager
Usable with one caution: Interval must be kept distinct from schedule mechanics. Interval specifies the analysis window, not planning artefacts.

### Operational Supervisor
Applies naturally to responsibility boundary, task-level detail, and “during rollout vs steady state” windows.

### Executive Sponsor
Usable when stated plainly: strategic vs operational vantage, enterprise vs unit boundary, KPI-level vs operational detail, and quarter/year windows.

## Status
Scope L1 Subsets are frozen as: Perspective, Boundary, Granularity, Interval. This definition is structural, non-prescriptive, and intended for formalization.
