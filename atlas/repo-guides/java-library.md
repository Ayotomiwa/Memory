# Type: Java Library

## Read before any implementation task

- atlas/standards/java-services.md
- atlas/repo-map/shared-libraries.md — verify this library is listed and understand its declared public contract

## Before changing any public-contract surface

Read these before touching any class, method, or field that consumers may rely on:

- atlas/repo-map/dependency-map.md — all consumer repos
- atlas/repo-map/usage-summaries.md — which consumers use the specific element being changed
- atlas/standards/event-contracts.md — if this library defines event schemas

Pattern: deprecate first, remove only after all consumers have migrated. Do not mutate existing public APIs.

## If unsure whether a surface is public or internal

Check the `Public contract` and `Internal` sections in atlas/repo-map/shared-libraries.md for this library. If not listed there, treat it as public until confirmed otherwise.

## Relevant skills

- `/repo-impact` — **run this before touching any public-contract surface**; lists every confirmed and possibly-affected consumer

Full catalog: `claude-assets/skills-catalog.md`

## Related

[[java-services]] | [[shared-libraries]] | [[dependency-map]] | [[usage-summaries]] | [[event-contracts]]
