# REPAC vNext

REPAC vNext is an additive extension layer over REPAC v1.0.

v1.0 is immutable. vNext introduces new work as versioned, modular, reviewable artifacts that import v1.0 without altering v1.0 semantics.

## Directory structure

- `core-extension/`  
  Normative extensions only (e.g., Subsets/Elements). Must not weaken Superset necessity.

- `formalization/`  
  OWL axioms and supporting formal artifacts that improve constraint clarity and reasoning behavior without semantic drift.

- `validation/`  
  SHACL shapes and governance validation assets. Intended as guardrails.

- `mappings/`  
  Non-normative mappings to standards, methods, and other ontologies (including optional foundational alignments).

- `domain-profiles/`  
  Non-normative domain-specific profiles (e.g., PM, BA, L&D). Must not become prescriptive.

- `docs/`  
  Design intent, extension register, and applications (worked cases, teaching views, examples).

## Normativity rules

Only artifacts explicitly designated as normative in `core-extension/` may introduce new normative constructs. All mappings, profiles, and applications are non-normative.

## Status

Scaffold created. Next step: lock design intent and populate the extension register.
