# REPAC vNext — Viewer Export Contract

## Objective

Define the authoritative export contract governing how REPAC vNext ontology and related governance documents are transformed into viewer-consumable artifacts.

This contract establishes a strict one-way relationship:

Ontology layer → Generated viewer data → Viewer/tool layer

The viewer/tool layer is a projection of authoritative materials. It is not an authoring surface and must not drive ontology changes.

## Scope

This contract governs:

- ontology entity export
- document export
- derived navigation export
- interrogative derivation
- artifact typing
- provenance requirements
- guardrails preventing ontology drift from UI pressure

## Governing Principles

### 1. Ontology is the source of truth

All ontology classes, hierarchy, labels, comments, and structural relationships originate from authoritative REPAC OWL/TTL files and explicitly authorized ontology governance documents.

### 2. Export is one-way

Export artifacts are generated from authoritative materials. Generated artifacts must not be manually edited as a substitute for ontology change.

### 3. Derived layers are non-authoritative

Navigation, search, routing, and interrogative views are implementation layers. They must never be treated as ontology truth.

### 4. Adjacent documents remain explicitly typed

Boundary rules, modeling exceptions, release-boundary materials, and future case/application materials may be exposed through the viewer, but must remain explicitly typed as governance or release artifacts unless formally modeled in the ontology.

### 5. Canonical identifiers govern joins

All viewer joins, references, and traceability must use canonical REPAC IDs, not labels, slugs, or URLs.

## Export Package Structure

Generated viewer artifacts must be emitted under:

viewer/generated/

Recommended structure:

- manifest.json
- ontology-index.json
- supersets/
- documents/
- navigation/
- cases/ (reserved for future use)

## Artifact Types

Every exported object must include `artifactType`.

Allowed values:

- ontology_superset
- ontology_subset
- ontology_element
- ontology_aggregate
- governance_document
- release_document
- derived_navigation
- interrogative_view
- case_artifact

## Base Required Fields

All exported objects must include:

- artifactType
- id
- slug
- label
- authoritative

Strongly recommended:

- comment
- status

## Status Vocabulary

Allowed values:

- draft
- frozen
- validated
- released
- deprecated

## Ontology Entity Export Rules

### Superset objects

Superset exports must include:

- canonical ID
- label
- comment
- provenance paths to OWL and TTL
- child subset IDs
- subset summaries

### Subset objects

Subset exports must include:

- canonical ID
- label
- comment
- parent superset ID
- child element IDs, if applicable
- hasElements flag

### Element objects

Element exports must include:

- canonical ID
- label
- comment
- parent subset ID

Only element-bearing supersets may emit element objects.

## Document Export Rules

Authoritative governance and release documents may be exported as typed document objects.

Document objects must include:

- id
- label
- sourcePath
- documentClass
- authoritative

Recommended fields:

- summary
- sections

Allowed documentClass values:

- boundary-rules
- modeling-exceptions
- release-boundary
- release-notes
- verification-record
- case-navigation

## Navigation Export Rules

Derived navigation artifacts may include:

- hierarchy maps
- search indexes
- breadcrumb support
- route paths
- entity counts

All navigation artifacts must include:

- artifactType: derived_navigation
- authoritative: false

---

## Interrogative Derivation Layer

The viewer/tool layer may expose a derived interrogative view that answers:

- Who
- What
- When
- Where
- Why
- How

### Classification

Interrogative outputs must be classified as:

- `artifactType: interrogative_view` (preferred)
- OR `artifactType: derived_navigation`
- `authoritative: false`

### Source of Truth

Interrogative views must be composed exclusively from:

- ontology entities (supersets, subsets, elements)
- authoritative boundary-rule documents
- modeling exception documents (for clarification only)

No interrogative construct exists as an ontology entity.

### Governing Rules

The interrogative layer must:

- compose meaning through traversal of existing ontology structure
- respect cross-superset boundaries
- preserve traceability to source entities
- avoid semantic transformation of ontology content

### Prohibited Behaviour

The interrogative layer must not:

- create new ontology constructs
- infer relationships not present in ontology or authoritative documents
- collapse multiple supersets into a synthetic construct
- summarize in ways that alter ontology meaning
- be used to justify ontology restructuring

### Authority

The interrogative layer is governed by:

INTERROGATIVE-DERIVATION-RULES.md

This document defines the formal logic for interrogative composition and must be followed by all viewer implementations.

---

## Provenance Rules

Where applicable, exported objects must include source provenance:

- ontologyFile
- ttlFile
- sourcePath
- sourceFiles

This enables traceability from viewer content back to authoritative materials.

## Inclusion Rules for MVP

Include:

- all nine supersets
- all subsets
- all elements in element-bearing supersets
- ontology labels and comments
- release-boundary document
- ontology modeling exceptions
- cross-superset boundary-rule documents
- hierarchy and search navigation artifacts

Exclude:

- inferred semantic overlays
- user annotations
- educational tracks
- case/application overlays
- ontology diffing
- editing capabilities

## Allowed Derived Fields

The following fields may be generated for viewer convenience:

- slug
- path
- viewerHints
- defaultTab
- sortKey
- tokens
- breadcrumbs
- entityCounts

These fields must not be treated as ontology content.

## Forbidden Export Behaviours

The exporter must not:

1. create ontology classes or relationships not present in authoritative sources
2. promote UI groupings into ontology truth
3. alter semantics during normalization
4. respond to viewer requirements by modifying ontology structure outside governance processes

## Guardrail Statement

Any requirement originating from the viewer/tool layer that implies:

- new ontology entities
- new relationships
- new structural groupings

must be treated as an ontology governance decision, not an exporter implementation change.

## Versioning

The export contract must be versioned and referenced in the generated manifest.

Changes to this contract must be treated as controlled release events.

## Authority

This document is authoritative for all viewer/tool layer implementations consuming REPAC vNext ontology data.