# Event contracts - standards

How events are defined, versioned, produced, and consumed.

Related: [[shared-libraries]], [[dependency-map]], [[java-services]], [[python-services]], [[aws-testing]]

## Where events live

- Java and Python schemas live in [[data-events]].

Do not hand-roll event JSON in a service. Use the shared library types.

Event names and dependencies are documented inline in repo pages, flow pages, and [[dependency-map]]. Do not create standalone per-event atlas pages.

## Naming

- Event name: `<domain>.<entity>.<past-tense-verb>` (e.g., `payment.status.updated`).

## Schema change rules

Additive changes (safe):
- New optional field.
- New enum value consumers gracefully ignore.

Breaking changes (not safe):
- Removing or renaming a field.
- Changing a field type.
- Changing required/optional.
- Removing an enum value some consumer matches on.

For breaking changes:

1. Introduce the new schema as a new version (parallel), do not mutate the old.
2. Update all consumers listed in [[dependency-map]] to handle both versions.
3. Cut producers over to the new version.
4. Remove the old version only after every consumer has been confirmed migrated.

## Compatibility expectations

- Producers must produce a schema consumers already accept.
- Consumers must tolerate unknown fields.
- Consumers must not fail on new enum values unless the domain requires exhaustive handling - if it does, coordinate via the schema change rules above.

## Validation

- Producers validate against the shared library before publishing.
- Consumers validate on receipt; validation failure should route to DLQ, not crash the consumer.

## Testing contract changes

See [[aws-testing]] - validate against all downstream consumers in `dev` before merging to `prod`.

## Starter sources

> Expand as staging material compiles in.
