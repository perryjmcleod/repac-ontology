# SCOPE-SUBSET-04-Interval

## Definition
Interval is the temporal span within which the asserted Scope is considered analytically valid. It specifies the beginning, end, or snapshot conditions under which the boundary applies.

## Role in Scope L1
Interval constrains the temporal applicability of the asserted Boundary, prevents hidden temporal assumptions, and enables comparison across time.

## Analytical Tests
- What time window is the analysis asserting (start, end, or snapshot)?
- Would the same Perspective, Boundary, and Granularity yield a different interpretation under a different Interval?

## Non-Equivalences
Interval is not:
- a schedule, milestone plan, deadline, risk window, or governance duration
- planning artefacts used to manage work

## Formal Anchor
Ontology class: `repac:Interval`