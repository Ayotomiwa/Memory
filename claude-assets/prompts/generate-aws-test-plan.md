Generate a post-deploy AWS validation plan for this change.

Use the local repo context and the central engineering context.

Before answering:
1. Read the local `CLAUDE.md`.
2. Follow its required startup routing.
3. Read `atlas/standards/aws-testing.md`.
4. Read any relevant repo page AWS context and runbooks.

Return:
- resources affected
- pre-deploy checks
- deploy-time checks
- post-deploy functional checks
- log, metric, alarm, and rollback checks
- gaps or assumptions that need confirmation
