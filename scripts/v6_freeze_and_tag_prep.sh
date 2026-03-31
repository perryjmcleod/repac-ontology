#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
ONTO_VNEXT="${ROOT}/ontology/vNext"
LOG_DIR="${ROOT}/logs/vnext"
TS="$(date +"%Y-%m-%d_%H%M%S")"

mkdir -p "${LOG_DIR}"

echo "[vNext V-6] Freeze + tag prep starting"
echo "  ROOT      = ${ROOT}"
echo "  ONTO_VNEXT = ${ONTO_VNEXT}"
echo "  LOG_DIR   = ${LOG_DIR}"
echo "  TS        = ${TS}"
echo

cd "${ROOT}"

# Guardrails
if [[ -n "$(git status --porcelain)" ]]; then
  echo "[ERROR] Working tree is not clean. Commit or restore changes before freeze."
  git status --porcelain
  exit 1
fi

BRANCH="$(git branch --show-current)"
if [[ "${BRANCH}" != "vNext" ]]; then
  echo "[ERROR] Expected branch 'vNext' but found '${BRANCH}'."
  exit 1
fi

git pull --ff-only

# Deterministic rerun of Script 5
echo "[STEP] Re-run Scope↔Governance cross-check (Script 5)"
bash "${ROOT}/scripts/vnext/v6_scope_governance_crosscheck.sh" \
  2>&1 | tee "${LOG_DIR}/v6_scope_governance_crosscheck_${TS}.log"

if [[ -n "$(git status --porcelain)" ]]; then
  echo "[ERROR] Script 5 produced changes during freeze. Freeze must be deterministic."
  echo "Review diff, commit intended outputs, then rerun Script 6."
  git status --porcelain
  exit 1
fi

# Minimal freeze assertions (tight, fast)
test -d "${ROOT}/governance/pilot" || { echo "[ERROR] governance/pilot missing"; exit 1; }
test -d "${ONTO_VNEXT}" || { echo "[ERROR] ontology/vNext missing"; exit 1; }

# Tag message prep (no tag creation)
TAG_DIR="${ROOT}/governance/version-notes"
mkdir -p "${TAG_DIR}"
TAG_MSG="${TAG_DIR}/vNext_tag_message_${TS}.txt"

cat > "${TAG_MSG}" <<TAGEOF
REPAC vNext — Freeze candidate (${TS})

- Deterministic rerun of Script 5 (Scope↔Governance cross-check)
- Governance pilot scaffold present
- Repo clean at freeze checkpoint

NOTE: This file is tag-prep metadata. Tagging is performed manually.
TAGEOF

echo
echo "[OK] Tag message prepared: ${TAG_MSG}"
echo "[DONE] Freeze + tag prep complete (no tag created)."
