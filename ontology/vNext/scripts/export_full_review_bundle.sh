#!/bin/bash

set -euo pipefail

REPO_ROOT="${1:-$(pwd)}"
CORE_EXT="$REPO_ROOT/ontology/vNext/core-extension"
OUTFILE="$CORE_EXT/CORE-EXTENSION-FULL-REVIEW-BUNDLE.txt"

mkdir -p "$CORE_EXT"

{
  echo "REPAC CORE-EXTENSION FULL REVIEW BUNDLE"
  echo "Generated: $(date)"
  echo "Repository root: $REPO_ROOT"
  echo "Output file: $OUTFILE"
  echo
  echo "This bundle includes:"
  echo "- L1 packaging audit/scaffold file"
  echo "- L1 candidate subsets"
  echo "- L1 freeze decision"
  echo "- L1 semantic audit"
  echo "- L1 semantic freeze decision"
  echo "- All subset definition markdown files found under each superset root"
  echo
  echo "============================================================"
  echo
} > "$OUTFILE"

append_file() {
  local relpath="$1"
  local abspath="$REPO_ROOT/$relpath"

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
}

append_superset_section() {
  local superset_dir="$1"
  local upper="$2"

  {
    echo "SUPERSET: $upper"
    echo "PATH: ontology/vNext/core-extension/$superset_dir"
    echo "############################################################"
    echo
  } >> "$OUTFILE"

  local base="ontology/vNext/core-extension/$superset_dir"

  # Canonical L1 files
  append_file "$base/${upper}-L1-PACKAGING-AUDIT.md"
  append_file "$base/${upper}-L1-PACKAGING-SCAFFOLD.md"
  append_file "$base/${upper}-L1-CANDIDATE-SUBSETS.md"
  append_file "$base/${upper}-L1-FREEZE-DECISION.md"
  append_file "$base/${upper}-L1-SEMANTIC-AUDIT.md"
  append_file "$base/${upper}-L1-SEMANTIC-FREEZE-DECISION.md"

  # Any subset markdown files found directly in the superset root
  while IFS= read -r file; do
    rel="${file#"$REPO_ROOT/"}"
    append_file "$rel"
  done < <(
    find "$REPO_ROOT/$base" -maxdepth 1 -type f -name "*.md" \
      | sort \
      | grep -E '/(PURP|VAL|IMP|COMM|COLLAB|GOV|SRC|WORK|SCOPE)-SUBSET-[0-9]{2}-.+\.md$|/(GOV|SCOPE)-EL-[0-9]{2}-.+\.md$' || true
  )
}

append_superset_section "purpose" "PURPOSE"
append_superset_section "value" "VALUE"
append_superset_section "imperative" "IMPERATIVE"
append_superset_section "communication" "COMMUNICATION"
append_superset_section "collaboration" "COLLABORATION"
append_superset_section "governance" "GOVERNANCE"
append_superset_section "scope" "SCOPE"
append_superset_section "source" "SOURCE"
append_superset_section "work" "WORK"

echo "Bundle created:"
echo "$OUTFILE"