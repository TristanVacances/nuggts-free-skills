---
name: data-truth
description: >-
  A gate to run before any measured number (money, %, multiple, count) goes into
  a client deliverable, a report, a pitch, a case study, a post or an
  opportunity-sizing. It checks that the figure comes from the system of record
  (not a proxy), that every sub-surface was summed, that two systems agree (a gap
  over about 2x means stop and investigate), that the attribution model and window
  are named, and that every number carries a provenance tag. Use when the user says
  "pull the numbers", "what's our ROAS", "how much did email make", "size the
  opportunity", "check these figures", "is this number right", "before I send this
  report", "fact-check my stats", or /data-truth. Also run it quietly whenever you
  are about to write a measured figure into something another person will read.
---

# Data Truth: no number ships without its receipt

A wrong number rarely looks wrong. It is a real figure, pulled from a real tool,
that answers a slightly different question than the one you asked. This skill is
the gate that catches that before someone else does.

## The failure it prevents (a real mistake, simplified: figures and client removed)

Someone asks "how much revenue did email bring in last year?". The answer gets
reported three times, three different ways:

1. **From the online store's dashboard** ("orders whose last click came from email").
   *Wrong source.* The store only sees the last click before purchase, so it is
   nearly blind to email's real influence. The figure is tiny.
2. **From the email platform, automated flows only.** *Right source, incomplete
   scope.* One-off campaigns were forgotten. The figure is real but partial.
3. **From the email platform, flows + campaigns.** Complete. Several times bigger.

The underlying data never changed. Only the coverage of the source did. A partial
number that looks like a total is the most dangerous error here, because it passes
the "is this real?" check while still being wrong. This gate is built to get it
right on the first pass, not the third.

**Stance:** over-checking costs minutes; a wrong number in front of a client or
the public costs trust. Treat every outbound figure as load-bearing.

## When to run

Before any **measured** number (money, %, multiple, count) is written into
something another person will read: proposal, audit, report, invoice backup,
pitch deck, case study, social post, opportunity-sizing. "It's just a quick
number" is not an exception.

Not needed for: clearly labelled estimates you invented as an example, or
internal back-of-envelope maths the user explicitly calls rough.

## What you can and cannot check (be honest about this)

- **Plain Claude app, no connectors:** you cannot log into anyone's tools. You
  work from what the user pastes or uploads: CSV exports, screenshots, report
  PDFs. With code execution on, you can add up exports, compare two files and
  spot gaps. Figures read off a screenshot are transcribed by eye: tag them
  "from screenshot" and ask for a CSV export when the number matters.
  Say plainly which systems you actually saw and which you did not.
  Anything you did not see is **UNVERIFIED**, never inferred.
- **With connectors** (e.g. a store, ad platform or analytics connector in the
  app, Cowork or Claude Code): you can pull directly. Read-only. Confirm the
  account first (rule 0 below).
- **Never** claim a measurement you did not make. If the user asks for "the real
  number" and you only have one partial export, deliver the partial number with
  its tag saying exactly that, plus what to export next.

## The rules (the gate)

### 0. Right account first
Many businesses have several stores, ad accounts or analytics properties, and
connectors can point at the wrong one. Before pulling, confirm the account
name/ID with the user or read it back from the tool. Wrong account = every later
check is meaningless.

### 1. System of record, never a proxy
Each metric has one authoritative source: the system that **creates the event**.
Anything downstream that re-attributes that event through its own lens is a proxy.
- Email/SMS results: the email platform, not the store's last-click report.
- Ad spend and return: the ad platform (plus a blended cross-check, see rule 3).
- Total sales: the store or the accounting system.
- Search traffic: the search engine's own console for the site, not a
  third-party traffic estimator.
- Speed/performance scores from a lab test are a simulation, not what real
  visitors experience. Label them "lab", and look for real-user (field) data
  before calling something a problem.

If you are reading a metric from anywhere but its system of record, stop and say
so. The lookup table is in `references/sources-of-record.md`.

### 2. List every sub-surface before you sum
A metric is a sum over surfaces. Write the list **before** pulling, then pull
each one.
- "Email revenue" = automated flows + campaigns (+ SMS if in scope).
- "Ad performance" = every campaign and objective, including the zero-return
  awareness ones (that is where waste hides).
- "Total sales" = the full window, every store/channel in scope, gross or net stated.

A number whose surfaces are not listed does not ship.

### 3. Two systems, and the 2x rule
Where possible, get the same metric from two angles and compare. A gap bigger
than **about 2x** is a mandatory stop: do not pick one and move on. It usually
means wrong source, wrong attribution model, or missing surfaces. Find
which, and write the reason down. Some gaps are expected (last-click vs the
email platform's own view will differ a lot); say why it is expected rather
than ignoring it. In the plain app this needs the user to provide both exports;
if they only have one, the tag says "not cross-checked".

### 4. Name the attribution model and window
There is no single true number for a channel. Last-click, last-touch,
data-driven and platform self-reported models legitimately differ, and ad
platforms tend to give themselves credit generously. Honesty is not one magic
figure; it is the figure with its model and window named.

### 5. Provenance tag on every number
Every outbound figure gets a tag, kept in working notes or a footnote:

> **value · metric · source · scope (surfaces summed) · window (exact dates) · attribution model · FACT | ASSUMPTION | UNVERIFIED**

Example (placeholder values):
> **[amount] · email-attributed revenue · source: email platform · scope: flows + campaigns · window: [start date] to [end date] · model: platform last-touch, [x]-day click window · FACT**

Base measurements are FACT. Projections, uplifts and "if we fix this you could
gain..." are ASSUMPTION and should be given as a range, never a single number.

### 6. Reproducible, not lucky
A headline number must come out the same when re-run on the same inputs. If it
depends on something that sometimes loads and sometimes doesn't (a slow external
check, a sampled report), either leave that out of the headline or record the
captured value and reuse it. Re-run once before quoting.

### 7. Identifiers, counts and "there is no X"
The same false authority leaks through non-numbers:
- **Identifiers** (order IDs, URLs, document numbers, citations) are looked up,
  never guessed from a pattern. After looking one up, read back the record's own
  name/title and confirm it is the one you meant. A lookup that succeeds proves
  the ID exists, not that it is the right one.
- **Counts from text search** over-count when a word appears inside other words.
  Spot-check the matches before reporting a count.
- **"There is no X"** is a claim about where you searched. Name the place
  searched, and say "not found in [place]" unless you checked a second place and
  confirmed the search actually works (a broken search returns zero for everything).

## The checklist (paste into working notes, run every time)

```
[ ] Question pinned: what exactly does this number answer?
[ ] Right account/store/property confirmed (rule 0)
[ ] System of record identified; not a proxy (rule 1)
[ ] All sub-surfaces listed AND included (rule 2)
[ ] Window = exact dates; currency, gross/net and timezone pinned
[ ] Cross-checked vs a second system, or tagged "not cross-checked"; any >2x gap explained (rule 3)
[ ] Attribution model named (rule 4)
[ ] Provenance tag written (rule 5)
[ ] Re-run gives the same number (rule 6)
[ ] IDs read back; counts spot-checked; "no X" scoped to where you looked (rule 7)
[ ] FACT / ASSUMPTION / UNVERIFIED labelled on each figure
```

Any unticked box means the number is **UNVERIFIED**. Tell the user which box
and what would close it (usually "export X from Y for these dates"). Do not
fill the gap with a plausible guess.

## Output

Return, in this order:
1. **Verdict:** SHIP / SHIP WITH LABELS / DON'T SHIP YET, in one line.
2. **The numbers**, each with its provenance tag.
3. **Gaps:** what is unverified and the exact next export or check to fix it.
4. If the user gave you a draft (report, post, deck text), a corrected version
   with tags as footnotes. You only draft: nothing is sent, posted or edited in
   any live tool. If you have file access and want to save a corrected copy,
   name the file first, wait for a yes, and never overwrite the original
   without asking.

---
*Free skill from [Nuggts](https://nuggts.fr). Want the whole toolbox? See the Nuggts Brain Packs on [nuggts.fr/packs](https://nuggts.fr/packs).*
