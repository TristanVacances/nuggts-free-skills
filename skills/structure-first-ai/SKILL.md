---
name: structure-first-ai
description: >-
  Design lens before building anything with AI — agent vs automation vs
  RAG/vector DB vs "second brain" vs internal tool. Pushes back on frameworks
  (LangChain, CrewAI, n8n, Pinecone); favors folders/YAML/Markdown,
  human-augmented, anchored to a paid problem. Use when scoping or
  second-guessing an AI build. NOT for reviewing existing code.
---

# Structure-First AI

A design lens for building with AI. It is **flexible** — a way of thinking, not a
rigid checklist. Apply it whenever someone is about to build an AI agent,
automation, knowledge base, tool, or product, and reframe their plan through it
before any code or framework is chosen.

## The one belief

**Stop building agents. Structure your data so the intelligence lives in the
structure, and augment a human instead of replacing them.**

Almost every principle below is a corollary of that sentence.

## When to reach for this

Trigger it when you hear, in any phrasing:

- "Should I build an agent / multi-agent system for this?"
- "Let's automate this whole workflow with AI."
- "I want to build a second brain / knowledge base the AI can use."
- "What framework should I use — LangChain, an agent SDK, a vector DB, RAG?"
- "Design the architecture for this AI feature / product."
- Someone reaching for orchestration (agent swarms, n8n chains, RAG stacks)
  before they've pinned down the problem or the data structure.

If the task is genuinely just "answer this question" or "write this function,"
you don't need the lens. Reach for it when there's a *build* being designed.

## How to apply it

**Front door — when the user doesn't yet know *where* AI pays off, find that first**
(the #1 adoption failure is building the wrong thing or biting off too much). List
their recurring workflows, **rank them by hours saved per week**, and keep only the
ones that pass two gates: AI can genuinely do it today, AND it drives results for
this business. Sequence: **find the opportunity → this lens → the harness-architect
order** below.

Run the proposed build through the seven checks below **in order**. Don't lecture
— read the person's plan, then hand back a short reframing that names which
checks it passes and which it fails, and what the structure-first version looks
like. The checks are questions, not commandments; each carries the reasoning so
you can adapt it, not parrot it.

### 1. Do you even need an agent here? (Anti-over-engineering)

Most AI builds are over-engineered. The reflex to "build 100 agents to solve
marketing and finance" is usually the wrong move. Before anything, ask what
problem is actually being solved and whether it needs AI at all — sometimes the
right answer is traditional code or a plain ML model, not an LLM. Strip the idea
to its simplest form that works. If a single well-prompted model reading the
right files does the job, that beats an orchestration diagram.

*Why:* complexity is a liability that the model providers will make free next
year. A lone automation you built is a "feature," and features get absorbed.

**Corollary — run the raw-model baseline first (the MenuGen test).** Before
building an app or pipeline around a model, run the whole task as ONE call to a
frontier multimodal model: input + prompt → output, no app. Karpathy vibe-coded
MenuGen (menu photo → OCR → image-gen per dish → re-rendered menu, deployed on
Vercel), then saw a single Gemini image-in/image-out call do it: "that app
shouldn't exist." If the raw call gets most of the way, ship a prompt or skill
instead (or nothing). If you're SELLING the app, the raw call is your competitor:
sell the outcome, data or judgment around it (check 5), never the plumbing.
Write the baseline result down before you build anything. (Source: Karpathy × Zhan,
Sequoia AI Ascent, youtube.com/watch?v=96jN2OCOfLs, ~05:00.)

### 2. Can the structure be the architecture? (The core move)

Instead of routing data and tools *to* an agent through
a framework, **structure the data so one model becomes as many agents as needed
by navigating that structure.** The context, the prompts, and the tool
references live *inside* a folder tree of Markdown + YAML front-matter, not in an
orchestration layer.

Prefer, in order:
- **Folders + files + Markdown + YAML front-matter** as the routing and memory
  substrate. It's free, model-agnostic, inspectable, and version-controllable.
- A vector DB / RAG / graph store **only** when you can articulate why plain
  structured files won't serve — e.g. genuine fuzzy semantic retrieval over a
  corpus too large to navigate by path.
- An agent framework / multi-agent orchestration **only** when a single
  structure-navigating model provably can't express the workflow.

*Why:* "Agents are the wrong abstraction layer." If the data is structured well,
the model becomes the agent *as it walks the structure* — you get to focus on the
data design instead of babysitting an orchestration graph, and you can swap model
providers freely. (Exactly how Anthropic **Skills** work.)

**Corollary — the substrate is not always a folder tree.** "Structure is the
architecture" abstracts beyond files/YAML: the deterministic structure that carries
the logic can equally be a typed domain core behind clear interfaces (e.g. a native
app rewrite), with the LLM as a swappable, deletable thin layer. The move is
the same — a deterministic core owns the logic, the model stays non-load-bearing —
even for framework-heavy platform builds where nothing is a folder tree. Don't dismiss
the lens because the output isn't Markdown.

**Corollary — make it model-proof.** The durability test for any AI system: does
next year's model release break it, or inherit it? Build **folder-based, not
project-based**. A folder isn't tied to one tool or model — when a better model
ships, you point it at the same folder and migrate nothing. Couple your system to
one model's quirks (its exact prompt phrasing, its tool-call format, its context
tricks) and every release is a rebuild. Structure it as plain files and the model
is a swappable engine.

For a concrete model-proof folder layout (`CLAUDE.md` / `USER.md` / `MEMORY.md`,
numbered folders, wikilinks as the index), read `references/model-proof-folder.md`.

**Corollary — locate the layer before choosing a stack.** **L1 chat and paste**
(hand-iterated, inconsistent; fine for one-offs) → **L2 refined prompts packaged as
skills** (optionally with deterministic scripts) → **L3 navigable structure**
(skills/markdown/scripts in folders; one agent pulls only the context it needs, e.g.
a `voice-and-tone.md` referenced from CLAUDE.md; cost and latency drop). "Automating
the wrong layer" = reaching for a framework at L1, or treating L3 as orchestration;
usually the fix is folders plus a CLAUDE.md pointer. **Mine the dialogue for the
structure:** pull the goals, constraints and decisions out of a good back-and-forth
into markdown instead of designing a methodology from nothing — that's L1 → L2.

### 3. Is a human being augmented, or automated away?

The goal of technology — from Engelbart's mouse onward — is to **augment** human
intellect, not remove the human. Automation is a
*prerequisite*, not the goal. A design that takes the human entirely out of the
loop is usually a brittle, capped tool.

Flip the frame: an automation *given to a person* becomes augmentation. If you'd
automate a 2,000-person company, the bigger idea is to hand that automation to one
person so they can run a 2,000-person-equivalent company. Keep the human in the
compute layer where judgment lives.

*Why:* augmented humans compound; fully-automated pipelines plateau and break at
the edges no one is watching.

### 4. What's the real, paid problem — and the explicit steps?

You rarely need AI. You need **a problem people will pay to solve, plus a
repeatable, step-by-step way you solve it.** That is every business. Name the
job-to-be-done (why does the user "hire" this?), then write the literal steps a
human would take. AI slots into those steps; it isn't the point of them.

**Aim at the ONE bottleneck, not the whole pipeline.** When someone is stuck or
wants to "automate the whole workflow," backward-chain:
lock a stranger-verifiable outcome ("ten paying customers by the 30th", not "grow
the business") → work backward to what's already true → chunk into done-testable
pieces → the first link not yet true is the bottleneck (usually not what they
assumed) → give the next action PLUS an explicit ignore-list. That's where AI (or
plain structure) gets aimed — check 1 applied to *goals*.

*Why:* if there's no paid problem and no manual process you could do without AI,
you're building a demo, not a product.

### 5. Are you composing features into an outcome?

A single automation is a feature. Durable value comes from **composing multiple
features into a novel outcome or environment** that didn't exist before. Sell the
outcome and the structured environment — "software *in* a service" — not a thin
wrapper "software *as* a service" that the base models will subsume.

*Why:* individual capabilities trend toward free and commoditized; a novel
composition and your niche structured data are the moat.

### 6. Are the fundamentals handled before the AI cleverness?

Systems thinking, high- and low-level design, Unix philosophy (small pieces,
composed; text streams; do one thing well), DevOps hygiene. These hold whether or
not AI exists, and they're what make a structure-first build actually work. If the
underlying data model or process is muddy, no amount of agents will save it.

*Why:* the fundamentals are the fundamentals. Structure-first *is* a fundamentals
play — it only pays off if the structure is sound.

### 7. Does it ship, and iterate?

Bias hard toward action. Ideas are worthless without implementation; you learn by
building, failing, and iterating, not by deliberating or asking the model whether
your idea is good. Get a rough version running against real use, then improve it.

*Why:* an idea is only "good" once you've taken action on it. Failure-based
learning is the fastest path, and structured builds are cheap to iterate because
the logic lives in editable files, not tangled code.

## From lens to build: the harness-architect order

Once the lens says *build it*, assemble a five-layer harness **interview-first**
(transcribe the real manual process — steps, inputs, where judgment enters, what
"done" looks like; no layer built from a guess) and **minimal, not generic** (every
element serves a named step), strictly in order: **Memory → Tools → Skills →
Guardrails → Orchestration**. Guardrails keep money, sending and destructive ops
gated (check 3). Orchestration comes **last and only if needed** — most failed
builds start there with no memory structure underneath. On Claude Code, native
subagents (context isolation + per-agent model tiering) plus a `skills/` folder
already ARE the agent hierarchy — don't adopt a bespoke multi-agent framework when
subagents + folders suffice. For the layer-by-layer build order, read
`references/harness-build-order.md`; if someone proposes a hand-rolled router-agent
+ specialist-agents rig, read `references/case-openclaw.md`.

## Output shape

After running the checks, give back something like:

> **Structure-first read on your plan**
> - **Do you need an agent?** — [pass/fail + one line]
> - **Structure as architecture** — [what to use instead of the framework/RAG]
> - **Augment vs automate** — [where the human stays in the loop]
> - **Real paid problem + steps** — [the job-to-be-done, the manual steps]
> - **Composing to an outcome** — [feature vs outcome]
> - **Fundamentals** — [what to nail first]
> - **Ship & iterate** — [the smallest thing to get running]
>
> **The structure-first version:** [2–4 sentences describing the leaner,
> folder/structure-based build, and what you'd deliberately NOT build.]

Keep it concrete and tied to their actual project. The deliverable is a sharper,
leaner design — not a philosophy lecture.

## Voice (optional)

Jake's register is direct, anti-hype, myth-busting — borrow the tone if it helps.
The substance (a design critique that makes the build simpler and more durable) is
the point; the persona is seasoning, not the meal.

## Attribution

Methodology distilled from 50 public Instagram reels by **Jake Van Clief**
(`@lostandlucky` / `skool.com/cliefnotes`), MSc AI & governance, University of
Edinburgh. The framing here is a synthesis of his public teaching, not a quote of it —
go follow him for the real thing.

Other sources (Mariah Brunner, Cooper Simson, Actionable AI, Karpathy × Zhan, YouTube
956DPSPX4wg, Sophiene IA) with their UNVERIFIED/INFERENCE flags and a do-not-install
note: `references/sources.md`.

---
*Free skill from [Nuggts](https://nuggts.fr) — distilled, tested and kept up to date
through months of real daily use. Want the whole toolbox? See the Brain Packs at [nuggts.fr/packs](https://nuggts.fr/packs).*
