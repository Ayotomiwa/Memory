# Type: Java Library

## Read before any implementation task

- atlas/standards/java-services.md
- atlas/dependency-map.md — verify consumers and cross-repo dependencies

## Before changing any public-contract surface

Read these before touching any class, method, or field that consumers may rely on:

- atlas/dependency-map.md — all consumer repos
- local CLAUDE.md Dependencies and usage sections — which consumers use the specific element being changed
- atlas/standards/event-contracts.md — if this library defines event schemas

Pattern: deprecate first, remove only after all consumers have migrated. Do not mutate existing public APIs.

## If unsure whether a surface is public or internal

Check the library repo page and consumer usage notes. If the surface is not clearly internal, treat it as public until confirmed otherwise.

## Relevant skills

- `/repo-impact` — **run this before touching any public-contract surface**; lists every confirmed and possibly-affected consumer

Full catalog: `claude-assets/skills-catalog.md`

