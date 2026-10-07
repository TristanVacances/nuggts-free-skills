# Confidence-Rating Spec

Practice-driven subjects have no single right answer. State the spread of approaches and how well backed each is, with the backing auditable.

## Score
```
confidence = N / M sources, TIER
```
- **M**: independent authoritative sources in scope for that problem (the course plus the chosen books, courses, channels that actually address it). Not every source covers every problem; M is "of the sources that spoke to this", and the note says which.
- **N**: how many of those M recommend this specific approach.
- **Tier**: High (N/M at least 0.66, broad consensus), Medium (0.33 up to 0.66, contested or context-dependent), Low (under 0.33, minority, niche, signature move).

## Independence
- One source = one vote, regardless of how many videos or chapters.
- A source repeating another (re-upload, reaction, copy) counts once.
- A course syllabus counts as one source (a strong one if an exam tests it).

## Sub-context tag
If an approach is context-specific, tag it (`[home-oven]`, `[all]`). An approach can be High in one context and Low in another: split the row.

## Contested
When sources split on a genuine controversy, write `contested N vs M`, not a High tier.

## Auditability
Every solution's Sources section names who recommends it, each linking a source note. A number with no named backers is UNVERIFIED. Never invent N or M. Before the source pass use `PROVISIONAL · tier`.

## Marker hygiene
Provenance markers name a generic tested context ("home oven, 2026"), never a person, client, project or file path.

## Optional: weighting
If sources are not equal (theory vs working practitioner), add a `tier:` field on the source note and state a conflict-resolution order up front (for example theory < practitioner), recorded in CLAUDE.md. Flat N/M is the default.

## Worked example (sourdough, row shape)
| # | Approach | When / sub-context | Confidence |
|---|---|---|---|
| 0 | Extend bulk fermentation until ~50% bigger | cool kitchen `[all]` | **7/8 · High** |
| 1 | Raise hydration, hotter preheat | pale crust `[home-oven]` | **4/8 · Medium** |
| 2 | Add a long cold proof | flavor focus `[whole-grain]` | **2/8 · Low** |
(Numbers illustrative.)
