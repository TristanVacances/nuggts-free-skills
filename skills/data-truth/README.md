# Data Truth

**Every number you send out comes with its receipt, so you catch a wrong figure before a client does.**

**What it does:** before a measured number (money, %, count) goes into a report, proposal, pitch or post, Claude runs it through a short gate:
1. checks it comes from the system that created the event, not a proxy (the email platform for email revenue, not the shop's last-click view)
2. lists every part that should be summed, so a partial total can't pass as the whole
3. compares two sources and stops on any gap over about 2x
4. names the attribution model and the exact dates
5. tags each figure FACT, ASSUMPTION or UNVERIFIED, with where it came from

In the plain Claude app it works from the exports and screenshots you upload, and says clearly what it could not check.

**Before:** "Email made us [small number] last year", taken from the shop dashboard, and corrected twice after the client pushes back.
**After:** one figure, from the email platform, flows and campaigns summed, dates and attribution model stated, with a footnote showing where it came from.

**Credits:** a Nuggts original, born from a reporting mistake the author made and never wants to repeat.

Install: see [INSTALL.md](../../INSTALL.md).
