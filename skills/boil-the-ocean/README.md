# Boil the Ocean

**Stop getting "here's a plan" when you asked for the thing.** An operating standard that makes Claude deliver the finished, tested, documented result.

**What it does:** when you say "do it right" or "boil the ocean" (or start something ambitious), Claude switches to completion mode:
- searches for what already exists before building
- checks it can actually deliver (logins, tools) before starting
- covers the edge cases
- tests and shows you the proof
- documents it
- runs a multi-lens review before you see anything

It never invents facts to look done, and never touches what you said was off-limits. Code builds get an extra checklist (`references/code-completeness.md`): silent failures, security, deploy and rollback.

**Before:** "Here's a 6-step plan to set up your landing page. Want me to start?"
**After:** the landing page is live, the form is tested with a fake submission, the mobile layout is checked, and there's a one-page README for next time.

**Credits:** a Nuggts original, written and hardened over months of daily use, every rule earned by something that went wrong once.

Install: see [INSTALL.md](../../INSTALL.md).
