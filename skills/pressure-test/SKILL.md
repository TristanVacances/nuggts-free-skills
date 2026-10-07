---
name: pressure-test
description: >-
  Pressure-test a business idea, side project, startup or plan to a verdict: is it
  actually good, and if not, is there a version that is? Frames the real risk, gathers
  the evidence it can actually check, attacks the idea from several independent lenses
  (customer, skeptic, economist, contrarian, plus optional historian and operator),
  then gives a verdict-first call (go / skip / needs homework), a rescue or pivot
  path, and a short premortem. Output is a plain report in chat. Use whenever someone
  says "pressure test this idea", "is this a good business idea", "roast my idea",
  "gut-check my idea", "tear this apart", "should I build X", "stress-test my plan",
  "will this make money", or "vet this venture". Not for a plan you've already
  committed to (run a premortem instead) or a single quick strategy question.
---

# Pressure-Test

Turn "is this idea any good?" into a call you can act on. The output is never a
neutral description. It is a **verdict** (go / skip / needs homework), the honest
reasons, and a concrete next step. When the idea as pitched is weak, it also looks
for the version that isn't.

## The principle: never grade your own homework

A lot of idea feedback is cheerleading or vibes, and the person giving it usually agrees
with themselves. This skill forces separation: each lens writes its attack **before**
seeing what the other lenses concluded, and the synthesis is written last, against
all of them. Agreement between lenses that couldn't see each other is a real signal.
Agreement between lenses that could is just an echo.

A frequent way this goes wrong is **grading the pitch as stated and stopping
there.** Always do both: judge the idea as pitched, then test whether a stronger
business is hiding inside it.

## Step 0: Frame the real problem

Read the pitch. If it's vague, ask up to **three** short questions first (who is it
for, how does it make money, what has the person already tried or decided). Don't
analyse a straw man.

Then name the **binding risk** in one line. Is this mainly a:
- **demand** problem (does anyone want it enough to pay?)
- **distribution** problem (can you reach buyers at a cost that works?)
- **money** problem (do the unit economics ever add up?)
- **moat** problem (what stops a bigger player copying it?)
- **founder-fit** problem (does this person have the skills, time and appetite?)

State it as a hypothesis you'll test. This stops you writing a beautiful analysis of
the wrong thing. Also note any **hard constraints** the person gave (budget, hours
per week, deadline, things they won't do). Those are gates, not weights: an option
that breaks one is out, even if it's "better".

## Step 1: Gather evidence you can actually check

What you can do here depends on the user's setup. Say which applies.

- **Web search available:** look for who already does this (search the underlying
  mechanic, not just the pitch's own wording, and across neighbouring customer types
  and price points), real price points, precedent companies that won or died and why,
  and any statistic the pitch relies on.
- **No web search (plain chat with it off):** say so. Work from what the person tells
  you and from general knowledge, and label every figure **UNVERIFIED**. List the
  three facts that would most change the verdict, so they can check them.

Tag every figure:
- **FACT**: sourced (give the link or name the source).
- **CALC**: computed from sourced or user-given inputs (show the sum).
- **UNVERIFIED**: couldn't source it. Never present it as fact.

Never invent a number, a competitor or a source to fill a gap. "I couldn't find this"
is a valid finding.

**"Nobody does this" is a weak claim.** It's only as strong as the search that failed
to find a competitor. Before saying there's white space, say which axis is empty: the
product itself, the positioning, or the use occasion. They mean very different things.

Compute the **make-or-break math** in plain numbers the person can check: "to earn X
per month at price Y you need Z paying customers; at a conversion rate of C (state it, label it an assumption) you'd
need roughly N visitors". Mark which inputs are assumptions.

## Step 2: The adversarial lenses (separate passes)

This is the pressure. Pick lenses to match the stakes:
- **Quick gut-check:** customer, skeptic, economist.
- **"Tear it apart properly":** add contrarian, and optionally historian and operator.

Ready-to-use briefs for each lens are in `references/lenses.md`.

**How to keep the passes separate:**
1. **If your setup can start subagents** (for example Claude Code), you may run each
   lens as its own subagent with only the pitch and the evidence from Step 1. That is
   the cleanest separation. This is optional.
2. **In the plain Claude app**, run the lenses as clearly separated passes in one
   reply. Write each lens under its own heading, finish it with its one-line verdict,
   and do **not** go back and edit an earlier lens after writing a later one. Each
   lens works only from the pitch and the evidence, never from another lens's
   conclusions.
3. **For real independence in the plain app,** offer this: the person can paste a
   lens brief into a fresh chat and paste the answer back. Be honest that passes
   inside one conversation are separated by discipline, not by a wall.

The **contrarian runs last** and is the one exception: it is deliberately given the
emerging consensus so it can attack it. If the panel is converging on "skip", its job
is to find the business worth building. If the panel loves the idea, its job is to
find the reason it dies.

## Step 3: Verdict-first synthesis

Lead with the call. Reasoning after.

Two separate verdicts:
1. **The idea as pitched:** go / skip / needs homework, with the reasons ranked by
   how much they matter.
2. **The best surviving version:** is there a pivot or narrower version that clears
   the main objections? If yes, name it in one line. If no, say so.

Rules for the synthesis:
- Keep the Step 1 tags (FACT / CALC / UNVERIFIED) on every figure, and mark each conclusion as either an inference from that evidence or an assumption.
- **Convergence** across lenses = strong signal; say which lenses agreed, and say how the passes were run: separate chats or subagents count for more than passes written inside one reply, which shared a context.
  **Divergence** = flag it honestly, don't average it away.
- **A flag is not a price.** If the verdict depends on an unknown yes/no ("if the
  supplier agrees", "if the platform allows it"), don't leave it as a footnote next to
  a confident score. Say plainly that the verdict holds only if that condition clears,
  and give a rough range rather than a single number for anything uncertain.
- Hard constraints from Step 0 are gates. Apply them.

## Step 4: The rescue path

If any version survives, spell it out:
- the changed model, and why it clears each main objection;
- a first go-to-market move that fixes the person's **actual** blocker (the risk you
  named in Step 0), not a generic plan;
- the **cheapest test** that would prove or kill it fast, with what result counts as
  a pass.

Often the most useful thing is reframing the blocker. "I can't crack marketing" may
really be "this channel's economics beat any marketer, so change the channel". If
nothing survives, say that plainly and name what would have to change.

## Step 5: Premortem

Imagine it's a year from now and the recommended path (as pitched or the pivot)
failed. List 5 to 8 reasons why, each with a guard. Include the uncomfortable one,
usually motivation, time or runway, framed as a risk, never as an insult.
(The premortem method is Gary Klein's.)

## Step 6: Deliver

Default output is a **plain report in chat**, in this order:

1. **Verdict** (2 lines: the call on the idea as pitched, and the best surviving version)
2. **Binding risk** (from Step 0, and whether it held up)
3. **The evidence** (with FACT / CALC / UNVERIFIED tags and sources)
4. **Make-or-break math**
5. **What each lens said** (one short paragraph and verdict per lens)
6. **Why**: ranked reasons
7. **Rescue path** and the cheapest test
8. **Premortem**
9. **What would change the verdict** (the 2 or 3 facts to check next)

If the person wants it saved as a file and you have folder access (Cowork, Claude
Code), tell them the file name and location first and wait for a yes. Never overwrite
an existing file without asking. In the plain app, offer the report as a document they
can download or copy.

This skill only analyses. It doesn't contact anyone, post, buy, sign up for anything
or spend money. Any outreach it suggests is a draft for the person to send themselves.

## Before you hand it over

- Recompute the make-or-break math. Don't trust a figure from earlier in the chat.
- Every load-bearing claim has a source or an UNVERIFIED label.
- The verdict is in the first two lines.
- No promise of results. This is a structured opinion, not a forecast.

## Tone

Direct, verdict-first, no filler. Warm when it's someone's own idea: you're on their
side, which is exactly why you tell them the truth. Never condescend. A weak idea
killed cleanly, with a better one in its place, is a gift.

---
*Free skill from [Nuggts](https://nuggts.fr). Want the whole toolbox? See the Nuggts Brain Packs on [nuggts.fr/packs](https://nuggts.fr/packs).*
