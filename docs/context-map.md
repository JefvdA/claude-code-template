# Context map

The bounded contexts of this system, what each one owns, and how they relate.
Read this before planning or changing code. Change it through a PR (usually together with a spec).

## Contexts

| Context | Type | Owns (aggregates / data) | Code location |
| :- | :- | :- | :- |
| _Example_ | _Core / Supporting / Generic_ | _Aggregates and data this context is the source of truth for_ | _`src/<context>/`_ |

## Relationships

How contexts talk to each other. Use the standard DDD patterns:
Customer/Supplier, Conformist, Anti-Corruption Layer, Open Host Service / Published Language, Shared Kernel, Separate Ways.

| Upstream | Downstream | Pattern | Interface (API, events, module) |
| :- | :- | :- | :- |
| _A_ | _B_ | _Customer/Supplier_ | _`A.publicApi` / `OrderPlaced` event_ |

## Parallel work rule

Slices in different contexts may be built in parallel.
Slices in the same context, or that change a relationship above, are built one after another.
