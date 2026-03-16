#!/bin/bash

set -euo pipefail

REPO_ROOT="${1:-$(pwd)}"
CORE_EXT="$REPO_ROOT/ontology/vNext/core-extension"

SUPERSETS=(
  source
  collaboration
  governance
  purpose
  value
  communication
  imperative
  scope
  work
)

FAIL=0

echo "REPAC vNext Core-Extension Structural Verification"
echo "Generated: $(date)"
echo "Repository root: $REPO_ROOT"
echo

for superset in "${SUPERSETS[@]}"; do
  case "$superset" in
    source)
      PREFIX="SOURCE"
      OWL="repac-source.owl"
      TTL="repac-source.ttl"
      ;;
    collaboration)
      PREFIX="COLLABORATION"
      OWL="repac-collaboration.owl"
      TTL="repac-collaboration.ttl"
      ;;
    governance)
      PREFIX="GOVERNANCE"
      OWL="repac-governance.owl"
      TTL="repac-governance.ttl"
      ;;
    purpose)
      PREFIX="PURPOSE"
      OWL="repac-purpose.owl"
      TTL="repac-purpose.ttl"
      ;;
    value)
      PREFIX="VALUE"
      OWL="repac-value.owl"
      TTL="repac-value.ttl"
      ;;
    communication)
      PREFIX="COMMUNICATION"
      OWL="repac-communication.owl"
      TTL="repac-communication.ttl"
      ;;
    imperative)
      PREFIX="IMPERATIVE"
      OWL="repac-imperative.owl"
      TTL="repac-imperative.ttl"
      ;;
    scope)
      PREFIX="SCOPE"
      OWL="repac-scope.owl"
      TTL="repac-scope.ttl"
      ;;
    work)
      PREFIX="WORK"
      OWL="repac-work.owl"
      TTL="repac-work.ttl"
      ;;
    *)
      echo "FAIL: unknown superset '$superset'"
      FAIL=1
      continue
      ;;
  esac

  DIR="$CORE_EXT/$superset"

  echo "============================================================"
  echo "SUPERSET: $PREFIX"
  echo "PATH: $DIR"

  if [[ ! -d "$DIR" ]]; then
    echo "FAIL: missing superset directory"
    FAIL=1
    echo
    continue
  fi

  REQUIRED_FILES=(
    "$DIR/${PREFIX}-L1-CANDIDATE-SUBSETS.md"
    "$DIR/${PREFIX}-L1-FREEZE-DECISION.md"
    "$DIR/${PREFIX}-L1-PACKAGING-AUDIT.md"
    "$DIR/${PREFIX}-L1-SEMANTIC-AUDIT.md"
    "$DIR/${PREFIX}-L1-SEMANTIC-FREEZE-DECISION.md"
    "$DIR/$OWL"
    "$DIR/$TTL"
  )

  REQUIRED_DIRS=(
    "$DIR/diagrams"
  )

  for f in "${REQUIRED_FILES[@]}"; do
    if [[ -f "$f" ]]; then
      echo "PASS: $(basename "$f")"
    else
      echo "FAIL: missing file $(basename "$f")"
      FAIL=1
    fi
  done

  for d in "${REQUIRED_DIRS[@]}"; do
    if [[ -d "$d" ]]; then
      echo "PASS: $(basename "$d")/"
    else
      echo "FAIL: missing directory $(basename "$d")/"
      FAIL=1
    fi
  done

  SUBSET_COUNT=$(find "$DIR" -maxdepth 1 -type f -name '*-SUBSET-*.md' | wc -l | tr -d ' ')
  if [[ "$SUBSET_COUNT" -gt 0 ]]; then
    echo "PASS: subset files present ($SUBSET_COUNT)"
  else
    echo "FAIL: no subset files found"
    FAIL=1
  fi

  ARTIFACT_HITS=$(find "$DIR" -type f \( -name ".DS_Store" -o -name "*~" -o -name "*.bkp" -o -name "._*" \) | wc -l | tr -d ' ')
  if [[ "$ARTIFACT_HITS" -eq 0 ]]; then
    echo "PASS: no hygiene artifacts"
  else
    echo "FAIL: hygiene artifacts detected ($ARTIFACT_HITS)"
    find "$DIR" -type f \( -name ".DS_Store" -o -name "*~" -o -name "*.bkp" -o -name "._*" \)
    FAIL=1
  fi

  echo
done

echo "============================================================"
if [[ "$FAIL" -eq 0 ]]; then
  echo "RESULT: PASS — Core-extension structure verified."
  exit 0
else
  echo "RESULT: FAIL — Structural issues detected."
  exit 1
fi