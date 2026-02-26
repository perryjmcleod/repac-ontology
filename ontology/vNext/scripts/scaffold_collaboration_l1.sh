#!/usr/bin/env bash
set -euo pipefail

# REPAC vNext — Collaboration L1 — Packaging Scaffold
# Constraints:
# - No conceptual expansion
# - No renaming
# - No ontology drift
# - Migrate subset structure from v1.0 verbatim if present

ROOT="$(git rev-parse --show-toplevel)"
VNEXT_COL="$ROOT/ontology/vNext/core-extension/collaboration"
V1_COL="$ROOT/ontology/v1.0/core/collaboration"

mkdir -p "$VNEXT_COL"/{diagrams,subsets,docs,formalization,validation}

# Core package markers (scaffold only)
touch \
  "$VNEXT_COL/README.md" \
  "$VNEXT_COL/COLLABORATION-L1-PACKAGING-SCAFFOLD.md" \
  "$VNEXT_COL/docs/COLLABORATION-L1-SUBSET-INVENTORY.md" \
  "$VNEXT_COL/diagrams/COLLABORATION-L1-STRUCTURE.drawio" \
  "$VNEXT_COL/formalization/repac-collaboration-l1-structural-stub.ttl" \
  "$VNEXT_COL/validation/COLLABORATION-L1-VALIDATION-CASES.md"

# Migrate v1.0 subset structure verbatim if present (file copies only; no renaming)
if [[ -d "$V1_COL" ]]; then
  # Copy any subset markdown that exists in v1.0 (common patterns)
  shopt -s nullglob
  CANDIDATES=(
    "$V1_COL"/subsets/*.md
    "$V1_COL"/*.md
  )
  if (( ${#CANDIDATES[@]} > 0 )); then
    for f in "${CANDIDATES[@]}"; do
      bn="$(basename "$f")"
      # Only copy if not already present in vNext
      if [[ ! -f "$VNEXT_COL/subsets/$bn" ]]; then
        cp "$f" "$VNEXT_COL/subsets/$bn"
      fi
    done
  fi
fi

# Minimal, non-expansive scaffold content (no subset names asserted here)
cat > "$VNEXT_COL/README.md" <<'MD'
# Collaboration (Layer 1) — vNext

This package is scaffolded for controlled L1 stabilization.

Constraints enforced:
- No conceptual expansion
- No renaming
- No ontology drift
- Subset structure migrates from v1.0 verbatim if present

Workflow: packaging scaffold → audit → semantic freeze → structural stub
MD

cat > "$VNEXT_COL/COLLABORATION-L1-PACKAGING-SCAFFOLD.md" <<'MD'
# COLLABORATION L1 — Packaging Scaffold

## Objective
Stabilize Collaboration L1 using the same controlled pattern as Communication L1.

## Constraints
- No conceptual expansion
- No renaming
- No ontology drift
- Follow packaging scaffold → audit → semantic freeze → structural stub
- Migrate subset structure from v1.0 verbatim if present

## Scaffold Outputs
- `subsets/` directory created for verbatim v1.0 subset artifacts (if present)
- `diagrams/` directory created for the L1 structure diagram
- `docs/` directory created for subset inventory and audit artifacts
- `formalization/` directory created for the structural stub (to be completed after semantic freeze)
- `validation/` directory created for validation-case tracking

## Notes
This file asserts no subset names and introduces no new constructs.
MD

cat > "$VNEXT_COL/docs/COLLABORATION-L1-SUBSET-INVENTORY.md" <<'MD'
# COLLABORATION L1 — Subset Inventory

## Rule
Subset structure must be migrated from v1.0 verbatim if present.
No new subsets are introduced during scaffold.

## Inventory
Populate this inventory during the audit phase by enumerating the files present in:
- `ontology/v1.0/core/collaboration/` (if it exists)
- `ontology/vNext/core-extension/collaboration/subsets/`

Record:
- Subset file name
- Source (v1.0 or vNext)
- Any observed deltas (should be none in this phase)
MD

cat > "$VNEXT_COL/formalization/repac-collaboration-l1-structural-stub.ttl" <<'TTL'
@prefix : <http://example.org/repac/vNext/collaboration#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

# Structural stub placeholder.
# This file MUST NOT be expanded until after:
# 1) Audit completes
# 2) Semantic freeze decision is recorded

:repac-collaboration-l1-structural-stub a owl:Ontology .
TTL

cat > "$VNEXT_COL/validation/COLLABORATION-L1-VALIDATION-CASES.md" <<'MD'
# Collaboration L1 — Validation Cases

This file is a placeholder registry for Collaboration L1 validation cases.
Do not add or modify cases until after the audit and semantic freeze.
MD

echo "OK: Collaboration L1 packaging scaffold created at: $VNEXT_COL"
