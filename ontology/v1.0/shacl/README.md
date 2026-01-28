# REPAC v1.0 — SHACL Shapes

This directory contains SHACL shapes that support validation of the structural integrity of the REPAC Ontology. These shapes are deliberately minimal and are intended to provide governance guardrails without imposing semantic constraints.

REPAC separates concerns explicitly:

- **OWL** expresses meaning, classification, and inference
- **SHACL** enforces structural sanity and modeling discipline

SHACL is used here to detect obvious modeling errors early without
over-constraining the ontology.

## Scope of Validation

The SHACL shapes in this directory validate:

- Presence and cardinality of human-readable names
- Optional identifier hygiene (`repac:repacId`)
- Basic datatype correctness for descriptive fields
- Class-appropriate relationships when structural links are present

They do **not** enforce:

- Business rules
- Analytical workflows
- Cardinality assumptions beyond minimal safety
- Semantic correctness (this is handled by OWL and design governance)

This design ensures REPAC remains extensible, domain-agnostic, and suitable
for both academic and applied use.

## Current Shapes

- `repac-minimal-sanity.shacl.ttl`  
  Minimal structural validation for:
  - Superset
  - Subset
  - Set
  - Element

These shapes are expected to produce **no violations** when validating the
schema-level ontology alone.

## Validation Usage

To validate the REPAC v1.0 ontology using pySHACL:

```bash
python3 -m pyshacl \
  -s ontology/v1.0/shacl/repac-minimal-sanity.shacl.ttl \
  -d ontology/repac-v1.0.ttl \
  -f human
