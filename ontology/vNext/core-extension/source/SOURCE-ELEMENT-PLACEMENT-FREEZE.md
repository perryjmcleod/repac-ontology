# SOURCE — Element Placement Freeze

## Objective

Lock the placement of Source elements relative to the frozen Source L1 subset structure.

This freeze establishes the authoritative subset-to-element mapping for Source and prevents structural drift prior to cross-superset stabilization and OWL/TTL population.

## Constraints

- No conceptual expansion
- No ontology drift
- Treat subset freeze as authoritative
- No OWL/TTL population
- Element definitions must remain non-evaluative and mechanism-based

## Frozen Source L1 Subsets

1. `SOURCE-SUBSET-01-human`
2. `SOURCE-SUBSET-02-system`
3. `SOURCE-SUBSET-03-documentary`
4. `SOURCE-SUBSET-04-environmental`

## Frozen Element Placement

### `SOURCE-SUBSET-01-human`

- `SOURCE-EL-01` — Human Action
- `SOURCE-EL-02` — Human Omission

### `SOURCE-SUBSET-02-system`

- `SOURCE-EL-03` — System Signal

### `SOURCE-SUBSET-03-documentary`

- `SOURCE-EL-04` — Instructional Artifact
- `SOURCE-EL-05` — Recorded Artifact

### `SOURCE-SUBSET-04-environmental`

- `SOURCE-EL-06` — Ambient Condition
- `SOURCE-EL-07` — External Influence

## Placement Rules

1. Each Source element is assigned to exactly one L1 subset.
2. No element may exist outside the defined subset structure.
3. No cross-subset duplication is permitted.
4. Element definitions remain mechanism-based and non-evaluative.
5. This placement is authoritative for downstream modelling.

## Controlled Conclusion

Source element placement is frozen and structurally stable.

No further changes to Source element placement are permitted unless a formal subset revision is initiated.