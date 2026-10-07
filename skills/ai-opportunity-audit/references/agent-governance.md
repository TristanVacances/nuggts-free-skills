# Agent governance: the safe-deployment rubric

Use this only when the audit's top pick is an AI that **takes actions** (sends, edits, pays). A chatbot that's wrong produces a bad sentence. An agent that's wrong produces a bad *action*. So beyond "can AI do it" and "does it pay", you need "is it safe to run inside this business".

Method adapted from Dave Brown's guide "How to become an AI agent manager" (Gumroad). Common reference frameworks if you want to read further: NIST AI Risk Management Framework (free, Govern/Map/Measure/Manage), ISO/IEC 42001 (certifiable AI management system), OWASP's agentic security work (prompt injection, excessive agency, tool misuse).

## Artifact 1: the one-page Agent Charter

Written answers to four questions. Many agents running in businesses have none.

1. **Who owns it?** One named person (not a team), plus a named backup. If naming the owner takes more than 5 seconds, that is the finding.
2. **What job does it do, and what can it touch?** One sentence of scope. Then: which systems it reads, which it writes, which actions it can take, whose login it uses, what sensitive data it sees. Add an explicit **"never does this" list**; it is usually more useful than the scope.
3. **How do we know it's helping?** The baseline before the agent existed, 2-3 numbers you track, who reviews them and how often, and the cost per task and per month next to the benefit.
4. **What happens when it's wrong?** How a mistake is detected, who is told, who can pause it, how the action is reversed, how the affected person is made whole, what changes so it doesn't repeat. **If you can't describe the rollback, it's not ready for real use.**

## Artifact 2: risk tier, set per action

Scrutiny should match what the agent can access and change.

| Tier | Looks like | Controls |
|---|---|---|
| Low | Read-only, internal, non-sensitive; drafts a human reviews anyway | Named owner, basic log, quarterly spot-check |
| Medium | Writes to internal systems or touches confidential data; nothing external | Full charter, test set with a pass mark, human approval on writes, monthly review, cost budget |
| High | Talks to customers, moves money, or touches personal/regulated data | All of the above, plus sign-off before launch, a human approves every consequential action, saved logs, tested rollback, incident plan |

**Set approval rules per action, not per agent.** One agent can draft and sort freely all day while needing approval for one kind of write. Govern at agent level and you get too much friction and too much risk at once. Three postures to choose from per action: human approves each action; agent acts and a human monitors and can step in; agent acts and a human reviews afterwards.

## Artifact 3: test and cost scorecard

AI output varies run to run, so test with numbers: run 30-50 real cases with known right answers, grade them, track the success rate. "It worked when I tried it" is not a result; "92% across 40 documented cases" (illustrative example) is. Include hostile inputs (missing data, text that tries to give the agent new orders). Keep a log of failures: documented failures show you were really measuring.

| Metric | What it tells you |
|---|---|
| Baseline | Time, cost and error rate before the agent. Capture it first or every later claim is unfalsifiable. |
| Completion rate | Share of tasks finished without help. The honest headline. |
| Accuracy | From the test set and sampled live work. Say who grades. |
| Escalation rate | How often a human must step in. The earliest warning sign. |
| Rework rate | How often output needs fixing afterwards. Separates real savings from moved work. |
| Cost per completed task | Total spend divided by successful completions. Failures and retries still cost money. |
| Time saved | Only counts if the time went somewhere useful. Say where. |
| Cost vs old process | Agent running cost **plus your oversight time** against the baseline. |

Agent costs are usage-based: loops multiply calls, long conversations cost more per step, failed runs still bill.

**Honesty on numbers.** Any survey statistic about AI governance or ROI you may come across is directional at best. Measure your own.
