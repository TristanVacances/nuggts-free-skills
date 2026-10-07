---
name: learn-anything-brain
description: >-
  Builds a queryable study brain for any subject you want to learn deeply (a skill, a craft, an exam): a curriculum plus expert sources become a folder of plain Markdown notes, each "how do practitioners actually solve X" answer confidence-rated by how many independent sources agree, plus a generated study guide. Use when you say "learn X deeply", "build a study brain for X", "turn this course into a knowledge base", "prep for an exam", "what do experts agree on for X", "which approach do most practitioners use", or "confidence-rated notes". Works in plain chat, no terminal needed. Marks anything unbacked as UNVERIFIED.
---

# Learn-Anything Brain

Build a folder of Markdown notes that lets you learn a subject to working depth and stay queryable for years. You (the model) write the notes directly into a project folder. No scripts are required.

What makes it a learning tool rather than a notes dump:
- A **spine** taken from the subject's curriculum or syllabus.
- **Problem notes**: the problem as a learner experiences it, then the real spread of approaches practitioners use, each **confidence-rated** (N of M independent sources endorse it).
- An **ELI20** paragraph on every concept (plain language, analogy; the paragraph you memorize).
- A **source pass** that reads expert material to compute those N/M tallies honestly.
- A generated **study guide** built from the notes.

Neutral example used below: learning **sourdough baking** (a problem note: "my loaf is dense and gummy"). Swap in your own subject (SQL, a language, a certification, a craft).

## Use / don't use

Use when the subject is practice-driven (several valid approaches; it matters which ones experts agree on) and good teaching sources exist. Don't use for a pure reference dump with one right answer; plain notes are enough there.

## Sources: your responsibility

Use sources you have the right to use: your own notes, material you bought or were given, public pages you read and summarize, transcripts or captions you are allowed to keep. Never paste whole copyrighted courses, books or paid transcripts into the folder or into chat. Notes are your own words: short facts, summaries and paraphrase, with the source named so a number can be checked. Quote at most a short phrase when a vote needs a locator.

## Step 0: Questions first (ask these, wait for answers)

These change the whole design:
1. **Subject and goal**: pass an exam? reach pro level? a niche skill?
2. **Curriculum**: the real syllabus or table of contents if one exists (it becomes the spine and exam target). If none, draft one and have the user correct it.
3. **Sub-contexts**: the axis along which the same problem is solved differently (style, use case, budget, level). Every solution gets tagged with these. Sourdough: `[beginner-home-oven]`, `[high-hydration]`, `[whole-grain]`, `[all]`.
4. **Level, language, tools**: how much ELI20 scaffolding; output language; for each paid tool, also name a free or cheap alternative.
5. **Source scope**: which and how many expert sources, how deep.
6. **Output**: the folder always; study guide as Markdown, HTML, or both.

## Folder layout (the whole substrate)

Flat, one level of folders, numeric prefix so they sort. Create it in a project folder the user picked (Claude app Projects, Cowork folder, or a Claude Code directory).

```
CLAUDE.md          router: what the brain covers, which folder answers what, rules (see below)
HANDOFF.md         locked decisions, state table, dated journal (newest first), one "Next action"
_inbox.md          capture buffer, newest on top
_index.md          overview: every note as a [[wikilink]], grouped by folder (you maintain it)
00-concepts/       principles (each has ELI20)
01-techniques/     how-to moves
02-problems/       the signature note type (confidence-rated)
03-sources/        one note per expert source (course, book, channel, person)
04-contexts/       optional: one profile per sub-context
05-tools/          optional: tools + free alternatives
STUDY-GUIDE.md     generated; never hand-edited
```

Add folders only when you have notes for them. Rename types to fit the subject.

**Conventions (they keep the brain greppable and connected):**
- One concept per file. Filename = canonical term in kebab-case (`bulk-fermentation.md`).
- Cross-reference with `[[wikilinks]]`. Reciprocal links are mandatory: if A links B, B links back (use `## See also` or a `## Used by` section).
- Every note opens with a 1-3 line context hat, readable with zero prior context. Each section must read correctly pulled out on its own (no "as above").
- Light frontmatter only: `type`, `tags`, `last-reviewed` (every field gets a literal example value; see references/TEMPLATES.md).
- Alias or glossary stubs must not reuse their target's filename stem (ambiguous link).
- `_inbox.md` lines start with `source:` (raw pointer), `candidate:` (proposed note, NOT citable as canon), `doubt:` (open question), `idea:`. At the start of each session, promote, keep with a reason, or drop each line. Only real notes are citable.
- `_index.md` and `STUDY-GUIDE.md` are generated from the notes. If one is wrong, fix the note and regenerate; never patch the output. Regenerate `_index.md` after adding or removing notes.
- `CLAUDE.md` router has four short blocks: domain and goal (3-5 lines), routing rules (which folder answers which question), behavior rules (cite the source note, never invent, flag stale `last-reviewed`, ask when a folder is empty rather than guessing), output format (answer plus linked notes).
- `HANDOFF.md`: locked decisions are append-only (supersede explicitly); the Next action is one explicit pointer. If empty, the brain is idle, not done.

## Pipeline

1. **Scaffold.** Create the folders, `CLAUDE.md`, `HANDOFF.md`, `_inbox.md`, and copy the templates (references/TEMPLATES.md) into a `_templates/` folder so later sessions follow the same shapes.
2. **Curriculum spine.** Write a **shared slug list** first: `_templates/SLUGS.md`, the canonical kebab-case name for every concept, technique, problem and source, including derived names. Then author one atomic note per syllabus item, using the slug list for every `[[link]]`. This gives an exam-useful brain before any source work. If you split authoring across several agents/sessions, give each a disjoint folder, the same slug list and the authoring rules (references/AUTHORING-GUIDE.md), then do a reconciliation pass: list real filenames, fix every link whose target does not exist, and add missing reciprocal links. Never trust predicted slugs.
3. **Discovery (user gate).** Research the most-used courses, books and expert voices on the subject. Present a ranked shortlist with why each is credible and what it is biased toward. The user picks the set. Do not start source work unprompted.
4. **Read the sources.** The user supplies material they may use (their notes, pages, transcripts, summaries). Read in batches, one source at a time. Sample enough of each source to establish its stance on each problem; you do not need every video or chapter. Keep raw material outside the notes folder and do not republish it.
5. **Tally (the confidence pass).** Follow references/DISTILL-GUIDE.md: for each problem, list the canonical solutions as a numbered list; per source, record which solution numbers it endorses (controlled vocabulary, never free text). Then compute N/M per solution and write the tier and named backers into the problem note.
6. **Adjudicate. Do not skip: the tallies are the product.** Voters over-claim systematically. In practice, independent re-checkers drop a noticeable share of votes and approve only a minority of proposed "canonical" promotions, even when the voters were told to be honest. A confidence number built on unchecked votes is a different number, not a weaker one. Have a second pass (a fresh agent or a fresh conversation, not the one that voted) re-verify every high-stakes vote (a "canonical" or "against" stance) against the source text. See the four failure modes in the DISTILL-GUIDE. Until a vote is re-verified it stays unconfirmed.
7. **Study guide.** Generate `STUDY-GUIDE.md` from the notes: per curriculum module, the ELI20 paragraphs first, then problems with their solution tables, tiers colored or labeled High/Medium/Low, sub-context tags visible. If the user wants HTML or a printable PDF, produce one self-contained HTML file from the same content (in the Claude app, an Artifact). For print, expand any collapsible sections first.
8. **Verify.** Every `[[link]]` resolves (list filenames and check), every tally names its backers, every unbacked cell says PROVISIONAL or UNVERIFIED, no note contains pasted source text. Update HANDOFF.md.

## Note types

Templates in references/TEMPLATES.md. Names are adjustable; the signatures are:
- **concept**: a principle. Must carry `## ELI20`.
- **problem** (the signature): problem as experienced, `## Diagnosis`, `## Solutions` table (approach, when / sub-context tag, **confidence N/M and tier**, tools), `## Sources` naming who backs each approach.
- **technique, tool, context profile**: supporting.
- **source**: one per course/book/channel/person. Every tally links back to these so each number is traceable.

## Confidence rules (full text: references/CONFIDENCE-SPEC.md)

`confidence = N / M sources, tier`. M = independent sources that addressed the problem; N = how many endorse this specific approach. High at 0.66 or more, Medium at 0.33 or more, otherwise Low.
- One source = one vote, however many videos or chapters. A source that repeats another is not independent.
- Controlled vocabulary: sources are scored against fixed numbered solutions. Free-text findings from separate passes cannot be summed; collect them as candidate techniques, do not count them.
- Auditable: every tally names its backers. A number with no named backers is UNVERIFIED. Before the source pass, mark cells `PROVISIONAL` plus a tier based on established consensus. Never invent an N/M.
- Markers naming a context ("[context: home oven, 2026]") stay generic: no client names, project names, or file paths.
- Split votes on a genuine debate are a disagreement, not consensus: write `contested N vs M`, not a High tier.

## Studying

When the user moves from building to studying, read references/STUDY-METHOD.md: a demanding-tutor recall loop, hard questions with answers withheld, harsh grading, restating corrections in your own words, and progressive diagrams.

## Gotchas

- **Slug drift.** Parallel authors invent different names for the same thing. Fix the slug list before authoring; reconcile against real filenames after.
- **Quotas are shared.** If several agents or sessions search the web, they draw from one budget. Give each an explicit search budget, prefer opening known official pages, and spend the lookups you cannot afford to lose first. A claim you could not check is UNVERIFIED, not "probably true".
- **Retry "unfetchable".** A page marked unreadable is often script-rendered; try another route (print view, cached text, the user pasting the relevant part) before keeping the flag. Scope a negative ("the page never says X") to the exact document you read.
- **Never rewrite a tally from the file you are editing.** If you update confidence cells in more than one pass, rebuild each cell from the recorded ballot, not from the current cell text, or mixed markers (`[canonical] · PROVISIONAL`) get wiped on the second run. After an update pass, re-run it mentally once: the result must be identical.
- **Cost ceiling is the tally pass, not harvesting.** Sample per source until its stance is clear.
- **Don't cite your own notes as evidence** for the notes.

## Credits

Confidence-tally and adjudication method developed through daily use at Nuggts. The progressive-diagram technique comes from the community `teach` skill (pstack).

---
*Free skill from [Nuggts](https://nuggts.fr). Distilled, tested and kept up to date through months of real daily use. Want the whole toolbox? See the Brain Packs at [nuggts.fr/packs](https://nuggts.fr/packs).*
