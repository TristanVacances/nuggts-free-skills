---
name: agent-file-structure
description: >-
  Sets up the folder, the context file (CLAUDE.md) and the memory files once, so
  Claude stops starting every chat from zero. Works in the Claude desktop app,
  Cowork with a project folder, and Claude Code. Use when the user says "every
  new chat starts from scratch", "I re-explain myself constantly", "my AI
  folders are a mess", "where does CLAUDE.md go", "where do my rules and
  context files go", "give Claude memory across sessions", "set up my agent
  file structure / brain folder", or is about to start a new AI project or agent
  and asks how to organize it. Also for one piece only: the memory layer, the
  per-project context file, or the .env secrets rule. Method by Cooper Simson
  (@cooper.simson). NOT for deciding whether to build an agent at all (that is
  structure-first-ai).
---

# Agent File Structure

Verdict: Claude forgets because nothing is written down where it will read it. Fix the files once, before you build anything, and every new chat starts with your rules, your context and what happened last time.

This skill interviews you, then creates the folder, the context file and the memory files. You do not need a terminal. Claude lists the files it plans to create (and any existing file it would change), waits for your yes, then creates them. It never overwrites an existing file without asking.

Method by **Cooper Simson** (@cooper.simson, "Actionable AI / Agents / AI Content"). Packaged by Nuggts.

## Where things go, in plain language

You need ONE folder on your computer that holds all your AI work. Call it `my-ai` (any name works). When you open that folder in Cowork or Claude Code, Claude can read and write the files in it.

- **`CLAUDE.md`** is a text file at the top of that folder. It holds your rules and preferences (how Claude should behave, your voice, your standards). Claude Code reads it automatically at the start of every session. Cowork: put it in the folder you give Claude access to and tell it once, in the folder's instructions, "Read CLAUDE.md first." (UNVERIFIED: whether your app version loads it automatically. The "read it first" line works either way.)
- **Memory files** are plain text files in a `memory/` folder. When you say "update now.md and add a session note", Claude writes what you did and decided, and it reads `now.md` at the start of the next session. There is no hidden database. You can open and edit them.
- **Claude.ai chat Projects (no folder access):** the same files exist, but you add them differently. Paste the contents of `CLAUDE.md` into the Project's instructions and upload the context files to the Project's knowledge. Memory then lives in a file you re-upload after a session (ask Claude to give you the updated `now.md` to save). UNVERIFIED: exact menu names vary by app version.

Any file Claude should know about gets written down. If it is not in a file, it will be forgotten.

## The structure

```
my-ai/                           # ONE home for all projects
├── CLAUDE.md                    # rules + preferences, read every session
├── brain/
│   ├── rules.md                 # guardrails + keeps projects from bleeding together
│   ├── index.md                 # the map: every project, where it is, its status
│   ├── tools.md                 # every connected app / API and what uses it
│   ├── context/                 # business.md, offer.md, customers.md, voice.md, goals.md
│   └── memory/
│       ├── now.md               # short-term: what is active RIGHT NOW (overwrite each session)
│       └── sessions/            # longer-term notes per session or topic
├── projects/
│   ├── project-a/context.md     # this project's current state
│   └── project-b/context.md
├── skills/                      # reusable capabilities (optional)
├── workflows/                   # multi-step sequences (optional)
├── scripts/                     # code for repeat tasks (optional, advanced)
├── .env                         # secrets: keys, passwords, ONE place
└── .gitignore                   # lists .env so nothing leaks (only if you use git)
```

### What each piece is for

- **`CLAUDE.md`**: the single source for behavior. Keep it lean (rule of thumb under ~200 lines, UNVERIFIED). Push long material into files that `index.md` points to.
- **`rules.md`**: separation rules (one project's context must not leak into another) plus guardrails. The generated `CLAUDE.md` always carries: "No external actions and no spending without explicit approval." Add "never do X without me" lines for money, customers and publishing. Can live inside `CLAUDE.md` if small.
- **`index.md`**: the map. Lets Claude, and you, answer "where is everything?" in one read.
- **`tools.md`**: every connected app or API, what uses it, and whether it is logged in. Otherwise this is invisible knowledge in your head.
- **`context/`**: business, offer, customers, voice, goals. Any project then starts already knowing who you are and who you serve. Do not create five empty files. A file earns its place by having something true in it.
- **`memory/`**: `now.md` is short-term state. `sessions/` is the durable log. Append and promote. It is not a dumping ground.
- **per-project `context.md`**: that project's state. Pick ONE filename (`context.md` or `HANDOFF.md`) and use it everywhere, so projects are interchangeable to Claude.
- **per-project `glossary.md`** (optional): the project's own stable vocabulary (its entities and coined terms). Saves re-explaining words each session. Add a term only when it is really in use. Do not name it `CONTEXT.md`: it collides with `context.md` on case-insensitive systems (Mac and Windows defaults).
- **`skills/`, `workflows/`, `scripts/`**: three separate folders. Skills are capabilities, workflows are sequences, scripts are deterministic repeat tasks (running a script beats re-reasoning the same task and saves tokens). Skip all three at the start if you have none yet.

## Secrets rule (hard)

- All keys, tokens and passwords live in ONE file: `.env`. Never paste a key into `CLAUDE.md`, a context file, a memory file or a chat. Files in this tree get read back into every session and may be shared or synced.
- If you use git or GitHub, `.env` is the first line of `.gitignore`, added BEFORE the first push, not after a leak.
- No `.env` yet? Create it empty and put placeholders in context files ("the Stripe key is in .env as STRIPE_KEY"). If a key was ever pasted into a file or chat, treat it as leaked and rotate it.
- Mac Finder refuses folder names starting with a dot. Ask Claude to create `.env` and `.gitignore` for you.

## How to apply it

1. **Search before scaffolding.** Look at what already exists (a `CLAUDE.md`, notes, per-project docs). Map them onto this structure and fill only genuine gaps, commonly `index.md` and `tools.md`. If auditing an existing folder, use the short list below.
2. **Interview first, not from a template.** One question at a time, mirroring back after any significant answer. Tiers, each ending in a checkpoint ("continue / add optional files / build now"):
   - **T0**: the agent's name and working style
   - **T1**: who you are, your goals, the agent's ONE primary job
   - **T2**: work context, quality standards, boundaries
   - **T3**: optional files, only if you want them
   Say "Remembered:" inline whenever a fact is written to a file. Every file produced must trace to an answer you actually gave.
3. **Check the five layers** around the model: **Memory** (`brain/`, `memory/`) · **Tools** (`tools.md`) · **Skills** (documented procedures, including the judgment calls) · **Guardrails** (the "never without me" lines) · **Orchestration** (`workflows/`, run on a cadence, reporting back). Max-3 minimalism: a harness with 3 parts you use beats one with 12 you don't. Cap the first build at about 3 skills or connectors.
4. **One main folder, then the brain.** Home folder and `brain/` first.
5. **One folder per project, one context file each**, same filename everywhere.
6. **Secrets into `.env`, ignored, then push.** Never the other way round.
7. **Promote, don't pre-build.** An empty scaffold is noise.
8. **Start each new chat with one line**: "Read CLAUDE.md, brain/index.md and brain/memory/now.md, then we continue." End each session with: "Update now.md and add a session note."

## Quick audit (existing folder)

Pass or gap, each line: one main folder · `CLAUDE.md` at the top · rules file · index · tools list · context files with real content · `memory/` with `now.md` · one folder per project with one standard context file · `.env` for secrets · `.gitignore` listing `.env` (if using git) · backups or versioning. Optional: skills, workflows, scripts folders; Obsidian or Notion as a reading view only. See `references/audit-checklist.md` for the full 20 points.

## Version control and sync

- If you use it, **git is the source of truth**: the tree is plain text, versionable, and GitHub gives history and backup. Not using git? A synced folder or regular backup does the same job. Pick one place that is the truth.
- Obsidian or Notion are optional viewers. Do not route short-term memory (`now.md`) into a second cloud store unless a real need forces it. Fewer sync targets, fewer ways to desync.

## Model routing

Use a capable model to plan and make hard calls, and a faster, cheaper one for mechanical execution. A habit you apply while working, not a file you maintain.

## The job page: one subagent file per job (Claude Code)

Skip this if you only use the desktop app. In Claude Code, one file in `.claude/agents/` is the brief you would give a sharp new hire, written once.

- **Frontmatter:** `name` (lowercase-hyphen) · `description` opening "Use when <the moment the job starts> ... then stops at <where the human takes over>" · `tools` = the least it needs (omit the line and it inherits every tool) · `model: inherit` · optional `memory: user | project | local` for cross-session recall (auto-creates `.claude/agent-memory/`, read on start and written as it works). Same `.gitignore` discipline if it holds anything sensitive.
- **Read first:** named files, pointed at, never pasted in. Step 1: "check each exists; if one is missing, stop and say which."
- **Steps:** one action each; the last is "save to `<output>`. Stop."
- **Tools and files:** `Reads:` and `Leaves:` (the file the next page picks up).
- **Done looks like:** checks the agent runs and shows: a file exists, a search returns zero hits, two totals match. "Looks good" is not a check. Anything that leaves the business gets read by a human first.
- **Never:** start with three; add one line each time something goes wrong. Last line: "Never mark this final."

Four rules: one job per page (an "and" in the name means split it) · point, don't paste · make "done" checkable · say what it leaves. Pages never talk to each other; each leaves a file and the next picks it up. A reviewer page gets no Write/Edit tools and says "findings only", so the judge cannot quietly fix what it judges. When an output is wrong, fix the page, not the chat. Start with one weekly job: 3 to 5 steps and 3 Never lines.

Source-asserted gotchas, UNVERIFIED (check current docs): the `---` must be the very first line or the page is ignored; a `.claude/agents/` folder created mid-session may need a restart.

## When plain files stop being enough

If memory keeps missing things you know are in your notes, read `references/memory-scaling.md` first. Most people never need to leave the plain-files setup.

## Related

- **structure-first-ai**: run it first to decide whether to build an agent at all. This skill is what you build once you have decided to.
- **kickoff**: routes a new task to the right skills once your structure exists.

---
Credits: scaffold by Cooper Simson (@cooper.simson). Audit list adapted from Dryxio (@dryxio). Job-page template adapted from the free "pipeline pack" gist by jleesubai-sys. Tiered interview adapted from Mariah Brunner's first-agent-builder file. Project glossary idea from Matt Pocock's public skills repo.

---
*Free skill from [Nuggts](https://nuggts.fr). Method by Cooper Simson (@cooper.simson); packaged, tested and kept up to date by Nuggts through months of real daily use. Want the whole toolbox? See the Brain Packs at [nuggts.fr/packs](https://nuggts.fr/packs).*
