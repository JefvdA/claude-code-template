# Domain-Driven Design rules

## Strategic

- The system is split into bounded contexts, listed in `docs/context-map.md`. Every change belongs to one context; name it in the commit scope.
- A term means one thing inside a context. If two contexts use the same word differently, that is fine; document both in `docs/glossary.md`.
- A change that adds a context, or changes how two contexts relate, needs an ADR and an update to the context map.

## Tactical

- **Layers** per context: `domain` (entities, value objects, aggregates, domain events, domain services), `application` (use cases, ports), `infrastructure` (adapters: DB, HTTP, messaging), `interface` (API controllers, UI).
- **Dependencies point inward**: interface → application → domain. Infrastructure implements ports defined in application or domain. Domain depends on nothing outside itself.
- **Aggregates** protect their invariants. Change state only through aggregate methods, one aggregate per transaction, and reference other aggregates by ID.
- **Value objects** are immutable and validate themselves on creation. Prefer them over primitives for domain concepts (`EmailAddress`, not `string`).
- **Domain events** are named in the past tense (`OrderPlaced`) and are how contexts react to each other without tight coupling.
- **Anti-corruption layer**: translate external or upstream models at the boundary; never let them leak into the domain.

## Tests

- Domain logic gets fast unit tests with no I/O.
- Acceptance criteria from the spec (Given/When/Then) map to tests at the application or API level, named after the scenario.
