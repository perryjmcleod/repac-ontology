#!/usr/bin/env bash
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [[ -z "${ROOT}" ]]; then
  echo "ERROR: Not inside a git repo." >&2
  exit 1
fi
cd "${ROOT}"

VNEXT_DIR="ontology/vNext"
GOV_DIR="${VNEXT_DIR}/core-extension/governance"
DIAGRAMS_DIR="${GOV_DIR}/diagrams"
ONT_DIR="${GOV_DIR}/ontology"

INDEX_MD="${GOV_DIR}/GOVERNANCE-L1-INVENTORY-INDEX.md"
FREEZE_MD="${GOV_DIR}/GOVERNANCE-L1-FREEZE-DECISION.md"
DRAWIO_FILE="${DIAGRAMS_DIR}/GOVERNANCE-L1-STRUCTURE.drawio"
OWL_FILE="${ONT_DIR}/repac-governance.owl"
TTL_FILE="${ONT_DIR}/repac-governance.ttl"

fail=0

echo "== Governance L1 Packaging Audit =="
echo "Repo root: $(pwd)"
echo ""

check_exists() {
  local path="$1"
  if [[ -f "${path}" ]]; then
    echo "OK: ${path}"
  else
    echo "MISSING: ${path}"
    fail=1
  fi
}

check_exists "${INDEX_MD}"
check_exists "${FREEZE_MD}"
check_exists "${OWL_FILE}"
check_exists "${TTL_FILE}"

if [[ -f "${DRAWIO_FILE}" ]]; then
  echo "OK: ${DRAWIO_FILE}"
else
  echo "WARN: Diagram missing at ${DRAWIO_FILE} (semantic inventory source not present here)."
  echo "      This is not a scaffold failure, but it blocks semantic locking."
fi

echo ""
echo "== Drift Risk Heuristics (non-blocking, but loud) =="

# These checks are intentionally conservative; they do NOT parse semantics.
# They look for obvious signs of premature expansion in stubs.

if [[ -f "${TTL_FILE}" ]]; then
  if grep -Eq "owl:Class|rdf:Property|owl:ObjectProperty|owl:DatatypeProperty" "${TTL_FILE}"; then
    echo "WARN: TTL stub contains class/property assertions. Confirm this is intended and governed."
  else
    echo "OK: TTL stub appears header-only."
  fi
fi

if [[ -f "${OWL_FILE}" ]]; then
  if grep -Eq "<owl:Class|<owl:ObjectProperty|<owl:DatatypeProperty|<rdf:Property" "${OWL_FILE}"; then
    echo "WARN: OWL stub contains class/property assertions. Confirm this is intended and governed."
  else
    echo "OK: OWL stub appears header-only."
  fi
fi

echo ""
if [[ "${fail}" == "1" ]]; then
  echo "RESULT: FAIL — Missing required scaffold artifacts."
  exit 1
fi

echo "RESULT: PASS — Packaging scaffold present."
