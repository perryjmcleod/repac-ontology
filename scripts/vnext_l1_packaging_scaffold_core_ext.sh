#!/usr/bin/env bash
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
cd "${ROOT}"

BASE="ontology/vNext/core-extension"

mkdir -p "${BASE}/purpose/diagrams"
mkdir -p "${BASE}/value/diagrams"
mkdir -p "${BASE}/imperative/diagrams"
mkdir -p "${BASE}/work/diagrams"
mkdir -p "${BASE}/source/diagrams"

touch "${BASE}/purpose/diagrams/PURPOSE-L1-STRUCTURE.drawio"
touch "${BASE}/value/diagrams/VALUE-L1-STRUCTURE.drawio"
touch "${BASE}/imperative/diagrams/IMPERATIVE-L1-STRUCTURE.drawio"
touch "${BASE}/work/diagrams/WORK-L1-STRUCTURE.drawio"
touch "${BASE}/source/diagrams/SOURCE-L1-STRUCTURE.drawio"

cat > "${BASE}/purpose/PURPOSE-L1-PACKAGING-AUDIT.md" <<'EOM'
# PURPOSE L1 — Packaging Audit
EOM
cat > "${BASE}/value/VALUE-L1-PACKAGING-AUDIT.md" <<'EOM'
# VALUE L1 — Packaging Audit
EOM
cat > "${BASE}/imperative/IMPERATIVE-L1-PACKAGING-AUDIT.md" <<'EOM'
# IMPERATIVE L1 — Packaging Audit
EOM
cat > "${BASE}/work/WORK-L1-PACKAGING-AUDIT.md" <<'EOcat > "${BASE}/work/WORK-L1-PACKAGING-AUDIT.md" <<'EOcat > "OUcat > "${BASE}/G-AUDcat > "${BASE}
# SO# SO# SO# SO# SO# SO# SO# SO# SO# St > "# SO# SOpurpos# SO# SO# SO# SO# SO# SO# SO# SO#<<'EO# SO# SO# SO# SO# SO# SO# SO# Ssion

## Status
NOT FROZEN
EOM
cat > "${BASE}/value/VALUE-L1-FREEZE-DECISION.md" <<'EOM'
# VALUE L1 — Freeze Decision

## Status
NOT FROZEN
EOM
ccccccccccccccccccccccccccccccccccccccccccccccccECISION.md" <<ccccccccccccccccccccccccccccccccccccccccccccccccECISIONT FROZEN
EOM
cat > "${BASE}/work/WORK-L1-FREEZE-DECISION.md" <<'EOM'
cat > "${BASE}/work/WORK-L1-FREEZE-DECISION.md" <<'EOOM
cat > "${BASE}/source/SOURCE-L1-FREEZE-DECISION.md" <<'EOM'cat > "${BASE}/source/SOURCE-L1-FREEZE-DECISION.md" <<'EOM'ccacat > "${BASE}/sourcePURP-SUBSET-00-Tcat > "${BASE}/source/SOURCE-L1-FREEZE-DECISION.md" <<' MIGRATED (Placeholder)
EOM
cat > "${BASE}/value/VAL-SUBSET-00-TO-BE-MIGRATED.md" <<'EOM'
# VALUE L1 Subse# VALUE L1 Subse# VALUE L1 Sulder)
EOM
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccRKcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc-BE-MIGRATED.md" <<'EOM'
# S# S# S# S# S# S# S# S# S# S# S# S# (Placeholder)
EOM

echoechoechoechoechoechoechoechoeeated under ${BASE}"
