# Source Pass Guide: read sources, record endorsements

For one source (or a batch from ONE source) at a time. Used by you, or by a fresh helper conversation/agent.

## Inputs
- The numbered solution list for each problem (from the `## Solutions` tables: the `#` column is the vote unit).
- The source material the user is allowed to use (their notes, summaries, pages, transcripts), one source at a time.

## Job
For each problem the material covers, record which solution numbers the source teaches or clearly endorses: it recommends or demonstrates it, not merely mentions it. Be strict: endorsement means "they would tell you to do it".

Also capture **novel techniques**: specific, genuinely taught, not in the canonical list, deduplicated. These become candidate notes, never counted.

## Output shape (per source)
```
source: <slug>
material_read: <count>
endorsements:
  - problem: <problem-slug>
    solutions: [0, 2]
    quote_locator: "<short phrase + where (page, timestamp, section)>"
novel_techniques:
  - title, summary, context-tag, related_problem
```
Omit problems the material does not cover. Do not guess.

## Rules
- Endorsement must come from the material read, not your prior knowledge.
- No invented numbers.
- Assume no web search is available; if a claim cannot be checked from the material, mark it unverified.

## The four over-claims (every voter makes them, so rule them out up front)
- **Host is not guest.** Vote only what this source itself asserts. A guest's, interviewee's or relayed study's claim is not the host's endorsement; attribute it to the speaker.
- **Existence is not mechanic.** Evidence that a feature, metric or tool exists does not confirm that the row's tactic is how it works. The most common inflated vote.
- **Respect scope.** If a row is scoped to one context, medium or platform, evidence from another cannot endorse or oppose it. Omit.
- **No circular corroboration.** The brain's own notes are not independent evidence. Neither is a page that returned an empty shell: if you did not read the actual words, you have no vote.

## Adjudication
`canonical` (this is THE mechanic) and `against` are high-stakes stances. Hold them as unconfirmed until an independent re-checker (fresh agent or conversation) re-verifies the quote, checks approach-match, scope and host vs guest, and marks each vote `approved`, `downgraded` or `dropped` with a one-line note. Only approved votes count toward N. Write quote and locator precisely enough for someone else to find them.

## Aggregation (by hand or by table)
Per problem: M = number of sources with at least one approved endorsement or explicit non-endorsement of that problem; N per solution = sources endorsing it. Compute tier per CONFIDENCE-SPEC. Write the cell, and list backers in `## Sources`. Keep the vote table (source x solution) in `_templates/ballot.md` so the numbers can be rebuilt from it later.
