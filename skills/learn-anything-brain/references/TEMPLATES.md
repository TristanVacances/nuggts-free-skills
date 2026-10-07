# Templates

Copy each into `_templates/` of the brain. Every frontmatter field has a literal example value. Example subject: sourdough baking.

## concept (00-concepts/)
```
---
type: concept
tags: [module/02, facet/fermentation]
last-reviewed: 2026-01-15
---
# Bulk Fermentation
<1-3 line context hat, readable cold: what this is and why it matters.>

## ELI20
<Plain language, like explaining to a smart 20-year-old who is new. Analogy welcome. No unexplained jargon. The paragraph to memorize.>

## How it works
<The mechanism or theory. Precise, not padded.>

## Key parameters and typical values
<Controls, ranges, sane starting points. Tables welcome.>

## Pitfalls
<The classic ways people get this wrong.>

## Context notes
<Where sub-contexts diverge, or "[all]" if uniform.>

## Tools
<Paid or standard tool -> free or cheap alternative.>

## See also
- [[related-note]]
```

## technique (01-techniques/)
```
---
type: technique
tags: [module/02, facet/shaping]
last-reviewed: 2026-01-15
---
# Stretch And Fold
<Context hat: what the move is and the effect.>

## ELI20
## How to do it
1. <step>
2. <step>
## When to use it
<Where it shines; where it backfires.>
## Confidence
<N/M and tier per the spec, PROVISIONAL, or "signature/minority move".>
## Tools
## Sources
- [[source-note]]
## See also
- [[concept-note]]
```

## problem (02-problems/): the signature note
```
---
type: problem
tags: [facet/crumb]
last-reviewed: 2026-01-15
---
# My Loaf Is Dense And Gummy
<Context hat: what the problem looks or feels like and why it happens.>

## ELI20
<What is actually going wrong, in everyday terms.>

## Diagnosis
<How to confirm this is the problem (what to look at, measure, taste).>

## Solutions
Ordered by confidence. Scoring rule in CONFIDENCE-SPEC.md.

| # | Approach | When / sub-context | Confidence | Tools |
|---|---|---|---|---|
| 0 | Extend bulk fermentation until dough is ~50% larger | Cool kitchen `[all]` | **PROVISIONAL · High** | Straight-sided jar |
| 1 | Raise hydration slightly and use a hotter preheat | Dense crumb, pale crust `[home-oven]` | **PROVISIONAL · Medium** | Dutch oven |
| 2 | Use a younger, more active starter | Slow-rising dough `[all]` | **PROVISIONAL · Medium** | Rubber band marker |

After the source pass, cells become e.g. `**6/8 · High**`. The `#` column is the fixed solution index votes refer to.

## Sources
Who backs each approach (links to 03-sources/):
- **0** - [[source-note]], [[source-note]]
- **1** - established consensus, count pending (UNVERIFIED)

## See also
- [[concept-note]]
```

## source (03-sources/)
```
---
type: source
tags: [kind/book]
last-reviewed: 2026-01-15
---
# <Source Name>
<Context hat: who they are and why they are authoritative.>

## Identity
- **Kind:** channel / course / book / person
- **Who:** <person or org>
- **URL / handle:** <link>
- **Focus:** <specialism>

## Credibility
<Credentials, track record, one-line why we trust them.>

## Signature techniques
- [[technique-note]] - <their angle>

## Coverage notes
<Strong / weak parts of the curriculum. Biases to flag.>

## Backs which solutions
<Which problem rows cite this source.>
```

## context profile (04-contexts/, optional)
```
---
type: context
tags: [context/whole-grain]
last-reviewed: 2026-01-15
---
# <Sub-context>
<Context hat: what identifies it and what it prioritizes.>
## ELI20
## Conventions
<The "rules" of this context and when they are broken.>
## Signature moves
- [[technique-note]] - <why it defines the context>
## What is different here
<Where this context inverts advice that is standard elsewhere.>
## See also
```

## tool (05-tools/, optional)
```
---
type: tool
tags: [kind/measuring]
last-reviewed: 2026-01-15
---
# <Tool Name>
<Context hat.>
## What it does
## Key controls
## Free / cheap alternative
**<Alternative>** - how close it gets, what differs.
## Serves which concepts
- [[concept-note]]
```
