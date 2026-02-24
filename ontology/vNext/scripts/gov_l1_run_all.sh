#!/usr/bin/env bash
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

ontology/vNext/scripts/gov_l1_scaffold.sh
ontology/vNext/scripts/gov_l1_audit.sh

echo ""
echo "All Governance L1 packaging steps complete."
