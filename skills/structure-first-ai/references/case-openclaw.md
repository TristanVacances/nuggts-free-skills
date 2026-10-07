# Cautionary case — "OpenClaw": right principles, wrong wrapper

*Moved verbatim from SKILL.md — "check N", "this lens" and "above" refer to SKILL.md.*

*Source: Sophiene IA (FR reel, YouTube MLpBwkioKUA). "OpenClaw" tool name UNVERIFIED (as transcribed;
likely mistranscription of a real agent runtime). Creator plugs a companion app ("SetupClaw") that
one-click-installs/configures it "even for non-tech" — that's promo, not a capability claim to trust.*

A textbook illustration of the lens: the creator hand-builds a **multi-agent hierarchy — 6 agents + 45
skills** — a main "router" agent that dispatches to specialist agents (CRM, DevOps, marketing, trading,
video), each with its own `SOL.md` identity file, each on a cost-tiered model (Opus for coding, cheaper
models for CRM updates).

**Borrow the principles — they're sound, and they're not his invention:**
- *Context-isolation per agent* — don't dump everything on one main session or the context window bloats
  and precision/data degrades. Route to a sub-context instead. (This is check 2 applied to *context*.)
- *Per-agent model-tiering* — Opus where judgment/coding lives, low-cost models for rote tasks.

**But that's exactly native Claude Code subagents + a `skills/` folder** — the creator even says it's
"comme dans Claude Code avec les agent Teams." So the red flag: **he re-implemented, by hand, a bespoke
multi-agent framework to get behaviour the platform already ships.** "6 agents + 45 skills installed since
the beginning" is the orchestration-first anti-pattern this lens warns against (check 1: over-engineering;
harness checklist: orchestration is layer 5, added *last and only if needed*) — a hand-rolled agent-swarm
rig standing in for subagents + structured folders that would do the same job for free, model-agnostic and
inspectable.

**Structure-first read:** keep the two principles, drop the framework. If you're on Claude Code (or
similar), you already have context-isolated subagents and a folder of skills — that IS the "hierarchy." A
separate multi-agent runtime + its one-click installer is a stack to maintain and a thing to migrate on the
next model release; the folder isn't. Don't adopt a bespoke multi-agent framework when subagents + folders
suffice.
