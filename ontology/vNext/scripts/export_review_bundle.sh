#!/bin/bash

set -euo pipefail

REPO_ROOT="${1:-$(pwd)}"
CORE_EXT="$REPO_ROOT/ontology/vNext/core-extension"
OUTFILE="$CORE_EXT/CORE-EXTENSION-REVIEW-BUNDLE.txt"

FILES=(
  "ontology/vNext/core-extension/collaboration/COLLABORATION-L1-PACKAGING-AUDIT.md"
  "ontology/vNext/core-extension/collaboration/COLLABORATION-L1-CANDIDATE-SUBSETS.md"
  "ontology/vNext/core-extension/imperative/IMPERATIVE-L1-FREEZE-DECISION.md"
  "ontology/vNext/core-extension/imperative/IMP-SUBSET-02-discretionary-imperative.md"
  "ontology/vNext/core-extension/source/SOURCE-L1-SEMANTIC-AUDIT.md"
)

mkdir -p "$CORE_EXT"

{
  echo "REPAC CORE-EXTENSION REVIEW BUNDLE"
  echo "Generated: $(date)"
  echo "Repository root: $REPO_ROOT"
  echo "Output file: $OUTFILE"
  echo
  echo "FILES REQUESTED"
  for f in "${FILES[@]}"; do
    echo "- $f"
  done
  echo
  echo "============================================================"
  echo
} > "$OUTFILE"

for relpath in "${FILES[@]}"; do
  abspath="$REPO_ROOT/$relpath"

  {
    echo "FILE: $relpath"
    echo "------------------------------------------------------------"
  } >> "$OUTFILE"

  if [[ -f "$abspath" ]]; then
    cat "$abspath" >> "$OUTFILE"
  else
    echo "[MISSING FILE]" >> "$OUTFILE"
  fi

  {
    echo
    echo "============================================================"
    echo
  } >> "$OUTFILE"
done

echo "Bundle created:"
echo "$OUTFILE"