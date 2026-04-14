#!/usr/bin/env python3

from __future__ import annotations

import json
import re
import shutil
import subprocess
import sys
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Iterable

from rdflib import Graph, RDF, RDFS, OWL, URIRef


REPO_ROOT = Path(__file__).resolve().parents[2]
ONTOLOGY_ROOT = REPO_ROOT / "ontology" / "vNext" / "core-extension"
DOCS_ROOT = REPO_ROOT / "ontology" / "vNext" / "docs"
AGGREGATE_ROOT = REPO_ROOT / "ontology" / "vNext" / "aggregate"
VIEWER_ROOT = REPO_ROOT / "viewer" / "generated"
SCHEMA_VALIDATOR = REPO_ROOT / "tooling" / "export" / "validate_viewer_export.py"

SUPERSET_CONFIG = [
    {
        "name": "source",
        "id": "SOURCE",
        "dir": "source",
        "owl": "repac-source.owl",
        "ttl": "repac-source.ttl",
        "element_prefix": "SOURCE-EL-",
        "subset_prefix": "SOURCE-SUBSET-",
        "documents": {},
        "show_elements": False,
    },
    {
        "name": "collaboration",
        "id": "COLLABORATION",
        "dir": "collaboration",
        "owl": "repac-collaboration.owl",
        "ttl": "repac-collaboration.ttl",
        "element_prefix": "COLLAB-EL-",
        "subset_prefix": "COLLAB-SUBSET-",
        "documents": {},
        "show_elements": False,
    },
    {
        "name": "governance",
        "id": "GOVERNANCE",
        "dir": "governance",
        "owl": "repac-governance.owl",
        "ttl": "repac-governance.ttl",
        "element_prefix": "GOV-EL-",
        "subset_prefix": "GOV-SUBSET-",
        "documents": {
            "freezeDecision": "GOVERNANCE-L1-FREEZE-DECISION.md",
            "semanticAudit": "GOVERNANCE-L1-SEMANTIC-AUDIT.md",
            "elementPlacementFreeze": "GOVERNANCE-ELEMENT-PLACEMENT-FREEZE.md",
            "elementReconciliation": "GOVERNANCE-L1-ELEMENT-RECONCILIATION.md",
        },
        "boundaryLinks": [
            "WORK-GOVERNANCE-CROSS-SUPERSET-INTEGRITY-AUDIT",
            "VALUE-GOVERNANCE-CROSS-SUPERSET-INTEGRITY-AUDIT",
            "GOVERNANCE-COMMUNICATION-CROSS-SUPERSET-INTEGRITY-AUDIT",
        ],
        "show_elements": True,
    },
    {
        "name": "purpose",
        "id": "PURPOSE",
        "dir": "purpose",
        "owl": "repac-purpose.owl",
        "ttl": "repac-purpose.ttl",
        "element_prefix": "PUR-EL-",
        "subset_prefix": "PUR-SUBSET-",
        "documents": {},
        "show_elements": False,
    },
    {
        "name": "value",
        "id": "VALUE",
        "dir": "value",
        "owl": "repac-value.owl",
        "ttl": "repac-value.ttl",
        "element_prefix": "VAL-EL-",
        "subset_prefix": "VAL-SUBSET-",
        "documents": {},
        "show_elements": False,
    },
    {
        "name": "communication",
        "id": "COMMUNICATION",
        "dir": "communication",
        "owl": "repac-communication.owl",
        "ttl": "repac-communication.ttl",
        "element_prefix": "COMM-EL-",
        "subset_prefix": "COMM-SUBSET-",
        "documents": {},
        "show_elements": False,
    },
    {
        "name": "imperative",
        "id": "IMPERATIVE",
        "dir": "imperative",
        "owl": "repac-imperative.owl",
        "ttl": "repac-imperative.ttl",
        "element_prefix": "IMP-EL-",
        "subset_prefix": "IMP-SUBSET-",
        "documents": {},
        "show_elements": False,
    },
    {
        "name": "scope",
        "id": "SCOPE",
        "dir": "scope",
        "owl": "repac-scope.owl",
        "ttl": "repac-scope.ttl",
        "element_prefix": "SCOPE-EL-",
        "subset_prefix": "SCOPE-SUBSET-",
        "documents": {},
        "show_elements": False,
    },
    {
        "name": "work",
        "id": "WORK",
        "dir": "work",
        "owl": "repac-work.owl",
        "ttl": "repac-work.ttl",
        "element_prefix": "WORK-EL-",
        "subset_prefix": "WORK-SUBSET-",
        "documents": {},
        "show_elements": True,
    },
]


@dataclass
class Entity:
    id: str
    label: str
    comment: str
    iri: str
    parent_id: str | None = None


def log(message: str) -> None:
    print(message)


def die(message: str, exit_code: int = 1) -> None:
    print(f"ERROR: {message}", file=sys.stderr)
    sys.exit(exit_code)


def slugify(value: str) -> str:
    value = value.strip().lower()
    value = re.sub(r"[^a-z0-9]+", "-", value)
    value = re.sub(r"-{2,}", "-", value)
    return value.strip("-")


def ensure_dir(path: Path) -> None:
    path.mkdir(parents=True, exist_ok=True)


def write_json(path: Path, data: dict) -> None:
    ensure_dir(path.parent)
    with path.open("w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
        f.write("\n")


def class_local_name(uri: URIRef) -> str:
    text = str(uri)
    if "#" in text:
        return text.rsplit("#", 1)[1]
    return text.rstrip("/").rsplit("/", 1)[-1]


def literal_text(graph: Graph, subject: URIRef, predicate: URIRef) -> str:
    value = graph.value(subject, predicate)
    return str(value).strip() if value is not None else ""


def load_graph(owl_path: Path, ttl_path: Path) -> Graph:
    graph = Graph()

    if owl_path.exists() and owl_path.stat().st_size > 0:
        graph.parse(owl_path)
    elif ttl_path.exists() and ttl_path.stat().st_size > 0:
        graph.parse(ttl_path, format="turtle")
    else:
        die(f"Neither populated OWL nor TTL file found for {owl_path.parent}")

    return graph


def iter_named_classes(graph: Graph) -> Iterable[URIRef]:
    for subject in graph.subjects(RDF.type, OWL.Class):
        if isinstance(subject, URIRef):
            yield subject


def extract_entities(
    graph: Graph,
    expected_superset_id: str,
    subset_prefix: str,
    element_prefix: str,
) -> tuple[Entity, list[Entity], list[Entity]]:
    classes = list(iter_named_classes(graph))
    entities: dict[str, Entity] = {}

    for cls in classes:
        local_name = class_local_name(cls)
        label = literal_text(graph, cls, RDFS.label) or local_name.replace("-", " ")
        comment = literal_text(graph, cls, RDFS.comment)
        entities[local_name] = Entity(
            id=local_name,
            label=label,
            comment=comment,
            iri=str(cls),
        )

    if expected_superset_id not in entities:
        die(f"Superset class '{expected_superset_id}' not found in ontology")

    for cls in classes:
        child_id = class_local_name(cls)
        for parent in graph.objects(cls, RDFS.subClassOf):
            if isinstance(parent, URIRef):
                parent_id = class_local_name(parent)
                if child_id in entities and parent_id in entities:
                    entities[child_id].parent_id = parent_id

    superset = entities[expected_superset_id]

    subsets = sorted(
        [e for e in entities.values() if e.id.startswith(subset_prefix)],
        key=lambda e: e.id,
    )
    elements = sorted(
        [e for e in entities.values() if e.id.startswith(element_prefix)],
        key=lambda e: e.id,
    )

    return superset, subsets, elements


def source_file_for_subset(superset_dir: Path, subset_id: str) -> str | None:
    candidate = superset_dir / f"{subset_id}.md"
    return str(candidate.relative_to(REPO_ROOT)) if candidate.exists() else None


def build_superset_json(
    config: dict,
    superset: Entity,
    subsets: list[Entity],
) -> dict:
    superset_dir = ONTOLOGY_ROOT / config["dir"]

    documents = {}
    for key, filename in config.get("documents", {}).items():
        doc_path = superset_dir / filename
        if doc_path.exists():
            documents[key] = str(doc_path.relative_to(REPO_ROOT))

    payload = {
        "artifactType": "ontology_superset",
        "id": superset.id,
        "slug": config["name"],
        "label": superset.label,
        "comment": superset.comment or f"REPAC {superset.label} superset.",
        "authoritative": True,
        "status": "validated",
        "ontologyRelease": "vnext-1.0.0",
        "ontologyFile": str((superset_dir / config["owl"]).relative_to(REPO_ROOT)),
        "ttlFile": str((superset_dir / config["ttl"]).relative_to(REPO_ROOT)),
        "parent": None,
        "children": [s.id for s in subsets],
        "subsets": [
            {
                "id": s.id,
                "label": s.label,
                "slug": slugify(s.id),
            }
            for s in subsets
        ],
        "documents": documents,
        "boundaryLinks": config.get("boundaryLinks", []),
        "modelingNotes": [],
        "viewerHints": {
            "defaultTab": "structure",
            "showElements": bool(config.get("show_elements", False)),
        },
    }
    return payload


def build_subset_json(
    subset: Entity,
    child_elements: list[Entity],
    superset_dir: Path,
) -> dict:
    source_path = source_file_for_subset(superset_dir, subset.id)
    source_files = {}
    if source_path:
        source_files["subsetDefinition"] = source_path

    payload = {
        "artifactType": "ontology_subset",
        "id": subset.id,
        "slug": slugify(subset.id),
        "label": subset.label,
        "comment": subset.comment or f"{subset.label} subset.",
        "authoritative": True,
        "status": "validated",
        "parent": subset.parent_id,
        "children": [e.id for e in child_elements],
        "hasElements": bool(child_elements),
        "sourceFiles": source_files,
        "boundaryNotes": [],
        "modelingExceptions": [],
    }
    return payload


def build_element_json(element: Entity) -> dict:
    return {
        "artifactType": "ontology_element",
        "id": element.id,
        "slug": slugify(element.id),
        "label": element.label,
        "comment": element.comment or f"{element.label} element.",
        "authoritative": True,
        "status": "validated",
        "parent": element.parent_id,
        "children": [],
    }


def build_ontology_index(
    all_supersets: list[dict],
    subset_count: int,
    element_count: int,
) -> dict:
    return {
        "artifactType": "ontology_aggregate",
        "id": "REPAC-VNEXT-ONTOLOGY-INDEX",
        "slug": "repac-vnext-ontology-index",
        "label": "REPAC vNext Ontology Index",
        "comment": "Aggregate index for exported REPAC vNext ontology viewer artifacts.",
        "authoritative": True,
        "status": "validated",
        "ontologyRelease": "vnext-1.0.0",
        "parent": None,
        "children": [s["id"] for s in all_supersets],
        "entityCounts": {
            "supersets": len(all_supersets),
            "subsets": subset_count,
            "elements": element_count,
        },
    }


def build_manifest() -> dict:
    aggregate_owl = AGGREGATE_ROOT / "repac-vnext-aggregate.owl"
    payload = {
        "exportContractVersion": "1.0.0",
        "viewerDataVersion": "1.0.0",
        "ontologyRelease": "vnext-1.0.0",
        "ontologyLayerPath": "ontology/vNext/core-extension",
        "generatedAt": datetime.now(timezone.utc).isoformat(),
        "sourceOfTruth": [
            "ontology/vNext/core-extension",
            "ontology/vNext/docs/VIEWER-EXPORT-CONTRACT.md",
            "ontology/vNext/docs/INTERROGATIVE-DERIVATION-RULES.md",
            "ontology/vNext/docs/ONTOLOGY-MODELING-EXCEPTIONS.md",
            "ontology/vNext/docs/RELEASE-BOUNDARY.md",
        ],
        "supersets": [cfg["name"] for cfg in SUPERSET_CONFIG],
        "notes": [
            "Generated by tooling/export/build_viewer_data.py",
        ],
    }
    if aggregate_owl.exists():
        payload["aggregateOntologyPath"] = str(aggregate_owl.relative_to(REPO_ROOT))
    return payload


def clean_output_dir(output_dir: Path) -> None:
    if output_dir.exists():
        shutil.rmtree(output_dir)
    ensure_dir(output_dir)
    ensure_dir(output_dir / "supersets")
    ensure_dir(output_dir / "documents")
    ensure_dir(output_dir / "navigation")
    ensure_dir(output_dir / "interrogatives")


def run_validation(output_dir: Path) -> None:
    if not SCHEMA_VALIDATOR.exists():
        die(f"Validator not found: {SCHEMA_VALIDATOR}")

    log("")
    log("Running viewer export validation...")
    result = subprocess.run(
        [sys.executable, str(SCHEMA_VALIDATOR), str(output_dir)],
        cwd=REPO_ROOT,
        text=True,
    )

    if result.returncode != 0:
        die("Viewer export validation failed", result.returncode)

    log("Viewer export validation passed.")


def main() -> int:
    output_dir = Path(sys.argv[1]).resolve() if len(sys.argv) > 1 else VIEWER_ROOT

    log(f"Building REPAC viewer data into: {output_dir}")
    clean_output_dir(output_dir)

    all_superset_payloads: list[dict] = []
    subset_payloads: list[dict] = []
    element_payloads: list[dict] = []

    for config in SUPERSET_CONFIG:
        superset_dir = ONTOLOGY_ROOT / config["dir"]
        owl_path = superset_dir / config["owl"]
        ttl_path = superset_dir / config["ttl"]

        log(f"Parsing {config['name']} ontology...")
        graph = load_graph(owl_path, ttl_path)
        superset, subsets, elements = extract_entities(
            graph=graph,
            expected_superset_id=config["id"],
            subset_prefix=config["subset_prefix"],
            element_prefix=config["element_prefix"],
        )

        superset_payload = build_superset_json(config, superset, subsets)
        all_superset_payloads.append(superset_payload)
        write_json(output_dir / "supersets" / f"{config['name']}.json", superset_payload)

        for subset in subsets:
            child_elements = [e for e in elements if e.parent_id == subset.id]
            subset_payload = build_subset_json(subset, child_elements, superset_dir)
            subset_payloads.append(subset_payload)

        for element in elements:
            element_payloads.append(build_element_json(element))

    ontology_index = build_ontology_index(
        all_supersets=all_superset_payloads,
        subset_count=len(subset_payloads),
        element_count=len(element_payloads),
    )
    write_json(output_dir / "ontology-index.json", ontology_index)

    manifest = build_manifest()
    write_json(output_dir / "manifest.json", manifest)

    log("")
    log("Build summary:")
    log(f"- Supersets: {len(all_superset_payloads)}")
    log(f"- Subsets:   {len(subset_payloads)}")
    log(f"- Elements:  {len(element_payloads)}")

    run_validation(output_dir)

    log("")
    log("Build complete.")
    return 0


if __name__ == "__main__":
    sys.exit(main())