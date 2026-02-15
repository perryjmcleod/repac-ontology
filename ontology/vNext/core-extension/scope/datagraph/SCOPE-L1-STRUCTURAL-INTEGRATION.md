# Scope L1 — DataGraph Structural Integration (vNext)

## Purpose
Integrate Scope L1 into the DataGraph as machine-legible structure without conceptual expansion.

## Authoritative Source
Scope L1 class definitions and naming authority live in:
- `scope-l1-structural-stub.ttl`
- `scope-l1-structural-stub.owl`

The DataGraph artifacts in `datagraph/` are wrappers that import the authoritative stubs to prevent naming drift.

## Constraints
- Structural integration only.
- No Elements / individuals.
- No cross-superset bindings (Governance, Source, Paradigm, etc.).
- Inclusion/Exclusion are Boundary outcomes (properties), not Subsets.

## Artifacts
- `datagraph/SCOPE-L1.ttl` (wrapper; imports authoritative TTL)
- `datagraph/SCOPE-L1.owl` (wrapper; imports authoritative OWL)
- `datagraph/SCOPE-L1.shacl.ttl` (placeholder shapes targeting imported classes)

## Validation
- Load `datagraph/SCOPE-L1.ttl` in Protégé.
- Confirm imported classes resolve (Scop- Confirm imported classes resolve (Scop- Confirm impornte- Confirm imported classes resolve (Scop- Confirmno unsatisfiable classes.
