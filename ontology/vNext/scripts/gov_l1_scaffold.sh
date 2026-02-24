#!/usr/bin/env bash
set -euo pipefail

# Governance L1 packaging scaffold
# Constraint: packaging only; no conceptual expansion; no renaming; no ontology drift.

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [[ -z "${ROOT}" ]]; then
  echo "ERROR: Not inside a git repo. cd into your repo first." >&2
  exit 1
fi
cd "${ROOT}"

# ---- CONFIG (match your repo layout) ----
VNEXT_DIR="ontology/vNext"
GOV_DIR="${VNEXT_DIR}/core-extension/governance"
DIAGRAMS_DIR="${GOV_DIR}/diagrams"
ONT_DIR="${GOV_DIR}/ontology"

# If you already have a canonical diagram filename, set it here.
DRAWIO_FILE="${DIAGRAMS_DIR}/GOVERNANCE-L1-STRUCTURE.drawio"

INDEX_MD="${GOV_DIR}/GOVERNANCE-L1-INVENTORY-INDEX.md"
FREEZE_MD="${GOV_DIR}/GOVERNANCE-L1-FREEZE-DECISION.md"

OWL_FILE="${ONT_DIR}/repac-governance.owl"
TTL_FILE="${ONT_DIR}/repac-governance.ttl"

FORCE="${FORCE:-0}"  # set FORCE=1 to overwrite templates if they already exist

mkdir -p "${DIAGRAMS_DIR}" "${ONT_DIR}"

create_file() {
  local path="$1"
  local tmp="$2"
  if [[ -f "${path}" && "${FORCE}" != "1" ]]; then
    echo "SKIP: ${path} exists (set FORCE=1 to overwrite template)."
    return 0
  fi
  cat > "${path}" <<'EOF'
EOF
  # Replace with tmp content (passed in via heredoc call)
}

# ---- Inventory Index (packaging map, not semantics) ----
if [[ ! -f "${INDEX_MD}" || "${FORCE}" == "1" ]]; then
cat > "${INDEX_MD}" <<EOF
# GOVERNANCE L1 — Inventory Index (Packaging)

## Purpose
This index enumerates Governance Layer 1 packaging artifacts and their locations.
This file is packaging-only and does not define or modify Governance semantics.

## Status
- Packaging scaffold: Created
- Semantics: Defined elsewhere (diagram + ontology assertions added later)

## Directory Structure
- \`${GOV_DIR}/\`
  - \`diagrams/\` — Governance L1 structural diagrams (source of semantic truth for node set)
  - \`ontology/\` — OWL/Turtle structural stubs (no semantic expansion in this scaffold)
  - \`GOVERNANCE-L1-FREEZE-DECISION.md\` — packaging freeze decision referencing authoritative diagram
  - \`GOVERNANCE-L1-INVENTORY-INDEX.md\` — this index

## Artifact List
### Diagrams
- \`${DRAWIO_FILE}\` — Governance L1 Structure (authoritative for subset inventory and naming)

### Decisions
- \`${FREEZE_MD}\` — Governance L1 Freeze Decision (packaging lock; references diagram)

### Ontology Stubs (Structural Only)
- \`${OWL_FILE}\` — OWL stub (ontology header + imports only; no classes/properties asserted)
- \`${TTL_FILE}\` — Turtle stub (ontology header + prefixes only; no classes/properties asserted)

## Notes
- This scaffold intentionally avoids listing Governance L1 subsets by name to prevent drift.
- Subset inventory and naming remain authoritative in the diagram until explicitly locked.
EOF
echo "WROTE: ${INDEX_MD}"
else
  echo "SKIP: ${INDEX_MD} exists."
fi

# ---- Freeze Decision (lock packaging alignment, no semantic restatement) ----
if [[ ! -f "${FREEZE_MD}" || "${FORCE}" == "1" ]]; then
cat > "${FREEZE_MD}" <<EOF
# GOVERNANCE L1 — Freeze Decision (Packaging Lock)

## Objective
Align Governance L1 packaging with Scope L1 packaging **without altering semantics**.

## Constraint
- No conceptual expansion
- No renaming
- No ontology drift

## Status
Governance L1 packaging is frozen:
- The directory structure and artifact inventory are locked.
- Governance L1 semantic inventory (subset names and node set) remains authoritative in:
  - \`${DRAWIO_FILE}\`

## Frozen Packaging Artifacts
1. Inventory index: \`${INDEX_MD}\`
2. Freeze decision: \`${FREEZE_MD}\`
3. Structural stubs:
   - \`${OWL_FILE}\`
   - \`${TTL_FILE}\`
4. Diagram location (authoritative): \`${DRAWIO_FILE}\`

## Freeze Rule
Any future change that modifies Governance L1 subset naming, adds new conceptual nodes, or reinterprets relationships
is out-of-scope for packaging and must be handled in the explicit Governance L1 semantic audit workflow.
EOF
echo "WROTE: ${FREEZE_MD}"
else
  echo "SKIP: ${FREEZE_MD} exists."
fi

# ---- Structural Stub (OWL) — header only, no assertions ----
if [[ ! -f "${OWL_FILE}" || "${FORCE}" == "1" ]]; then
cat > "${OWL_FILE}" <<'EOF'
<?xml version="1.0"?>
<rdf:RDF
    xmlns="http://example.org/repac/governance#"
    xml:base="http://example.org/repac/governance"
    xmlns:owl="http://www.w3.org/2002/07/owl#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#">

  <!--
    REPAC Governance L1 — Structural Stub
    Packaging-only scaffold:
    - No class/property assertions
    - No conceptual expansion
    - No renaming
    - Diagram remains authoritative for semantic inventory until explicitly locked
  -->

  <owl:Ontology rdf:about="http://example.org/repac/governance">
    <rdfs:label xml:lang="en">REPAC Governance L1 (Stub)</rdfs:label>
    <rdfs:comment xml:lang="en">Structural stub only. Semantics asserted in later governed steps.</rdfs:comment>

    <!-- OPTIONAL: add imports ONLY if they already exist in your repo and are already part of the plan.
         Leave commented to avoid drift.
    -->
    <!-- <owl:imports rdf:resource="http://example.org/repac/core"/> -->
  </owl:Ontology>

</rdf:RDF>
EOF
echo "WROTE: ${OWL_FILE}"
else
  echo "SKIP: ${OWL_FILE} exists."
fi

# ---- Structural Stub (TTL) — prefixes + ontology header only ----
if [[ ! -f "${TTL_FILE}" || "${FORCE}" == "1" ]]; then
cat > "${TTL_FILE}" <<'EOF'
@prefix : <http://example.org/repac/governance#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

# REPAC Governance L1 — Structural Stub
# Packaging-only scaffold:
# - No class/property assertions
# - No conceptual expansion
# - No renaming
# - Diagram remains authoritative for semantic inventory until explicitly locked

<http://example.org/repac/governance> a owl:Ontology ;
  rdfs:label "REPAC Governance L1 (Stub)"@en ;
  rdfs:comment "Structural stub only. Semantics asserted in later governed steps."@en
  .

# OPTIONAL imports (commented to avoid drift):
# <http://example.org/repac/governance> owl:imports <http://example.org/repac/core> .
EOF
echo "WROTE: ${TTL_FILE}"
else
  echo "SKIP: ${TTL_FILE} exists."
fi

# ---- Ensure drawio file exists (do not overwrite) ----
if [[ ! -f "${DRAWIO_FILE}" ]]; then
  echo "NOTE: Diagram not found at ${DRAWIO_FILE}"
  echo "      Create/move your Governance L1 diagram there (authoritative semantic inventory)."
else
  echo "OK: Found diagram ${DRAWIO_FILE}"
fi

echo ""
echo "DONE: Governance L1 packaging scaffold created/verified."
echo "Next: run the audit script to confirm packaging alignment + no drift."
