# From lens to build: the harness-architect checklist

*Moved verbatim from SKILL.md — "check N" and "above" refer to the seven checks in SKILL.md. Source: Mariah Brunner's "AI Harness Architect" skill (`@learnaiwithmariah`); any income framing around the source guide is UNVERIFIED.*


Once the lens says *build it*, this is the order of assembly — a five-layer
harness, built **interview-first** and **minimal, not generic**. Same doctrine as
the checks above, turned into a concrete build sequence.

**Interview-first.** Before architecting anything, interview the person about the
real workflow: the actual steps, the inputs, where judgment enters, what "done"
looks like. You are transcribing an existing manual process (check 4), not
inventing one — no layer gets built from a guess.

**Minimal, not generic.** Build the specific harness the interview revealed, not a
general-purpose framework that "could do anything." Generic is over-engineering
(check 1); every element earns its place by serving a named step. Add a layer only
when a real step needs it.

Build the five layers **in order** — each rests on the one before:

1. **Memory** — the structured files first: what the system knows and persists
   (`CLAUDE.md` rules, `USER.md` context, `MEMORY.md` facts, the folder tree).
   This is the structure-as-architecture substrate from check 2; every other layer
   reads from it.
2. **Tools** — the deterministic actions it can take (scripts, API calls, file
   ops). Prefer plain scripts over framework plumbing. Only the tools the steps
   actually call.
3. **Skills** — the instructions/procedures that compose memory + tools into a
   task (the `SKILL.md` pattern: how to do the job, loaded on demand).
4. **Guardrails** — the limits: what it must not do, approval gates, the
   human-in-the-loop checkpoint (check 3 — augment, don't automate away). Money,
   sending, and destructive ops stay gated.
5. **Orchestration** — wiring steps together, added **last and only if needed**. A
   single model walking the structure (check 2) beats an orchestration graph until
   it provably can't express the workflow.

The ordering *is* the point: most failed builds start at layer 5 (orchestration /
agent swarms) with no memory structure underneath. Structure-first inverts it —
memory and guardrails are load-bearing; orchestration is the last, smallest piece.
