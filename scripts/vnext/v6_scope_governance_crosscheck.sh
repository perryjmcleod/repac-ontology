#!/bin/sh
# REPAC vNext — Phase V-6
# Script 5/6: Scope ↔ Governance cross-check enforcement
# POSIX-safe. Robust to formatting differences in prior scripts.

set -eu

die() { printf '%s\n' "ERROR: $*" >&2; exit 1; }
need_cmd() { command -v "$1" >/dev/null 2>&1 || die "Required command not found: $1"; }

need_cmd git
need_cmd awk
need_cmd sed

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "Not inside a git work tree."

# Clean tree guard
if [ -n "$(git status --porcelain)" ]; then
  die "Working tree not clean. Commit or stash before running Script 5/6."
fi

PHASE_DIR="vnext/phase-v6-governance-pilot"
ART_DIR="${PHASE_DIR}/artifacts"
SCRIPT_REC_DIR="${PHASE_DIR}/script-records"
TS_UTC="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
EXEC_REC="${SCRIPT_REC_DIR}/v6_scope_governance_crosscheck.${TS_UTC}.log"

CROSS_MD="${ART_DIR}/V6-scope-governance-crosscheck.md"
DECOMP_MD="${ART_DIR}/V6-governance-decomposition.md"

[ -d "${ART_DIR}" ] || die "Artifacts directory not found: ${ART_DIR}"
[ -f "${CROSS_MD}" ] || die "Cross-check file not found: ${CROSS_MD}"
[ -f "${DECOMP_MD}" ] || die "Decomposition file not found: ${DECOMP_MD}"
mkdir -p "${SCRIPT_REC_DIR}"

# Robust guard: ensure canonical import section exists
grep -q "^## F\. Import Audit" "${DECOMP_MD}" || \
  die "Canonical import section not found in ${DECOMP_MD}. Run Script 2/6 first."

# Refuse re-run
grep -q "Cross-check Scaffold Applied (Script 5/6)" "${CROSS_MD}" && \
  die "Cross-check scaffold already applied."

# Locate frozen Scope pilot (repo layout)
SCOPE_ROOT="pilot/scope"
[ -d "" ] || die "Frozen Scope pilot directory not found."

SCOPE_GIT_COMMIT="$(git rev-parse HEAD)"

# Snapshot pointer
SNAPSHOT_MD="${ART_DIR}/V6-scope-pilot-snapshot-pointer.md"
[ -e "${SNAPSHOT_MD}" ] && die "Snapshot pointer already exists."

cat > "${SNAPSHOT_MD}" <<EOF2
# REPAC vNext — Phase V-6
## Scope Pilot Snapshot Pointer (Reference Only)

**Timestamp (UTC):** ${TS_UTC}  
**Scope pilot directory:** \`${SCOPE_ROOT}\`  
**Git commit at snapshot:** \`${SCOPE_GIT_COMMIT}\`

This file anchors the Scope ↔ Governance cross-check inputs.
EOF2

# Enforce cross-check scaffold
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT INT HUP TERM
OUT_MD="${TMP_DIR}/crosscheck.new.md"

awk '
  BEGIN { a=b=c=d=e=0 }
  /^### Rule$/ {
    print; getline; print;
    print "";
    print "**Cross-check Scaffold Applied (Script 5/6):** Yes";
    print "";
    print "### Recording Constraint";
    print "- Record observations only. Do not resolve.";
    print "- One observation per bullet.";
    print "";
    next
  }
  /^## A\. Constraint Type Comparison$/ && !a {
    print; print "";
    print "### Recording Format";
    print "- Observation ID: XCHK-CT-###";
    print "- Statement (1 sentence)";
    print "- Impacted side: Scope | Governance | Both";
    print "";
    a=1; next
  }
  /^## B\. Symmetry Notes$/ && !b {
    print; print "";
    print "### Recording Format";
    print "- Observation ID: XCHK-SYM-###";
    print "- Statement (1 sentence)";
    print "";
    b=1; next
  }
  /^## C\. Asymmetry Notes$/ && !c {
    print; print "";
    print "### Recording Format";
    print "- Observation ID: XCHK-ASY-###";
    print "- Statement (1 sentence)";
    print "";
    c=1; next
  }
  /^## D\. Potential Boundary Duplication/ && !d {
    print; print "";
    print "### Recording Format";
    print "- Observation ID: XCHK-DUP-###";
    print "- Statement (1 sentence)";
    print "";
    d=1; next
  }
  /^## E\. Tensions/ && !e {
    print; print "";
    print "### Recording Format";
    print "- Observation ID: XCHK-TEN-###";
    print "- Statement (1 sentence)";
    print "";
    e=1; next
  }
  { print }
  END { if (!(a&&b&&c&&d&&e)) exit 3 }
' "${CROSS_MD}" > "${OUT_MD}"

mv "${OUT_MD}" "${CROSS_MD}"

# Execution record
{
  printf '%s\n' "Phase V-6 Scope–Governance cross-check enforced @ ${TS_UTC}"
  printf '%s\n' "git_commit=$(git rev-parse HEAD)"
  printf '%s\n' "scope_root=${SCOPE_ROOT}"
  printf '%s\n' "snapshot=${SNAPSHOT_MD}"
} > "${EXEC_REC}"

git add "${CROSS_MD}" "${SNAPSHOT_MD}" "${EXEC_REC}"

printf '%s\n' "OK: Script 5/6 complete."
printf '%s\n' "Next: populate cross-check observations, then run Script 6/6."
