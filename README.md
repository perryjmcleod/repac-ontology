# REPAC Ontology

This repository contains the formal ontology, diagrams, and supporting artifacts for the REPAC Framework. REPAC is a structured analytical ontology for purpose-driven analysis, decision-making, and value realization in complex organizational systems.

The ontology is designed to support rigorous reasoning about why work succeeds or fails across governance, scope, communication, collaboration, and value systems. It is not a workflow, process model, or execution framework.

## Scope of This Repository

This repository includes:

- Conceptual diagrams defining REPAC Supersets, Subsets, Sets, and Elements  
- Formal OWL, RDF, and TTL representations of the ontology  
- Supporting governance decisions, boundary definitions, and modeling constraints  
- Materials supporting academic publication and pedagogical use  

This repository does not contain:

- Implementation-specific tooling  
- Domain-specific extensions (these will be maintained in separate repositories)  
- Training courseware or marketing assets  

## Status

Current version: **v1.0**

REPAC v1.0 is a stable conceptual release. The ontology structure is locked at the Superset and Subset level. No semantic changes will be made to v1.0. Clarifications may appear in patch versions, while structural or conceptual changes require a new major version.

Readers should treat v1.0 as a deliberate and frozen design state suitable for citation, review, and critique.

## How to Read the REPAC Ontology

The REPAC Ontology is a conceptual and analytical ontology designed to model how organizational failure, misalignment, and value erosion occur across purpose, governance, work, and communication systems. It is not a process model, workflow engine, maturity model, or performance framework.

This section explains how to interpret the ontology correctly.

### What REPAC Is

REPAC is a structural reasoning framework that models why work succeeds or fails rather than how work should be executed. It separates intention, constraint, execution, and valuation into distinct analytical domains. The ontology supports failure analysis, diagnosis, and post-hoc reasoning across organizational systems.

REPAC is method-agnostic and tool-independent by design.

### What REPAC Is Not

REPAC does not prescribe workflows, best practices, or methodologies. It does not replace domain-specific frameworks such as project management, business analysis, learning and development, or IT service management. It does not model individual tasks, procedures, tools, or roles, and it is not a maturity model or scorecard.

Any interpretation of REPAC as an execution framework is a misuse of the ontology.

### Supersets as Analytical Domains

At the top level, REPAC is organized into Supersets. Each Superset represents a distinct analytical domain, not a phase, step, or lifecycle stage. Supersets answer different classes of questions, such as why work exists, what constrains it, what work is being performed, and what value is produced or lost.

Supersets are not interchangeable and should not be collapsed into one another.

### Scope as a Lens

REPAC treats Scope as a lens rather than a source. Internal and External Scope constructs define boundaries of applicability, not origins of causation. They do not create work, value, or governance. Instead, they constrain where those constructs apply.

This design choice is intentional and differs from many traditional enterprise and architecture models.

### Directionality and Dependency

Relationships in REPAC are directional and intentional. Governance constrains work; it does not generate it. Work produces value; value does not precede work. Purpose justifies work; it does not perform it.

Circular causality is avoided unless explicitly stated and analytically justified.

### Diagrams and Ontology Files

Diagrams are the primary human-readable representation of REPAC. TTL and OWL files provide the formal, machine-readable encoding. Diagrams and ontology files are semantically aligned. Neither introduces unique meaning.

If a construct appears in a diagram, it must exist in the ontology files, and vice versa.

### Intended Use

REPAC is intended for organizational failure analysis, post-incident reviews, governance and accountability audits, cross-domain alignment reasoning, and the teaching of analytical thinking about work systems.

It is not intended for operational execution.

## Author

Perry J. McLeod  
Author of *The Complete Guide to Requirements Management Using the REPAC Framework*
