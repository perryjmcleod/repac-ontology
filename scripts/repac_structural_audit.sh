#!/bin/bash

BASE="ontology/vNext/core-extension"

SUPERSETS=(
purpose
value
imperative
communication
collaboration
governance
scope
source
work
)

echo "REPAC vNext Structural Integrity Audit"
echo "--------------------------------------"

for s in "${SUPERSETS[@]}"
do
  DIR="$BASE/$s"

  echo ""
  echo "Checking: $s"

  ls "$DIR" | grep -E "L1" || echo "Missing L1 artifacts"

  if [ -f "$DIR/repac-$s.owl" ]; then
    echo "OWL stub: PASS"
  else
    echo "OWL stub: FAIL"
  fi

  if [ -f "$DIR/repac-$s.ttl" ]; then
    echo "TTL stub: PASS"
  else
    echo "TTL stub: FAIL"
  fi

  if [ -d "$DIR/diagrams" ]; then
    echo "Diagrams directory: PASS"
  else
    echo "Diagrams directory: FAIL"
  fi
done