# REPAC Viewer Export Schemas

## Objective

Define validation schemas for the generated REPAC viewer export package.

These schemas enforce the structure defined by:

- `ontology/vNext/docs/VIEWER-EXPORT-CONTRACT.md`
- `ontology/vNext/docs/INTERROGATIVE-DERIVATION-RULES.md`

## Files

- `manifest.schema.json`
- `ontology-entity.schema.json`
- `document.schema.json`
- `navigation.schema.json`
- `interrogative-view.schema.json`

## Scope

These schemas validate generated viewer artifacts only.

They do not:

- validate OWL or TTL directly
- redefine ontology semantics
- authorize new ontology entities
- permit viewer-driven ontology change

## Design Rules

1. Ontology-derived artifacts remain authoritative only where explicitly typed.
2. Navigation and interrogative artifacts are derived and non-authoritative.
3. Canonical REPAC IDs govern joins and traceability.
4. Slugs are routing conveniences only.
5. Export-time validation must fail on schema violations.

## Notes

- All schemas use JSON Schema Draft 2020-12.
- Additional properties are disallowed unless explicitly permitted.
- Derived viewer conveniences must not be treated as ontology truth.