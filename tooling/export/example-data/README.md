# REPAC Viewer Export Example Data

## Objective

Provide hand-authored example JSON artifacts for validating the REPAC viewer export contract and schema set.

These files exist as controlled fixtures for testing, validation, and implementation reference.

## Scope

This directory contains example artifacts representing the main viewer export object types:

- manifest
- ontology aggregate
- ontology superset
- governance document
- derived navigation
- interrogative view

## Role

These files are:

- non-runtime fixtures
- validation targets
- implementation references

These files are not authoritative ontology content.

They must not be treated as generated viewer output.

## Separation Rule

Example data must remain separate from runtime viewer output.

Example data belongs here:

`tooling/export/example-data/`

Generated runtime artifacts belong here:

`viewer/generated/`

This separation preserves the distinction between:

- hand-authored fixture data
- generated viewer data

## Validation Use

Example data should validate cleanly against the schemas in:

`tooling/export/schema/`

Validation command:

```bash
python3 tooling/export/validate_viewer_export.py tooling/export/example-data