# When plain files are not enough

Two ideas that sit on top of the `brain/` + `memory/` setup. Both come from public tutorials that are vendor-adjacent: treat every product, benchmark and cost claim here as UNVERIFIED, and check any third-party tool (read what it does, check the licence, try it on a throwaway project) before installing.

## The memory ladder

Plain files are rung 1 of six. Most people never need to leave rungs 1 and 2. Climb only when a named, recurring failure forces it.

1. **Native files**: `CLAUDE.md` plus memory files, as in SKILL.md. Free, no setup. Keep `CLAUDE.md` lean and push long material into files the index points to.
2. **Auto-loaded memory (Claude Code hooks)**: a session-start step that injects the memory index so you rely less on Claude choosing to read it. Worth it if you have used Claude for about a month and keep repeating things it should know.
3. **Semantic search**: a plugin that searches your memory by meaning and injects the top matches. For when lookups miss answers you know are in your notes.
4. **Verbatim recall**: stores conversations word for word, so you recall exactly what was decided.
5. **Cross-tool knowledge base**: a graph across every tool you use (a DIY markdown wiki, or a hosted service where your data lives on their servers).
6. **Owned cross-tool brain**: same reach as 5, but you own the store (a database you host). The most complex rung and the one that adds monthly cost (price it first).

Every rung past 2 adds a second store and a sync surface. Fewer stores, fewer ways to desync. Native memory keeps improving, so do not over-invest in a heavy stack you may tear out.

## Self-improving skills

A skill can get better each time it runs, with two plain instructions inside its `SKILL.md`:

- **Save approved outputs as good examples.** When you approve a final output, save it in the skill's examples folder. The skill builds its own "what good looks like" set.
- **Turn corrections into rules.** When you say "never do X again", Claude proposes the exact line to add to the skill's rules section and adds it only after you approve.

Rule of thumb: followed the process but the output was wrong, add a good example. Broke the process, edit the rules. Keep `SKILL.md` itself short; accumulate examples in a folder. Same bar as memory: only genuinely reusable examples and rules earn a place, and prune now and then.
