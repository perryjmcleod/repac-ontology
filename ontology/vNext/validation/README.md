# VALIDATION

Module directory: `ontology/vNext/validation/`

Populate this directory with versioned, reviewable artifacts consistent with vNext design intent.

### Scope L1 SHACL

Scope L1 SHACL shapes are integrated via the SHACL entrypoint:

- `ontology/vNext/validation/shacl/vnext-shapes.ttl`
  - imports `ontology/vNext/validation/shacl/scope/scope-l1-shapes.ttl`

Validation scripts MUST reference the entrypoint (`vnext-shapes.ttl`) for deterministic execution.
