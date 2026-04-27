# New developer - start here

Welcome. Read this page first, then follow the links in the order given.

## What this repo is

This is the team's central engineering context - a persistent, LLM-maintained knowledge base that describes:

- our repos and how they connect
- our standards
- our flows
- our runbooks
- our decisions

You do **not** need to read the whole thing. The point of [index](../index.md) is to route you to what you need.

## Day 1

1. Read [CLAUDE](../CLAUDE.md) - the operating rules for this repo.
2. Read [index](../index.md) - the map of what exists.
3. Read [raw-to-curated-flow](../atlas/flows/raw-to-curated-flow.md) - the main business flow.
4. Skim [repo-catalog](../atlas/repo-catalog.md) - get a feel for what exists.

## Day 2-3

Pick the repo you'll start with. Then:

1. Clone it.
2. Read its local `CLAUDE.md` (short by design).
3. Open its page in `atlas/repos/<repo>.md`.
4. Read any flows/standards/runbooks that page links to.
5. Start Claude with the central context attached:
   ```
   claude --add-dir ~/company/engineering-context
   ```
6. Ask Claude to plan your first small task using both the local and central context.

## Standards you will touch

Depending on your repo:

- [java-services](../atlas/standards/java-services.md)
- [python-services](../atlas/standards/python-services.md)
- [aws-lambda](../atlas/standards/aws-lambda.md)
- [cloudformation](../atlas/standards/cloudformation.md)
- [aws-testing](../atlas/standards/aws-testing.md)
- [event-contracts](../atlas/standards/event-contracts.md)
- logging/metrics expectations

## When you learn something worth remembering

See [using-claude-with-this-repo](using-claude-with-this-repo.md) for how to feed durable learnings back into this repo. Short version:

- Drop a raw note in the right `staging/` subfolder.
- Let the next lint pass (or Claude, on demand) compile it into the atlas.
