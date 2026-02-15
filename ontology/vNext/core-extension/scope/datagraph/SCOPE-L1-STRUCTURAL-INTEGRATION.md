# Scope L1 — DataGraph Structural Integration (vNext)

## Purpose
Integrate Scope L1 as machine-legible structure (OWL/TTL) without conceptual expansion.

## Constraints
- Classes and subclass chains only.
- No Elements / individuals.
- No cross-superset bindings (Governance, Source, Paradigm, etc.).
- Scope lenses (Internal/External) remain Scope-related constructs per Phase-1 audit commitment.

## Artifacts
- SCOPE-L1.ttl
- SCOPE-L1.shacl.ttl

## Validation
- Load TTL in Protégé
- Run reasoner (HermiT or ELK)
- Confirm no unsatisfiable classes
