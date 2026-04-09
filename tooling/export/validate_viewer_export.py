#!/usr/bin/env python3

from __future__ import annotations

import json
import sys
from pathlib import Path
from typing import Iterable

try:
    import jsonschema
except ImportError:
    print("ERROR: Missing dependency 'jsonschema'. Install it with: pip install jsonschema")
    sys.exit(2)


REPO_ROOT = Path(__file__).resolve().parents[2]
SCHEMA_DIR = REPO_ROOT / "tooling" / "export" / "schema"
DEFAULT_GENERATED_DIR = REPO_ROOT / "viewer" / "generated"


SCHEMA_MAP = {
    "manifest.json": "manifest.schema.json",
    "ontology-index.json": "ontology-entity.schema.json",
}


DIRECTORY_SCHEMA_MAP = {
    "supersets": "ontology-entity.schema.json",
    "documents": "document.schema.json",
    "navigation": "navigation.schema.json",
    "cases": "document.schema.json",
    "interrogatives": "interrogative-view.schema.json",
}


def load_json(path: Path) -> dict:
    try:
        with path.open("r", encoding="utf-8") as f:
            return json.load(f)
    except json.JSONDecodeError as exc:
        raise ValueError(f"Invalid JSON in {path}: {exc}") from exc


def load_schema(schema_name: str) -> dict:
    schema_path = SCHEMA_DIR / schema_name
    if not schema_path.exists():
        raise FileNotFoundError(f"Schema file not found: {schema_path}")
    return load_json(schema_path)


def iter_json_files(directory: Path) -> Iterable[Path]:
    if not directory.exists():
        return []
    return sorted(p for p in directory.rglob("*.json") if p.is_file())


def validate_file(data_path: Path, schema: dict) -> list[str]:
    errors: list[str] = []
    validator = jsonschema.Draft202012Validator(schema)
    for err in sorted(validator.iter_errors(load_json(data_path)), key=lambda e: list(e.path)):
        location = ".".join(str(x) for x in err.path) or "<root>"
        errors.append(f"{data_path}: {location}: {err.message}")
    return errors


def resolve_schema_for_file(data_path: Path, generated_dir: Path) -> str | None:
    rel = data_path.relative_to(generated_dir)

    if rel.name in SCHEMA_MAP:
        return SCHEMA_MAP[rel.name]

    if len(rel.parts) >= 2:
        top_dir = rel.parts[0]
        return DIRECTORY_SCHEMA_MAP.get(top_dir)

    return None


def main() -> int:
    generated_dir = Path(sys.argv[1]).resolve() if len(sys.argv) > 1 else DEFAULT_GENERATED_DIR

    if not generated_dir.exists():
        print(f"ERROR: Generated viewer directory does not exist: {generated_dir}")
        return 2

    print(f"Validating viewer export in: {generated_dir}")
    print(f"Using schemas from:          {SCHEMA_DIR}")

    all_json_files = list(iter_json_files(generated_dir))
    if not all_json_files:
        print("ERROR: No JSON files found to validate.")
        return 2

    schema_cache: dict[str, dict] = {}
    all_errors: list[str] = []
    validated_count = 0
    skipped_count = 0

    for data_file in all_json_files:
        schema_name = resolve_schema_for_file(data_file, generated_dir)
        if schema_name is None:
            print(f"SKIP  {data_file} (no schema mapping)")
            skipped_count += 1
            continue

        if schema_name not in schema_cache:
            schema_cache[schema_name] = load_schema(schema_name)

        print(f"CHECK {data_file} -> {schema_name}")
        try:
            errors = validate_file(data_file, schema_cache[schema_name])
        except Exception as exc:
            all_errors.append(f"{data_file}: validation failed with error: {exc}")
            continue

        if errors:
            all_errors.extend(errors)
        else:
            validated_count += 1

    print()
    print(f"Validated files: {validated_count}")
    print(f"Skipped files:   {skipped_count}")

    if all_errors:
        print()
        print("VALIDATION FAILED")
        for err in all_errors:
            print(f"- {err}")
        return 1

    print()
    print("VALIDATION PASSED")
    return 0


if __name__ == "__main__":
    sys.exit(main())