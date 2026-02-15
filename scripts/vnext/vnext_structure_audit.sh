#!/usr/bin/env bash
set -euo pipefail

# vnext_structure_audit.sh
# Deterministic, pasteable report of vNext structure and validation hook readiness.

REPO_ROOT="$(git rev-parse --show-toplevel)"
TS="$(date +"%Y%m%d_%H%M%S")"
LOG_DIR="${REPO_ROOT}/logs"
OUT="${LOG_DIR}/vnext_structure_audit_${TS}.txt"

mkdir -p "${LOG_DIR}"

run() {
  local label="$1"
  shift || true

  echo
  echo "## ${label}"
  echo "------------------------------------------------------------"

  # shellcheck disable=SC2068
  "$@" 2>&1 || true
}

echo "REPAC vNext Structure Audit"
echo "Timestamp: ${TS}"
echo "Repo root: ${REPO_ROOT}"
echo "Current dir: $(pwd)"

VNX="${REPO_ROOT}/ontology/vNext"

run "git status (short)" git status -sb
run "git branch" git branch --show-current
run "git rev-parse HEAD" git rev-parse HEAD

run "Check expected vNext path exists" bash -lc "test -d \"${VNX}\" && echo \"OK: ${VNX}\" || echo \"MISSING: ${VNX}\""

run "Repo root listing" bash -lc "ls -la \"${REPO_ROOT}\""
run "ontology/ listing" bash -lc "ls -la \"${REPO_ROOT}/ontology\" 2>/dev/null || true"
run "ontology/vNext listing" bash -lc "ls -la \"${VNX}\" 2>/dev/null || true"

run "Detect duplicate nesting dirs (ontology/vNext/ontology/vNext etc.)" bash -lc "
  cd \"${VNX}\" 2>/dev/null || exit 0
  find . -maxdepth 6 -type d \\( -name ontology -o -name vNext -o -name validation -o -name shacl \\) -print | sort
"

run "vNext directories (maxdepth 2)" bash -lc "
  cd \"${VNX}\" 2>/dev/null || exit 0
  find . -maxdepth 2 -type d -print | sort
"

run "TTL files under ontology/vNext (maxdepth 5)" bash -lc "
  cd \"${VNX}\" 2>/dev/null || exit 0
  find . -maxdepth 5 -type f -name '*.ttl' -print | sort
"

run "SHACL directory inventory (validation/shacl)" bash -lc "
  cd \"${VNX}\" 2>/dev/null || exit 0
  if [ -d validation/shacl ]; then
    find validation/shacl -maxdepth 4 -type f -print | sort
  else
    echo 'MISSING: validation/shacl'
  fi
"

run "Find all scope-l1-shapes.ttl copies" bash -lc "
  cd \"${VNX}\" 2>/dev/null || exit 0
  find . -type f -name 'scope-l1-shapes.ttl' -print | sort
"

run "Find *shapes.ttl outside validation/shacl (potential misplacements)" bash -lc "
  cd \"${VNX}\" 2>/dev/null || exit 0
  find . -type f -name '*shapes.ttl' -print | sort | awk '
    BEGIN{bad=0}
    {
      if (\$0 !~ /^\\.\\/validation\\/shacl\\//) { print; bad=1 }
    }
    END{ if (bad==0) print \"(none)\" }
  '
"

run "Find SHACL entrypoint candidates (vnext-shapes.ttl, all-shapes.ttl, shapes.ttl)" bash -lc "
  cd \"${VNX}\" 2>/dev/null || exit 0
  if [ -d validation/shacl ]; then
    find validation/shacl -maxdepth 2 -type f \\( -name 'vnext-shapes.ttl' -o -name 'all-shapes.ttl' -o -name 'shapes.ttl' \\) -print | sort
  else
    echo 'MISSING: validation/shacl'
  fi
"

run "Search for old core-extension scope-l1-shapes path references" bash -lc "
  cd \"${REPO_ROOT}\"
  grep -R --line-number 'core-extension/scope/scope-l1-shapes.ttl' . | head -n 50 || true
"

run "scripts/vnext listing" bash -lc "ls -la \"${REPO_ROOT}/scripts/vnext\" 2>/dev/null || true"

run "Search scripts for SHACL tooling usage (pyshacl/jena/riot/shaclvalidate)" bash -lc "
  cd \"${REPO_ROOT}\"
  grep -R --line-number -E 'pyshacl|shaclvalidate|jena|riot|shacl' scripts | head -n 120 || true
"

run "git diff --name-status" git diff --name-status
run "git diff --cached --name-status" git diff --cached --name-status

echo
echo "OK: audit complete"
echo "Suggested save path: ${OUT}"
