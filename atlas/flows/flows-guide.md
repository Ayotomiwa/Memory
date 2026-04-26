# atlas/flows/ — flow pages

End-to-end flows that cross multiple repos. A flow page answers: what happens, across the system, when X occurs?

Related: [[dependency-map]]

## When to create a flow page

- A single event or user action touches more than two repos.
- Cross-team debugging regularly needs the same mental model.
- Onboarding always asks the same "how does this work?" question.

## Required sections

- Summary (2–3 sentences)
- Diagram (Mermaid)
- Steps (ordered, one bullet per repo involvement)
- Repos involved (wikilinks)
- Events / APIs crossing steps (wikilinks)
- Failure modes (symptom → likely stage → where to look → runbook)
- Related runbooks and standards

## Naming

`<flow-name>.md` in kebab case. Example: `raw-to-curated-flow.md`. See [[raw-to-curated-flow]] for a working example.
