# How to Read the REPAC Ontology (v1.0)

This repository contains the formal artifacts of the REPAC Ontology, an applied analytical ontology designed to support disciplined reasoning about organizational work, failure, and value creation.

REPAC is not intended to be read linearly, nor is it a prescriptive framework. Reviewers are encouraged to approach it as a structured analytical model whose primary contribution lies in its boundary discipline, compositional structure, and formal constraints.

This document explains how to read and evaluate the ontology correctly.

---

## What REPAC Is

REPAC is a domain-independent analytical ontology that provides:

- A stable set of analytical Supersets representing necessary dimensions of organizational work
- Explicit Subset structures that define the internal scope of each Superset
- Clear boundaries between conceptual domains that are often conflated in practice
- A formal structure suitable for post hoc analysis, diagnosis, and comparative reasoning
- OWL and SHACL artifacts that encode structural constraints rather than behavioral prescriptions

REPAC supports reasoning about work outcomes by analyzing interactions among dimensions, not by attributing causality to isolated factors.

---

## What REPAC Is Not

REPAC is explicitly not:

- A workflow model
- A process framework
- A maturity model
- A capability model
- A best-practice catalog
- A performance scorecard
- A prescriptive methodology

REPAC does not describe how work should be performed.  
It describes how work can be analyzed.

---

## Intended Evaluation Criteria

When reviewing REPAC v1.0, evaluation should focus on:

1. Conceptual clarity and boundary discipline at the Superset level  
2. Structural coherence and non-overlap at the Subset level  
3. Internal consistency between diagrams and formal ontology artifacts  
4. Appropriateness of OWL representations for analytical use  
5. Use of SHACL constraints as governance mechanisms rather than semantic logic  

Reviewers should not evaluate REPAC v1.0 on the basis of:

- Exhaustiveness of Elements
- Domain-specific applicability
- Predictive or causal claims
- Operationalization or implementation guidance

These are intentionally out of scope for v1.0.

---

## Superset and Subset Structure

REPAC v1.0 defines structure at two authoritative conceptual levels:

- **Supersets**, which establish the necessary analytical dimensions
- **Subsets**, which define the internal structure and scope of each Superset

Superset and Subset diagrams are canonical artifacts and should be evaluated together. Subset diagrams complete the structural commitment of v1.0 by clarifying internal boundaries without expanding to the Element level.

Element-level expansion is intentionally deferred.

---

## How the Repository Is Organized

The repository is organized around authoritative artifacts rather than narrative flow.

Key directories:

- `/ontology`  
  Formal OWL, RDF, and TTL representations of the ontology

- `/diagrams`  
  Canonical Superset and Subset diagrams defining the conceptual structure

- `/governance`  
  Modeling decisions, constraints, and rationale documents

- `/validation`  
  SHACL shapes used to enforce structural integrity

- `/paper`  
  The submission-ready manuscript and supporting publication artifacts aligned to the ontology; included for theoretical grounding and reviewer context, not as a source of authoritative definitions

- `/docs`  
  Reviewer-facing documentation and interpretive guides

The authoritative definition of REPAC v1.0 consists only of the ontology files, canonical diagrams, and governing documentation. Supporting text is explanatory, not normative.

---

## Recommended Reading Order for Reviewers

A reviewer new to REPAC is encouraged to proceed as follows:

1. Read the repository `README.md` for scope and authority
2. Review the REPAC Top Layer diagram to understand Superset structure
3. Review Subset diagrams for each Superset
4. Read the accompanying paper for theoretical grounding
5. Inspect Superset- and Subset-level OWL files for formal alignment
6. Review SHACL shapes for governance discipline
7. Consult governance documents for modeling rationale

This order mirrors how the ontology was designed and stabilized.

---

## Version Scope and Immutability

REPAC v1.0 is structurally complete at the Superset and Subset levels, with both levels defined through canonical diagrams and formal ontology artifacts.

Element-level expansion, domain extensions, and applied instantiations are intentionally deferred to future versions. No new Supersets or Subsets will be introduced in v1.x.

This versioning discipline preserves analytical stability.

---

## How to Cite REPAC

Citation guidance is provided in the repository root. Reviewers should cite the ontology version explicitly and treat it as a stable analytical artifact.

---

## Final Note to Reviewers

REPAC should be evaluated as an ontology, not as a framework competing with execution models.

Its contribution lies in what it prevents as much as in what it enables.
