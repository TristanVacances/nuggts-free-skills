# Memory folder templates

Create these four files on first use, after the user says yes. Plain Markdown, no
special tool needed. Dates are always today's real date, `YYYY-MM-DD`.

## memory/now.md (overwritten every close-out, 10 lines max)

```markdown
# Now (updated YYYY-MM-DD)
- Working on: <project or goal, one line>
- State: <where it stands>
- Open: <thread 1>
- Open: <thread 2>
- Blocked by: <blocker, or "nothing">
- Next step: <the single next action>
```

Rules: current state only. No history, no "today we did...". If it's past 10 lines,
cut the least load-bearing line.

## memory/decisions.md (append-only)

```markdown
# Decisions
Append-only. Never edit or delete an entry. Add annotations below an entry instead.

2026-01-15
Context: choosing where to host the newsletter sign-up form
Choice: use the form built into the email tool
Rejected: a custom form on the website
Consequence: the site links out to the email tool's page; revisit if conversions look low
```

## memory/learnings.md (append-only)

```markdown
# Learnings
Append-only. Never edit or delete an entry.

2026-01-15
Learning: drafts read better when I give Claude one example of my own writing first
Apply: paste one past email before asking for any new draft
```

## memory/frictions.md (append-only)

```markdown
# Frictions
Append-only. Never edit or delete an entry.

2026-01-15
Friction: the spreadsheet export kept dropping accented characters
Workaround: export as UTF-8 CSV, not the default format
```

(The entries above are made-up examples to show the format.)

## Annotations (for the weekly review)

Add on a new line directly below the entry they refer to. Never change the entry
itself.

- `RESOLVED YYYY-MM-DD: <how>`: the friction is fixed.
- `NOT APPLIED: <why>`: a learning that didn't stick.
- `RETURN: <what happened>`: a decision whose consequence showed up (good or bad).

## Session start (pairs with the close-out)

Open the next session with one line: "Read memory/now.md and the last few entries of
each log, then we continue." In the plain Claude app, paste or upload `now.md` instead.
