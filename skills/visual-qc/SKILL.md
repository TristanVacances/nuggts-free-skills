---
name: visual-qc
description: >-
  A quality gate for images before they ship: AI-generated pictures, video frames,
  renders, mockups and screenshots. Measures instead of eyeballing. Checks the real
  pixels with code (size, aspect ratio, blank or duplicate frames, colour against a
  brand value, what changed between two versions), then reads the image one checklist
  item at a time and cites where it saw each thing (counts, text spelling, hands,
  on-model characters, AI artefacts). Ends with PASS / FLAG and the evidence, and never
  passes off a self-review as an independent one. Use when someone says "check
  this image", "QC these frames", "is this consistent", "does this look right", "before
  I post this", "compare these two versions", "are these the same room", "spot the AI
  mistakes", "visual QC", or before calling any generated visual "good", "clean" or
  "consistent".
---

# Visual QC: measure before you say "good"

A common failure is not a bad generator. It is a quick look, the words "looks great",
then someone else spots the sixth finger, the misspelled sign or the desk that moved
between shots. This skill replaces the quick look
with a gate: **measure what code can measure, read the rest one item at a time, cite
the evidence, and let someone other than the maker sign off.**

Banned output: "looks consistent", "clean", "on-brand", "same room" with no evidence
behind it.

## Ground rules

- **Count and cite, one thing at a time.** Every verdict line names *where* you saw it
  ("frame 3, top-left sign"). In our experience a checklist answered item by item catches more than an
  overall impression, so never answer the whole checklist in one sweep.
- **Say how you know.** Tag each line `measured` (code ran and printed a number),
  `read` (you looked at the pixels) or `not checked` (can't be done in this setup).
  Never present a `read` as a `measured`, and never report a number unless the code
  actually ran here and printed it.
- **Never self-grade your own generation.** If you made or prompted the image in this
  conversation, you are not the final judge. See step 5.
- **Draft-only, files safe.** Nothing is posted, sent, uploaded or deleted. Originals are
  never overwritten. Before saving any file into the user's folders (crops, diff maps,
  a report), list the files and wait for a yes. Files created inside the chat's own
  sandbox to show results are fine.

## Step 1: What are we checking, against what?

Ask only what is missing (one short message):
- **The asset(s):** single image, two versions, a set of frames, a clip.
- **The spec:** target size or platform, aspect ratio, brand colours (hex), required text
  (exact wording), a reference image for any character, product or logo.
- **The claim to test:** "ready to post", "same character as the reference", "two angles
  of one room", "only the background changed".

No spec? Check against common sense plus the AI-artefact list, and say so in the report.

## Step 2: Classify the comparison (it decides which checks mean anything)

| Case | Pixel diff / similarity score | Object counts must match | Main test |
|---|---|---|---|
| **A. One image vs its spec** | n/a | vs spec | Measurements + checklist |
| **B. Same framing** (two variants of one shot, before/after an edit) | Meaningful | Yes | Diff map: what moved or appeared |
| **C. Frames of one clip** | Meaningful frame to frame | Yes, unless the action explains it | Jumps, freezes, morphing |
| **D. "Same place, different camera angle"** | **Meaningless** | **No** | Parallax (below) |

**Case D, the trap.** A new angle legitimately shows more windows or more chairs, so
different counts are expected there. The real tell that two images are *not* one place
is missing parallax: when a camera really moves, near objects shift more than far ones,
what hides what changes, and the lines converge to a new vanishing point. If the
foreground furniture sits in the same screen position and arrangement while the "angle"
changed, these are two separate pictures in the same style. Two independent 2D
generations cannot be relied on to be the same space; if the user needs true
multi-angle consistency, the honest fix is rendering both angles from one 3D scene, or
generating the second view from the first with an image-to-image or multi-view tool and
checking it again. This is a judgement call: mark it `read`, and escalate it in step 5.

## Step 3: Measure (code execution)

Run the snippets in `references/measure.md` on the actual files. They use Python with
Pillow and numpy, which code execution environments commonly include; if not, the import
error tells you. If an
import fails, say so and mark those lines `not checked`; don't improvise a number.

| Check | Catches | Does NOT catch |
|---|---|---|
| Dimensions, aspect ratio, format, alpha, file size | Wrong export size, wrong ratio for the platform, missing transparency, wrong format | Whether the content is any good |
| Blank / near-uniform test (pixel spread) | Black, white or empty frames, failed renders | A wrong but busy image |
| Clipping (% of pixels at pure black or white) | Blown highlights, crushed shadows | Whether the look is intended |
| Colour sampling vs brand hex | A brand colour that drifted under lighting or compression | Whether the *right object* is that colour (you pick the region) |
| Duplicate / near-duplicate frames (hash, mean difference) | Repeated frames, a stuck clip, the "same" image uploaded twice | Subtle content errors |
| Same-framing diff map + difference score (cases B, C) | Exactly what moved, appeared or vanished | Anything across a different camera angle (case D) |
| Zoomed crops / tiles | Gives you a closer *read* of small details | Nothing by itself: it feeds step 4 |

**Colour rule.** Derive any colour threshold from the real pixels, not from the brand
hex. Print a grid of sampled RGB values across the regions you care about, then decide.
Lighting, white balance and compression all move colours; the spec hex is a starting
hypothesis.

**Fitting rule.** Anything that *fits* a shape to the image (a circle, a line, a
perspective) always returns an answer, so a successful run proves nothing. Check the fit
back against the input (does the fitted shape's area match the pixel count? do the
points sit on the line?) and fail loudly when they disagree.

**Video.** In the plain Claude app, the sandbox may or may not be able to open video
files. Try once (see `references/measure.md`). If it can't, ask the user to export a
handful of frames (or take screenshots at a few timestamps) and upload them as images.
In Claude Code or Cowork with ffmpeg installed on the user's machine, the same file
gives ffmpeg recipes for frame extraction, freeze detection and sudden scene jumps.
Without either, motion problems between frames (jitter, flicker, morphing) are
`not checked`: a few stills cannot prove a clip is smooth.

## Step 4: Read the image, one item at a time

Open the pixels yourself (Claude can view uploaded images). For small details, crop and
enlarge regions with the tile snippet first: a full image is often downscaled before you
see it, so tiny text, fingers and far-away objects get lost. If you cannot open the tiles
yourself in this environment, show them to the user and ask them to re-upload the one or
two you need; failing that, read at the resolution you have and mark that line
low-confidence. Fill each line with evidence:

- **Counts:** the key objects (people, hands, fingers per hand, products, windows, chairs).
  Above roughly ten small items, count per tile and add up, and mark the count
  low-confidence.
- **Positions:** where each anchor object sits (left / centre / right, foreground /
  background). Same as the reference or the other version?
- **Text:** read every word letter by letter against the required wording. Generated
  text often looks right at a glance and is misspelled up close.
- **People:** hands, fingers, eyes, teeth, ears, limbs joining the body, the same face
  as the reference.
- **Characters, products, logos:** on-model against the reference (shape, colour,
  accessories, proportions, logo geometry).
- **Set and light:** wall and floor colours, light direction and time of day, shadows
  that agree with each other.
- **AI artefacts:** melted or merged objects, duplicated objects, warped straight lines,
  garbled text or signage, repeated texture tiles, smeared edges, a watermark or
  signature the generator baked in.
- **Does the intended moment read?** Would a stranger get it in two seconds?
- **Platform:** key content inside the safe area once cropped to the target ratio.

Any ❌, or a count mismatch nobody can explain, is a **FLAG**.

## Step 5: Independent review (never self-grade)

A model reviewing its own output tends to see what it meant to make, not what is there.
In order of strength:
1. **A different vision model** (another AI assistant the user has), or a person with a
   good eye, given only the image, the spec and the checklist, not your verdict.
2. **A fresh Claude chat** with only the image, the spec and the checklist. Weaker than a
   different model (same blind spots), still better than the maker grading itself.
3. **If neither is possible right now:** say so, mark the report `self-reviewed only`,
   and list the two or three items a human should eyeball first.

In Claude Code, a separate subagent with no access to the generation prompt can do
option 2 inside the session. Write the reviewer prompt so it asks for counts and
locations, not "is this good?". Case D always goes to step 5 with the explicit question:
"did the fixed objects move with the camera, or stay pinned in place?"

## Step 6: Report

Lead with the verdict, then the table.

```
VERDICT: FLAG (worst: the sign reads "GRAND OPENNING")    Reviewed by: fresh chat

| # | Check | Result | Evidence | How |
|---|-------|--------|----------|-----|
| 1 | Size 1080x1350 (4:5) | ✅ | 1080x1350, RGB, 412 KB | measured |
| 2 | Sign text | ❌ | top banner, 2nd word "OPENNING" | read |
| 3 | Hands | ⚠️ | left hand, 6 fingers? crop inconclusive | read |
| 4 | Clip smoothness | — | only 4 stills supplied | not checked |
```

Verdicts: **PASS** (no ❌, every ⚠️ explained), **FLAG** (any ❌, or ⚠️ that matters),
**NEEDS HUMAN EYES** (key items `not checked` or self-reviewed only).

For each FLAG, give the fix: re-generate, edit or inpaint the region, fix the text in a
design tool rather than re-rolling, or for multi-angle sets use one 3D scene. Never
soften a FLAG into "good enough"; the user decides whether to ship it anyway.

## What this skill can't do

It cannot prove an image is good, only find measurable faults and listed artefacts. Pixel
checks can't judge taste; a vision read can miss tiny details. Motion quality needs the
clip and a tool that can open it.

---
*Free skill from [Nuggts](https://nuggts.fr). Want the whole toolbox? See the Nuggts Brain Packs on [nuggts.fr/packs](https://nuggts.fr/packs).*
