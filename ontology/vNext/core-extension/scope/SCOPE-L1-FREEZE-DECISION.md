# SCOPE L1 — Freeze Decision

## Status
Scope L1 Subsets are frozen. This decision governs all subsequent Scope L1 diagramming, formalization, and validation work.

---

## Frozen Scope L1 Subsets

A complete Scope assertion requires the following Subsets:

1. Perspective  
2. Boundary  
3. Granularity  
4. Interval  

These Subsets are structural and non-normative.  
They define the geometry of analytical delimitation.

---

## Superseded Candidate Labels

The following candidate labels appear in earlier Scope L1 artifacts and are now superseded. They must not be treated as L1 Subsets.

### Boundary Outcomes (Not Subsets)

The following are outcomes (properties) of Boundary assertion:

- Inclusion Boundary → Boundary outcome: `includes`
- Exclusion Boundary → Boundary outcome: `excludes`

These are effects of Boundary partition, not independent structural dimensions.

---

### Granularity Normalization

- Granularity Level → Granularity  

“Level” does not introduce an independent structural axis and collapses into Granularity.

---

### Perspective Examples (Not Boundary Subtypes)

The following labels refer to what class of entities is being bounded. They are treated as Perspective examples or potential future controlled vocabulary items:

- Actor Boundary → Perspective example (entity class: Actor)
- Artefact Boundary → Perspective example (entity class: Artefact)
- Constraint Boundary → Perspective example (entity class: Constraint)

These are not Boundary subtypes and are not L1 Subsets.

---

## Rationale

This freeze preserves Scope L1 as structural geometry rather than a domain taxonomy.

The four frozen Subsets (Perspective, Boundary, Granularity, Interval) were validated for:

- Structural independence  
- Non-redundancy  
- Non-overlap  
- Cross-case necessity  

Validation occurred through stress-testing against Cases 01, 02, 04, and 05. All other prior labels either collapsed structurally into these Subsets or represented Boundary outcomes.

---

## Structural Justification

Layer-1 satisfies:

- Structural distinctness across Subsets  
- Necessary-but-not-sufficient principle  
- No overlap with:
  - Purpose  
  - Imperative  
  - Work  
  - Governance  
  - Communication  
  - Collaboration  
  - Value  
- No context reification  
- No sequencing or workflow encoding  
- No prescriptive leakage  

---

## Validation Evidence

✔ Cross-superset collision audit completed  
✔ Multi-case instantiation validated (Cases 01, 02, 04, 05)  
✔ Structural diagram revised and aligned  
✔ OWL structural stub implemented  
✔ SHACL completeness constraints implemented  

All validation criteria met.

---

## Known Risk Areas (Monitored)

Primary semantic drift risk areas remain:

1. Boundary drifting into governance authority semantics  
2. Perspective drifting into context reification  
3. Interval drifting into scheduling or project management semantics  

Future changes must re-run drift audit.

---

## What This Freeze Does NOT Lock

This freeze applies only to structural Layer-1 membership.

It does not lock:

- Layer-2 decomposition  
- Controlled vocabularies for Perspective  
- TTL class expansion  
- Object/Data property elaboration  
- SHACL refinements  
- Cross-superset mappings  

---

## Change Control

Any modification to Scope L1 Subsets requires:

- Explicit justification  
- Collision audit rerun  
- Case revalidation  
- Diagram revision  
- New freeze declaration  

---

Status: **STRUCTURALLY LOCKED**
