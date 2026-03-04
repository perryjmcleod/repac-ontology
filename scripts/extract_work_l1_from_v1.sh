#!/usr/bin/env bash

# REPAC v1.0 Work Dimension Extractor
# Purpose: identify L1 analytical dimensions under Work from repac-work.owl

set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"

FILE="ontology/v1.0/owl/repac-work.owl"

echo "=============================================="
echo "REPAC v1.0 Work Dimension Extractor"
echo "Repository root: $ROOT"
echo "Input file: $FILE"
echo "=============================================="
echo

if [[ ! -f "$FILE" ]]; then
  echo "ERROR: repac-work.owl not found at:"
  echo "  $FILE"
  exit 1
fi

echo "File type:"
file "$FILE"
echo

echo "First 40 lines of file:"
echo "----------------------------------------------"
head -n 40 "$FILE"
echo "----------------------------------------------"
echo

echo "Searching for Work-related class definitions..."
echo

grep -nEi "Work" "$FILE" | head -n 60 || true

echo
echo "Searching for subclass relationships..."
echo

grep -nEi "subclassof" "$FILE" | head -n 60 || true

echo
echo "Extraction complete."
echo "Review lines above to identify L1 Work dimensions."