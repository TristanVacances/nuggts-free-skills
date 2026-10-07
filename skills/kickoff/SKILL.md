---
name: kickoff
description: >-
  The one command to run first. Describe what you want to make in plain language,
  and this works out which of your installed skills the task needs, brings them in
  itself, drives the work to a finished result, and runs a separate review before
  you see it. Use at the start of anything: "let's build", "help me make", "I want
  to create", "new project", "where do I start", "kick off", or just /kickoff.
---

# Kickoff: brief your AI like a team

You probably have more skills installed than you remember. The failure mode isn't a
missing tool. It's diving in without picking the right ones. `/kickoff` forces that
routing pass, so the person describes an outcome and the right skills fire.

Run it at the start of any build or multi-step task.

## Do this, in order

**1. Know their world.** Look for context the person has already written down: a
`CLAUDE.md`, a context or about-me file, a project folder, a `memory/now.md` from last
time. Read what exists. If there's nothing and the task depends on who they are
(their business, audience, voice), ask **at most three** short questions first, and
offer to save the answers in a `CLAUDE.md` so you never ask again.

**2. Pin the goal.** One line: what is the deliverable, and what does a good version
look like? Lead with your best guess so they can confirm or correct. Don't re-interview.

**3. Route, then invoke.** The descriptions of every installed skill are already in your
context, and that's the menu. Name the skills this task needs **and why**, then **bring
them in yourself**. Never hand the person a list to pick from. When two could fit, pick
the more specific one. Say which skill you're using as you go; it teaches them how
their toolbox works.

If no installed skill fits a part of the job, say so plainly and do that part with
care. Don't pretend a skill exists.

**4. Do the work to a finished thing.** Before drafting, say what "good" looks like for
this piece. Then produce it.

**5. Review before they see it.** Run a separate, fresh-eyes check against that bar:
- If you can start a subagent, give it the draft and the bar and ask for concrete fixes.
- If not, re-read cold against a checklist: does it meet the stated goal, are all facts sourced or flagged, are there loose ends?

Apply the fixes **before** handing over. The person is not your first reviewer.

**6. Hold the bar.** Deliver the finished thing, not a plan to build it, unless they
asked for a plan. If a real blocker needs them (a decision only they can make, a file
only they have), name it plainly.

## Between sessions

For ongoing work, write the state to `memory/now.md` before finishing: what you're
building, decisions made, and the single next step. The next session then resumes
instead of starting cold. Create it only when there's something worth remembering.

## Keep it light

This is a 20-second routing pass, not a ceremony. For a genuinely trivial request (one
quick answer, a tiny tweak), just do it and skip the routing.

## The mental model to teach once

**Your skills are a team; `/kickoff` is how you brief it.** You describe what you want;
it picks the players, does the work, and checks it before handing it back. It's the
only command you need to remember.

---
*Free skill from [Nuggts](https://nuggts.fr). The light version of the front door
built into every Brain Pack, where it also runs a guided setup interview, expert
knowledge bases and a dedicated review engine: [nuggts.fr/packs](https://nuggts.fr/packs).*
