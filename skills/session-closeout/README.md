# Session Close-out

**Five minutes at the end of a session, so the next one doesn't start from zero.** A short ritual that keeps only what's worth keeping.

**What it does:** say "close out" or "wrap up" and Claude:
1. asks three questions in one message: what did you decide, what did you learn, what bit you
2. suggests answers from the session, so you just confirm or fix them
3. keeps an answer only if it passes a simple test (a decision has to rule something out; a learning has to change how you work)
4. adds the kept ones to three logs that are never edited or pruned
5. rewrites a 10-line `now.md`: where things stand and the next step

The first time, it offers to create the small `memory/` folder. It shows every line before writing and waits for your yes. Git versioning is optional and only with your yes. In the plain Claude app it gives you the notes to save yourself.

**Before:** you close the laptop with the important choice still in the chat. Next week you open a new chat and explain the whole project again.
**After:** next session starts with "read now.md", and Claude knows where you are, what you decided and what to avoid.

**Credits:** questions, tests and three-log ritual adapted from le_gouverneur_ia ("Rituel close-out de session : 3 champs") and the "Capitalise" principle of the VibeFlow philosophy. Folder layout, yes-gates and plain-app fallback by Nuggts.

Install: see [INSTALL.md](../../INSTALL.md).
