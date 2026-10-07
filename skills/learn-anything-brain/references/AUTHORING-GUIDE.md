# Authoring Guide (every note, every author)

## Before you write
1. Read `CLAUDE.md` (router and rules).
2. Read the template for your note type in `_templates/`.
3. For problem or technique notes, read CONFIDENCE-SPEC.md.
4. Open `_templates/SLUGS.md` and use only those slugs in `[[links]]`.

## Hard rules
- One concept per file; filename = canonical kebab-case term.
- Follow the template exactly: same frontmatter fields, same headings. Set `last-reviewed` to today's date.
- ELI20 is mandatory on every concept, technique and context note: plain language, an analogy, no unexplained jargon.
- Tools: whenever you name a paid tool, also name a free or cheap equivalent.
- Wikilink liberally. Targets may not exist yet, but they must be in the slug list or be added to it.
- Add the reciprocal link in the target's See also / Used by section.
- If the user's language differs from the source language of the curriculum, add the term in the other language on exam-relevant concepts.
- Accuracy over completeness. Stay within established consensus; use standard values. If contested or unsure, say so in the line. Never fabricate.
- Own words. No pasted source text.
- Concise, dense, no filler.

## Confidence numbers
- Before the source pass: list the genuine spread of approaches, mark each cell `PROVISIONAL` plus a tier from established consensus. In Sources, cite a named source only where it actually prescribes the approach; otherwise write "established consensus, count pending harvest (UNVERIFIED)".
- Never invent an N/M like "9/12". It is backed by named sources or it is PROVISIONAL / UNVERIFIED.

## Do not
- Edit files outside your assigned folder, the templates, CLAUDE.md, or another author's notes.
- Regenerate `_index.md` mid-run (the coordinator does it after all notes land).
