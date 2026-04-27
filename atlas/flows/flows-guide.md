# atlas/flows/ — flow pages

End-to-end flows that cross multiple repos. A flow page answers: what happens, across the system, when X occurs?

Related: [dependency-map](../dependency-map.md)

## When to create a flow page

- A single event or user action touches more than two repos.
- Cross-team debugging regularly needs the same mental model.
- Onboarding always asks the same "how does this work?" question.

## Required sections

- Summary (2–3 sentences)
- Diagram (Mermaid)
- Steps (ordered, one bullet per repo involvement)
- Repos involved (Markdown links)
- Events / APIs crossing steps (Markdown links)
- Failure modes (symptom → likely stage → where to look → runbook)
- Related runbooks and standards

## Naming

`<flow-name>.md` in kebab case. Examples: [raw-to-curated-flow](raw-to-curated-flow.md), [vendor-onboarding-flow](vendor-onboarding-flow.md), [event-schema-rollout-flow](event-schema-rollout-flow.md).
