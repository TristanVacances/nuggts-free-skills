# Structure-First AI

**Before you build an AI agent, read this.** A design lens that turns "let's build 6 agents with LangChain" into "a folder, three Markdown files, and one human who stays in charge", and explains why that version lasts longer.

**What it does:** you describe the AI thing you want to build. It runs the plan through 7 checks (do you even need an agent? can the structure be the architecture? who stays in the loop? what's the paid problem?) and hands back a leaner, model-proof version, plus the order to build it in.

**Before:** "I want a multi-agent system with a vector DB for my client onboarding."
**After:** "One folder per client, a CLAUDE.md with the onboarding steps, a checklist skill, and you approving each email. No framework, no database. Next year's model just reads the same folder."

**Credits:** methodology distilled from the public teaching of **Jake Van Clief** ([@lostandlucky](https://www.instagram.com/lostandlucky/), skool.com/cliefnotes). Also folded in: Mariah Brunner's harness-architect order, Cooper Simson's audit idea, Actionable AI's bottleneck lens, and Karpathy × Zhan's "MenuGen test". Full list in `references/sources.md`. Go follow them.

Install: see [INSTALL.md](../../INSTALL.md).
