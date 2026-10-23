# Nuggts free skills

Skills for Claude that I use every day, cleaned up and given away. Each one went through months of real use, breaking and fixing before landing here.

| Skill | What it does | Origin |
|---|---|---|
| [kickoff](skills/kickoff) | The only command to remember: picks the right skills, does the work, reviews it before you see it | Nuggts original |
| [boil-the-ocean](skills/boil-the-ocean) | Get the finished, tested, documented thing instead of a plan | Garry Tan's principle (gstack), extended by Nuggts |
| [structure-first-ai](skills/structure-first-ai) | Before you build an AI agent: the leaner, model-proof version | Distilled from Jake Van Clief + others (credited) |
| [ai-opportunity-audit](skills/ai-opportunity-audit) | Interviews you about your business, then ranks where AI pays off by hours saved per week | Method by Cooper Simson, extended by Nuggts |
| [agent-file-structure](skills/agent-file-structure) | Set up your folder, context file and memory once, so Claude stops starting from zero | Method by Cooper Simson (credited) |
| [brain-feeder](skills/brain-feeder) | Everything you save (reels, posts, videos) becomes skills and notes your AI actually uses | Nuggts original |
| [skill-integrator](skills/skill-integrator) | Found a new skill? Vet it, check what it overlaps with, and update only what needs changing | Nuggts original |
| [learn-anything-brain](skills/learn-anything-brain) | Learn any subject deeply: a folder of confidence-rated notes plus a study guide | Nuggts original |
| [session-closeout](skills/session-closeout) | A few minutes at the end of a session, so the next one doesn't start from zero | Ritual by le_gouverneur_ia + VibeFlow, packaged by Nuggts (credited) |
| [data-truth](skills/data-truth) | Every number you send out comes with its receipt, so a wrong figure is caught before a client does | Nuggts original |
| [pressure-test](skills/pressure-test) | Your idea attacked from several independent angles: a straight verdict and the better version | Nuggts original (premortem: Gary Klein) |
| [html-print-pdf](skills/html-print-pdf) | PDFs that fit their pages the first time: no cut-off text, no blank last page | Nuggts original |
| [visual-qc](skills/visual-qc) | A quality gate for AI images and frames that measures the pixels instead of saying "looks great" | Nuggts original |

## Does it work? Our own test, limits included

We ran the seven skills that can be tested in a chat against the same model without them (Claude Sonnet 5.5, same effort), on 84 fresh, independently written tasks (12 per skill, 28 of them with a hidden flaw), judged blind by a second model.

- With the skills: **71% of decided tasks won** against the plain model (95% range 58–82%), and **about 38% fewer missed checks** (24.8% of checks missed without the skills, 15.2% with).
- Against the same model thinking harder (high effort) the win rate is 60%, and the range (47–72%) includes a coin flip: we can't claim more than "at least as good as thinking harder".
- Strongest results: structure-first-ai and data-truth (data-truth won every decided task against the plain model at high effort, 8–0). Weakest: agent-file-structure, learn-anything-brain and pressure-test.
- Not tested (they can't be judged in a single chat answer): kickoff, brain-feeder, skill-integrator, session-closeout, html-print-pdf, visual-qc.
- Limits: the tasks and the judge are AI-made, single question and answer only, 12 tasks per skill, and the skills were adjusted after earlier rounds (we used fresh tasks to guard against tuning to the test). Details and every number: the benchmark notes are available on request.

**Install:** [INSTALL.md](INSTALL.md). Works in the Claude app (no terminal), Cowork and Claude Code. You need a Claude plan with code execution on. A paid plan (~€20/month) is recommended for real work.

**Regular updates:** watch or star the repo.

## Want the edge right now?
The **Nuggts Brain Packs** include all of these (the toolkit ships in every pack), plus:
- expert knowledge bases for your job (marketing, writing, creative studio, founder, local visibility…)
- a guided setup that learns your business
- a dedicated review engine

Regularly updated. One price, always yours. → [nuggts.fr/packs](https://nuggts.fr/packs)

## Credits and licence
Nuggts originals are under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/): use, adapt and share them, just credit "Nuggts (nuggts.fr)". Distilled skills credit their sources inside each folder. The methods belong to their authors, so go follow them.
