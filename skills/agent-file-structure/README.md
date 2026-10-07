# Agent File Structure

**Set up the folder, the context file and the memory once, so Claude stops starting from zero.**

**What it does:** you say "every new chat starts from scratch" or "where does CLAUDE.md go". It asks you a few questions, one at a time, then creates:
1. one home folder for all your AI work
2. a `CLAUDE.md` with your rules and preferences
3. context files (business, offer, customers, voice, goals), only with things you actually told it
4. a memory folder: `now.md` for what is active, session notes for what happened
5. one folder per project, with one context file each
6. a `.env` for secrets and a `.gitignore` so keys never leak

It explains where each file goes for the Claude desktop app, Cowork with a project folder, Claude Code, and chat Projects without folder access.

**Before:** every new chat, you re-explain who you are, what the project is and what you decided last week.
**After:** you open the folder, say "read CLAUDE.md and now.md, then continue", and Claude already knows. At the end of a session it updates the notes.

**Credits:** the scaffold is by Cooper Simson ([@cooper.simson](https://instagram.com/cooper.simson)). The audit list is adapted from Dryxio (@dryxio). The job-page template and tiered interview are adapted from public free material by jleesubai-sys and Mariah Brunner. Packaged by Nuggts.

Install: see [INSTALL.md](../../INSTALL.md).
