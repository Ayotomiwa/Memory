---
name: aws-test-plan
description: Generate a post-deploy AWS validation checklist for the current change
user-invocable: true
---

Generate a post-deploy AWS validation plan for the change in context.

Steps:
1. Read the local CLAUDE.md to identify the repo type and the repo's atlas page path.
2. Read the repo's atlas page from the central context. Focus on the AWS context and Known gotchas sections.
3. Read the type template for the Runbooks section.
4. Based on the change being made, produce a numbered validation checklist covering:
   - Environment: deploy target (typically dev first)
   - Trigger: exact steps to invoke the function/service/job
   - Expected outcome: log output, downstream event published, API response body
   - CloudWatch log group to check and what to look for
   - Alarms to monitor for unexpected triggers or errors
   - DLQ check (if Lambda or SQS consumer)
   - Rollback trigger: what would prompt a rollback and the rollback command

If the change produces an event: add a step to verify the downstream consumer received it.
If the change is a CloudFormation stack update: add a stack events check and export verification.
If the change touches a shared library: note which consumer repos need regression testing.

Keep the checklist under 20 items. Output as a numbered list, not prose.
