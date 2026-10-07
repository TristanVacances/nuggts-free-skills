---
name: html-print-pdf
description: >-
  Build fixed-page A4 or Letter documents as HTML and turn them into clean, print-ready
  PDFs: page budget before layout, print CSS that does not clip or spill, a measuring
  probe instead of guesswork, and a visual check of every page. Use when making a report,
  proposal, dossier, press kit, CV, menu or any PDF with a page count or page cap. Triggers:
  "make this a 12-page PDF", "turn this HTML into an A4 PDF", "fit this on 8 pages", "the
  pages are overflowing", "the PDF has half-empty pages", "text is cut off in the PDF",
  "blank page at the end", "print CSS", "save as PDF looks wrong". Works in the plain
  Claude app (you print to PDF from your browser) and renders directly in Claude Code when
  Chrome is installed. NOT for screen-first web pages, and NOT for commercial print files
  that need bleed, crop marks or CMYK: ask your printer for their spec.
---

# HTML to print PDF: pages that fit on the first render

The one-line version: **compute the page budget before you design, measure signed slack on
every page, and cut whole rendered lines from the tallest column.**

## Which setup are you in?

Check first and tell the user which path you are on.

| setup | what works |
|---|---|
| **Plain Claude app** (chat, code execution on) | Claude writes the print-ready HTML file. The user opens it in Chrome or Edge, reads the probe panel, then prints to PDF. Claude can only render a PDF itself if a check in its sandbox proves a renderer exists (see step 3). It cannot see the user's browser output unless the user uploads the PDF or screenshots. |
| **Claude Code / Cowork with Chrome installed** | Claude renders the PDF itself with headless Chrome, runs the probe, and looks at page images. |

Never claim a page "fits" from reading the HTML. Only a render measures it.

**File writes:** before creating or changing files, list them (name and location) and wait
for a yes. Never overwrite the user's existing HTML or PDF; write a new version
(`report-v2.html`) unless they say otherwise. Nothing is sent, uploaded or printed for them.

## The loop

```
1. BUDGET    arithmetic, before any HTML
2. BUILD     HTML + print CSS from the budget
3. RENDER    headless Chrome, or the user's browser "Save as PDF"
4. PROBE     signed slack + tallest column, every page
5. FIX       structural lever → whole lines → tallest column, in that order
6. LOOK      every page, not a sample
```

The probe (4) and the visual pass (6) catch different defects. Neither replaces the other.

## 1. Budget: arithmetic before layout

A fixed page count turns layout into bin-packing, not a taste call. Sections usually split
only at their own boundaries, so "which section gets two pages" has a computable answer.

```
usable_height     = page_height − top/bottom margins − footer block
content_height    = usable_height − per-page header block
pages_for_section = ceil(section_height / content_height)
total             = sum of pages_for_section   → compare with the cap
```

Estimate section heights from word counts and the line height you plan to use. If the total
is over the cap, decide the compression now (tighter leading, a smaller but still readable
body size, fewer forced section breaks). Raising the minimum font size later inflates
*every* section at once, which is the expensive way to find out.

## 2. Build: print CSS that does not lie to you

Starting skeleton (A4; for US Letter use `size: letter` and `215.9mm × 279.4mm`):

```css
@page { size: A4; margin: 0; }
html, body { margin: 0; }
* { -webkit-print-color-adjust: exact; print-color-adjust: exact; } /* keep backgrounds */
.page {
  width: 210mm; height: 296.9mm;   /* a hair under 297mm: defensive against rounding spill-over */
  padding: 15mm 16mm; box-sizing: border-box;
  position: relative; overflow: visible;      /* NEVER hidden, see below */
  break-after: page;
}
.page:last-child { break-after: auto; }       /* defensive: no forced break after the last page */
.folio { position: absolute; bottom: 8mm; left: 16mm; right: 16mm; }
```

The gotchas, each a silent failure:

- **Never `overflow: hidden` on a fixed-height page.** The text just disappears: the page
  count looks right, nothing errors. Let it overflow so the probe can see it.
- **Fixed-width column + `white-space: nowrap` = horizontal collision.** A long kicker or
  label in a narrow column prints *underneath* its neighbour. Vertical checks never see it.
  For every nowrap element, note the longest string that fits.
- **Blank page after every page, or at the end:** the page box is taller than the paper (a
  height over the page size doubles the page count), or, in some browsers, the last page still
  has a forced break. Use the skeleton above and check the rendered page count: it must equal
  the number of `.page` elements.
- **Use `mm` or `pt` for anything that must fit.** `vh`, `vw` and `%` heights behave
  differently in print than on screen.
- **`position: fixed` repeats on every printed page** in Chrome. Use it only for things you
  want on every page; put per-page furniture inside each `.page`.
- **Backgrounds vanish** unless `print-color-adjust: exact` is set *and*, in a browser,
  "Background graphics" is ticked.
- **Fonts:** if a web font has not loaded when the PDF is made, the fallback font reflows
  every line. Load fonts from a reliable source (Google Fonts, or files next to the HTML),
  and in headless Chrome give the page time (`--virtual-time-budget`). Check the PDF uses
  the font you meant.
- **Images:** no `loading="lazy"` on print documents; lazy images can print as empty boxes.
  Use relative paths that exist next to the HTML.
- **Keep blocks together:** `break-inside: avoid` on figures, cards and table rows; repeat
  table headers with a real `<thead>`.
- **Density classes:** give yourself per-page classes (`.roomy`, `.compact`) so one page
  can be tuned in its last few millimetres without touching the global type scale.
- **Numbers in French and other European languages:** see `references/typography.md`. The
  narrow no-break space from `Intl.NumberFormat` can render as nothing in large serif type.

## 3. Render

**Claude Code / terminal with Chrome installed:**

```bash
rm -f out.pdf    # delete first: a stale PDF looks exactly like a successful render
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --headless --disable-gpu --no-sandbox --no-pdf-header-footer \
  --virtual-time-budget=10000 --print-to-pdf=out.pdf "file://$PWD/doc.html"
```

On Linux, the binary is usually `google-chrome` or `chromium`. Then confirm the file is new
(timestamp after the run) **and** contains a string you expect (`pdftotext out.pdf - | grep
"Your title"` if poppler is installed). A page count alone proves nothing.

On macOS, headless Chrome can hang with no error when the file sits in a protected folder
such as Documents. Copy it to a temporary folder if the render never finishes.

For page images (step 6): `pdftoppm -png -r 80 out.pdf page` if poppler is installed.
Otherwise open the PDF and look at each page.

**Plain Claude app:** first check whether the sandbox has a renderer (for example, test
for a `chromium` binary or a Python `playwright` install, and actually try one render). If
the check fails, say so and do not pretend. Use the browser path instead:

1. The user downloads two files: the clean HTML and a check copy with the probe added (`report-check.html`), plus any images or font files, all in the same folder.
2. Opens it in **Chrome or Edge** (Safari and Firefox handle page size and margins less
   consistently).
3. Opens the check copy, reads the probe panel (step 4) and reports or screenshots it back to you. The panel never prints, so printing from either file is fine; the clean file is the one to keep.
4. Prints (Ctrl/Cmd+P) with: Destination **Save as PDF**, Paper **A4** (or Letter),
   Margins **None** or **Default** (the CSS sets them), Scale **100** (not "Fit"),
   **Headers and footers off**, **Background graphics on**.
5. Uploads the PDF or page screenshots if they want you to check it.

## 4. Probe: measure the thing that governs the page

Use the script in `references/page-probe.md`. Add it to a **check copy** only, never the
delivered file. It reports per page: signed slack in mm, lines to cut, and the tallest
column. In the browser it shows a small on-screen panel that never prints.

Three rules:

- **Flag both tails.** "No overflow" is not enough: a naive one-section-per-page split
  leaves pages mostly blank, and two half-empty pages read as a mistake. Flag overflow
  (slack < 0) and under-fill (slack > 40% of the page) by default.
- **Gate on headroom, not sign.** Require slack of at least 3 mm. A page that fits by
  0.4 mm breaks on the next font change.
- **Name the governing column.** A grid row is as tall as its tallest column. Cuts in the
  shorter column move the slack by exactly zero.

## 5. Fix: in this order, or you move nothing

Convert the deficit into whole lines first: `lines = ceil(deficit_mm / line_height_mm)`.

> **In a fixed page the unit of space is the rendered line, not the word.** Removing eight
> words from a paragraph that still wraps to the same number of lines frees zero space.

Then, always in the **tallest column**:

| order | lever | moves |
|---|---|---|
| 1 | **Structural:** drop a block, merge two list items, delete a table row, change a spacing utility or density class | immediately, in whole lines |
| 2 | **Whole-line cuts:** remove at least `lines` full rendered lines | exactly what you removed |
| 3 | **Copy trimming** | only the last 1–2 mm |

**If the number refuses to move after an edit, switch lever category.** Do not apply more
of the same lever. For under-fill, merge or move sections rather than enlarging type.

Content cuts change the user's words: propose them and get a yes before applying.

## 6. Look: every page, every time

View every page image (rendered by you, or screenshots the user sends). The probe is silent
on everything except vertical space. The visual pass catches:

- horizontal collisions (the nowrap label)
- clipped blocks where `overflow: hidden` slipped through
- widows, orphans, a heading stranded at the foot of a page
- images showing as alt text or empty boxes
- a fallback font

A green probe is exactly when the visual pass matters most. If you could not see the pages
(plain app, no upload), say the visual check is **not done** and ask the user to do it.

## Done means

- [ ] Budget arithmetic written down, and the final page count matches it
- [ ] Probe: every page has slack ≥ 3 mm and no under-fill flag; signed numbers shown to
      the user, not "it fits"
- [ ] Every page looked at (by you or by the user), stated which
- [ ] PDF re-made from scratch after the last edit (fresh file, expected text inside)
- [ ] Probe script removed from the delivered HTML

## Files

- `references/page-probe.md`: the probe script, how to read it, what it cannot see
- `references/typography.md`: European number, punctuation and apostrophe rules for print

---
*Free skill from [Nuggts](https://nuggts.fr). Want the whole toolbox? See the Nuggts Brain
Packs at [nuggts.fr/packs](https://nuggts.fr/packs).*
