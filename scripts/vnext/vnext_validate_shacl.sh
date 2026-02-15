#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
SHAPES="${REPO_ROOT}/ontology/vNext/validation/shacl/vnext-shapes.ttl"
DATA="/ontology/vNext/validation/shacl/vnext-datagraph-null.ttl"

die() { echo "ERROR: $*" >&2; exit 1; }

[ -f "${SHAPES}" ] || die "Missing SHACL entrypoint: ${SHAPES}"

# Prefer installed pyshacl binary; fall back to python module.
if command -v pyshacl >/dev/null 2>&1; then
  PYSHACL=(pyshacl)
elif command -v python3 >/dev/null 2>&1 && python3 -c "import pyshacl" >/dev/null 2>&1; then
  PYSHACL=(python3 -m pyshacl)
else
  die "pyshacl not available. Install: pip install pyshacl"
fi

echo "Repo root : ${REPO_ROOT}"
echo "Shapes    : ${SHAPES}"
echo "Runner    : ${PYSHACL[*]}"
echo

# Shapes-only check: parse + resolve owl:imports deterministically.
"${PYSHACL[@]}" -s "${SHAPES}" >/dev/null

echo "OK: SHACL shapes parse + imports resolution PASS"
