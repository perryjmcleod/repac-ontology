# Governance Element Mapping Decision

## Objective
Establish the authoritative subset-to-element mapping for Governance element population in REPAC vNext OWL/TTL.

## Constraints
- No conceptual expansion
- No ontology drift
- Governance L1 subset freeze is authoritative
- Each Governance element will be assigned to one primary subset for initial OWL population
- Cross-cutting semantics, if needed, will be handled later and not during pilot scaffold population

## Governing Rule
Each Governance element is mapped to the single Governance subset that best represents its primary analytical role within the frozen REPAC vNext structure.

## Authoritative Governance Element Mapping

### Authority
- GOV-EL-01-authority-structure
- GOV-EL-03-legitimacy-basis

### Decision Rights
- GOV-EL-02-decision-rights-allocation
- GOV-EL-05-escalation-logic

### Control
- GOV-EL-04-enforcement-mechanism
- GOV-EL-07-compliance-mechanism

### Accountability
- GOV-EL-06-oversight-construct
- GOV-EL-08-informal-governance-overlay

## Result
PASS — Governance element placement established for pilot OWL population.

## Consequence
Governance OWL population may now proceed by modelling each element as an owl:Class under its mapped subset using rdfs:subClassOf.