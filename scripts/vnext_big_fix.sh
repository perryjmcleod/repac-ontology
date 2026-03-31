#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "${REPO_ROOT}"

echo "Repo: ${REPO_ROOT}"
echo "Branch: $(git branch --show-current)"
echo

# ---- Guardrails: ensure we're not about to stomp unrelated work ----
echo "Checking working tree..."
git status -sb
echo

# Allow only these paths to be staged/modified/untracked (plus logs output files):
ALLOW_REGEX='^(ontology/vNext/validation/README\.md|ontology/vNext/core-extension/scope/scope-l1-shapes\.ttl|ontology/vNext/validation/shacl/.*|scripts/vnext/vnext_structure_audit\.sh|scripts/vnext/vnext_big_fix\.sh|logs/.*)$'

# Any changed paths outside allowed set -> abort
CHANGED="$(git status --porcelain | awk '{print $2}' || true)"
BAD=""
while IFS= read -r p; do
  [ -z "${p}" ] && continue
  if ! echo "${p}" | grep -Eq "${ALLOW_REGEX}"; then
    BAD="${BAD}\n${p}"
  fi
done <<< "${CHANGED}"

if [ -n "${BAD}" ]; then
  echo "ERROR: Refusing to run. Unrelated changes detected:"
  echo -e "${BAD}"
  echo
  echo "Either commit/stash those changes, or widen ALLOW_REGEX intentionally."
  exit 1
fi

# ---- Fix 1: remove accidental nested ontology/vNext tree under cases ----
BAD_NEST="ontology/vNext/cases/ontology"
if [ -d "${BAD_NEST}" ]; then
  echo "Removing accidental nested directory: ${BAD_NEST}"

  # If git knows about it, remove via git rm; otherwise rm -rf
  if git ls-files --error-unmatch "${BAD_NEST}" >/dev/null 2>&1; then
    git rm -r "${BAD_NEST}"
  else
    rm -rf "${BAD_NEST}"
  fi
else
  echo "OK: no accidental nested directory at ${BAD_NEST}"
fi
echo

# ---- Fix 2: ensure SHACL entrypoint imports Scope L1 shapes ----
ENTRY="ontology/vNext/validation/shacl/vnext-shapes.ttl"
SCOPE_IMPORT="./scope/scope-l1-shapes.ttl"

if [ ! -f "${ENTRY}" ]; then
  echo "ERROR: Missing SHACL entrypoint: ${ENTRY}"
  exit 1
fi

if grep -q "scope-l1-shapes.ttl" "${ENTRY}"; then
  echo "OK: entrypoint already imports Scope L1 shapes"
else
  echo "Patching entrypoint to import Scope L1 shapes: ${SCOPE_IMPORT}"
  # Insert import line just before final '.' if file is in the common pattern.
  # If not, append a simple owl:imports block safely.
  if grep -q "owl:imports" "${ENTRY}"; then
    # add another import line after owl:imports
    perl -0777 -pe 's/(owl:imports\s*\n)/$1    <.\/scope\/scope-l1-shapes.ttl>\n/s' -i "${ENTRY}"
  else
    # append a minimal ontology header import (won't break parse, but may duplicate prefixes)
    cat >> "${ENTRY}" << 'EOT'

# Added by vnext_big_fix.sh
@prefix owl: <http://www.w3.org/2002/07/owl#> .

[] a owl:Ontology ;
  owl:imports <./scope/scope-l1-shapes.ttl> .
EOT
  fi
  git add "${ENTRY}"
fi
echo

# ---- Re-run audit (informational) ----
if [ -x "scripts/vnext/vnext_structure_audit.sh" ]; then
  echo "Re-running structure audit..."
  bash scripts/vnext/vnext_structure_audit.sh | tee logs/vnext_structure_audit_postfix_latest.txt
else
  echo "NOTE: audit script not found/executable; skipping re-run."
fi

echo
echo "DONE. Next steps:"
echo "  git status"
echo "  git commit -m \"vNext: clean nested cases/ontology tree; finalize Scope L1 SHACL placement\""
echo "  git push"
