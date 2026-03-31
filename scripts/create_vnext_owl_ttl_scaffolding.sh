#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] $*"
  else
    eval "$@"
  fi
}

write_file_if_missing() {
  local target="$1"
  local content="$2"

  if [[ -e "$target" ]]; then
    echo "PASS: exists -> $target"
  else
    echo "CREATE: $target"
    if [[ "$DRY_RUN" -eq 1 ]]; then
      echo "[dry-run] cat > \"$target\""
    else
      cat > "$target" <<EOF
$content
EOF
    fi
  fi
}

capitalize() {
  local s="$1"
  printf '%s' "$s" | awk '{print toupper(substr($0,1,1)) substr($0,2)}'
}

echo "Repository root: $REPO_ROOT"
echo

BASE_IRI="https://raw.githubusercontent.com/perryjmcleod/repac-ontology/vNext/ontology/vNext/core-extension"

declare -a SUPERSETS=(
  "source|ontology/vNext/core-extension/source|repac-source"
  "collaboration|ontology/vNext/core-extension/collaboration|repac-collaboration"
  "governance|ontology/vNext/core-extension/governance|repac-governance"
  "purpose|ontology/vNext/core-extension/purpose|repac-purpose"
  "value|ontology/vNext/core-extension/value|repac-value"
  "communication|ontology/vNext/core-extension/communication|repac-communication"
  "imperative|ontology/vNext/core-extension/imperative|repac-imperative"
  "scope|ontology/vNext/core-extension/scope|repac-scope"
  "work|ontology/vNext/core-extension/work|repac-work"
)

for entry in "${SUPERSETS[@]}"; do
  IFS='|' read -r name dir stem <<< "$entry"

  echo "Scaffolding: $name"
  run "mkdir -p \"$dir\""

  owl_file="$dir/$stem.owl"
  ttl_file="$dir/$stem.ttl"

  iri_base="$BASE_IRI/$name"
  iri_hash="${iri_base}#"
  label_name="$(capitalize "$name")"

  owl_content="<?xml version=\"1.0\"?>
<rdf:RDF xmlns=\"$iri_hash\"
     xml:base=\"$iri_base\"
     xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"
     xmlns:owl=\"http://www.w3.org/2002/07/owl#\"
     xmlns:xml=\"http://www.w3.org/XML/1998/namespace\"
     xmlns:xsd=\"http://www.w3.org/2001/XMLSchema#\"
     xmlns:rdfs=\"http://www.w3.org/2000/01/rdf-schema#\">
    <owl:Ontology rdf:about=\"$iri_base\">
        <rdfs:label>REPAC vNext $label_name ontology</rdfs:label>
        <rdfs:comment>Scaffold ontology file for the REPAC vNext $name superset. Class population pending.</rdfs:comment>
    </owl:Ontology>
</rdf:RDF>"

  ttl_content="@prefix : <$iri_hash> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix xml: <http://www.w3.org/XML/1998/namespace> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

<$iri_base> a owl:Ontology ;
    rdfs:label \"REPAC vNext $label_name ontology\" ;
    rdfs:comment \"Scaffold ontology file for the REPAC vNext $name superset. Class population pending.\" ."

  write_file_if_missing "$owl_file" "$owl_content"
  write_file_if_missing "$ttl_file" "$ttl_content"

  echo
done

echo "Scaffolding pass complete."
echo
echo "Verify with:"
echo "  find ontology/vNext/core-extension -maxdepth 2 \\( -name 'repac-*.owl' -o -name 'repac-*.ttl' \\) | sort"
echo "  git status"