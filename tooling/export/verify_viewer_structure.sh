#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="${1:-$(pwd)}"
REPO_ROOT="$(cd "$REPO_ROOT" && pwd)"

echo "REPAC viewer/export structure verification"
echo "Repository root: $REPO_ROOT"
echo

pass() { echo "PASS: $1"; }
warn() { echo "WARN: $1"; }
fail() { echo "FAIL: $1"; }

check_exists() {
  local path="$1"
  local label="$2"

  if [ -e "$path" ]; then
    pass "$label -> $path"
  else
    fail "$label missing -> $path"
  fi
}

check_not_exists() {
  local path="$1"
  local label="$2"

  if [ -e "$path" ]; then
    warn "$label should not exist -> $path"
  else
    pass "$label not present"
  fi
}

echo "=== Expected top-level domains ==="
check_exists "$REPO_ROOT/ontology" "Ontology root"
check_exists "$REPO_ROOT/tooling" "Tooling root"
check_exists "$REPO_ROOT/viewer" "Viewer root"
echo

echo "=== Expected authoritative docs ==="
check_exists "$REPO_ROOT/ontology/vNext/docs/VIEWER-EXPORT-CONTRACT.md" "Viewer export contract"
check_exists "$REPO_ROOT/ontology/vNext/docs/INTERROGATIVE-DERIVATION-RULES.md" "Interrogative derivation rules"
echo

echo "=== Expected schema location ==="
check_exists "$REPO_ROOT/tooling/export/schema/manifest.schema.json" "Manifest schema"
check_exists "$REPO_ROOT/tooling/export/schema/ontology-entity.schema.json" "Ontology entity schema"
check_exists "$REPO_ROOT/tooling/export/schema/document.schema.json" "Document schema"
check_exists "$REPO_ROOT/tooling/export/schema/navigation.schema.json" "Navigation schema"
check_exists "$REPO_ROOT/tooling/export/schema/interrogative-view.schema.json" "Interrogative view schema"
check_exists "$REPO_ROOT/tooling/export/schema/README.md" "Schema README"
echo

echo "=== Expected tooling location ==="
check_exists "$REPO_ROOT/tooling/export/validate_viewer_export.py" "Exporter validation script"
check_exists "$REPO_ROOT/tooling/export/README.md" "Exporter README"
echo

echo "=== Strict example-data location ==="
if [ -d "$REPO_ROOT/tooling/export/example-data" ]; then
  pass "Strict example-data directory present -> $REPO_ROOT/tooling/export/example-data"
else
  warn "Strict example-data directory not present -> $REPO_ROOT/tooling/export/example-data"
fi

if [ -d "$REPO_ROOT/viewer/generated/example-data" ]; then
  warn "Example data currently under generated output -> $REPO_ROOT/viewer/generated/example-data"
else
  pass "No example-data directory under viewer/generated"
fi
echo

echo "=== Misplacement checks ==="
check_not_exists "$REPO_ROOT/ontology/vNext/tooling" "Tooling nested inside ontology"
check_not_exists "$REPO_ROOT/ontology/vNext/viewer" "Viewer nested inside ontology"
check_not_exists "$REPO_ROOT/tooling/export/schema/example-data" "Example data nested inside schema directory"
echo

echo "=== Directory snapshots ==="
for d in \
  "$REPO_ROOT/ontology/vNext/docs" \
  "$REPO_ROOT/tooling/export" \
  "$REPO_ROOT/tooling/export/schema" \
  "$REPO_ROOT/tooling/export/example-data" \
  "$REPO_ROOT/viewer/generated"
do
  if [ -d "$d" ]; then
    echo "--- $d"
    find "$d" -maxdepth 2 -type f | sort
    echo
  fi
done

echo "Verification complete."