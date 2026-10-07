# HTML Print PDF

**Get PDFs that fit their pages the first time: no cut-off text, no half-empty pages, no blank page at the end.**

**What it does:** you ask for a report, proposal, CV or press kit as a PDF ("make this 8 pages, A4"). Claude:
1. works out the page budget before designing anything
2. writes the HTML with print CSS that avoids the silent traps (clipped text, spill-over blank pages, missing backgrounds, colliding labels)
3. adds a small measuring panel that shows, per page, how many millimetres are free or overflowing and which column to cut from
4. fixes overflow by cutting whole lines from the tallest column, the only edit that actually moves the page
5. checks every page visually before calling it done

In the plain Claude app you open the file in Chrome or Edge and click **Save as PDF** with the settings the skill gives you. In Claude Code with Chrome installed, Claude renders the PDF itself. Content cuts are proposed, never applied without your yes.

**Before:** you trim words for an hour, the page still overflows by the same amount, and the PDF ends with a blank page.
**After:** every page shows its free space in millimetres, the cuts land where they count, and the PDF matches the page count you asked for.

**Credits:** a Nuggts original, built from fixing real client documents.

Install: see [INSTALL.md](../../INSTALL.md).
