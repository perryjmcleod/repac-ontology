# REPAC Viewer Export Tooling

## Objective

Provide export and validation tooling for the REPAC viewer/tool layer.

This tooling is non-authoritative infrastructure. It exists to transform and validate derived viewer artifacts from authoritative ontology and governance sources.

## Scope

This directory contains:

- export scripts
- validation scripts
- schema definitions
- supporting tooling for viewer build generation

## Separation Rule

Tooling must remain outside the ontology layer.

Tooling may:

- read ontology files
- read authoritative governance documents
- generate derived viewer artifacts
- validate generated output

Tooling must not:

- redefine ontology meaning
- introduce ontology entities
- be treated as ontology source material

## Validation Step

`validate_viewer_export.py` validates generated JSON files under:

`viewer/generated/`

against the JSON schemas under:

`tooling/export/schema/`

## Default Schema Mapping

- `manifest.json` → `manifest.schema.json`
- `ontology-index.json` → `ontology-entity.schema.json`
- `supersets/*.json` → `ontology-entity.schema.json`
- `documents/*.json` → `document.schema.json`
- `navigation/*.json` → `navigation.schema.json`
- `cases/*.json` → `document.schema.json`
- `interrogatives/*.json` → `interrogative-view.schema.json`

## Usage

From repository root:

```bash
python3 tooling/export/validate_viewer_export.py