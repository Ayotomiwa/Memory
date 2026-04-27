# Prompts catalog

Team prompts live in `claude-assets/prompts/`. Invoke by copying the prompt text into a Claude session.

For adding prompts: [claude-assets-guide](claude-assets-guide.md).

---

| Prompt | Purpose | Source | When to use |
|---|---|---|---|
| `plan-change-with-central-context` | Ask Claude to plan a change using both local repo and central engineering context | `claude-assets/prompts/plan-change-with-central-context.md` | Starting any non-trivial change inside a repo |
| `generate-aws-test-plan` | Generate a post-deploy AWS validation plan for a change | `claude-assets/prompts/generate-aws-test-plan.md` | Before merging a runtime-affecting change; prefer `/aws-test-plan` skill if available |
| `impact-analysis-for-event-change` | Enumerate every repo affected by an event schema change | `claude-assets/prompts/impact-analysis-for-event-change.md` | Any change to an event in [data-lib-events](../atlas/repos/data-lib-events.md); prefer `/repo-impact` skill if available |
