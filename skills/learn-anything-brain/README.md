# Learn-Anything Brain

**Turn a curriculum and a few expert sources into a folder of notes that tells you what practitioners actually agree on.**

**What it does:** you name a subject (sourdough, SQL, a certification). Claude:
1. asks six questions: your goal, the syllabus, the styles or contexts, your level, which sources, which output
2. builds a project folder of plain Markdown notes: concepts with a plain-language ELI20 paragraph, how-to techniques, and "problem" notes
3. rates each approach in a problem note by how many independent sources back it (for example 6 of 8, High), with the backers named
4. marks anything it cannot back as PROVISIONAL or UNVERIFIED instead of inventing a number
5. has a second pass re-check the votes, because a first pass over-claims
6. generates a study guide, plus a question-and-grade loop for actually learning it

No terminal or scripts needed.

**Before:** you read ten videos and three books, get ten different answers, and cannot tell which advice is mainstream and which is one person's habit.
**After:** every "how do I fix X" question has a table: the approaches, when each applies, and how well each is backed. You can query it, and study from it.

**Sources:** use material you have the right to use. The skill keeps notes in your own words and never stores whole copyrighted courses.

**Credits:** method developed through daily use at Nuggts; progressive-diagram technique from the community `teach` skill (pstack).

Install: see [INSTALL.md](../../INSTALL.md).
