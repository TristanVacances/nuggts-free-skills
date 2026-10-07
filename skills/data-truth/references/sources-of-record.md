# Sources of record: the lookup table

For each metric: the one authoritative source, every sub-surface to sum, the
proxy traps, and the attribution caveat. Tools named are examples only; swap in
whatever the business actually uses. Extend the table as you meet new setups.

> Rule of thumb: the system of record is the one that **creates the event**.
> Everything downstream re-attributes the event through its own (often last-click) lens.

## Online shop / direct-to-consumer (e.g. Shopify or WooCommerce + an email platform + Meta/Google ads)

| Metric | System of record | Sub-surfaces to sum | Proxy traps (never the source) | Attribution caveat |
|---|---|---|---|---|
| Email / SMS revenue | The email/SMS platform (e.g. Klaviyo, Mailchimp) | Automated flows + one-off campaigns (+ SMS if in scope). Pull both reports. | The store's "referrer = email" last-click view (only sees the last click, so it usually undercounts) | Platforms usually use last-touch with a click/open window. State it. |
| Ad spend and return | The ad platform (e.g. Meta Ads, Google Ads) | Every campaign, every objective, including awareness/traffic | The store's "social/paid" last-click view; only quoting the winning campaigns | Platform-reported return is self-attributed and tends to be generous. Cross-check with blended return: total revenue / total ad spend. |
| Total revenue | The store or accounting system (e.g. Shopify, Stripe, your bookkeeping tool) | Full window, every store/channel in scope; gross or net stated | One channel's view; mixing gross and net | Say which; "email = x% of revenue" changes with the denominator. |
| Sessions / conversion rate | One analytics source, chosen and kept (store analytics or e.g. GA4) | Sessions, cart, checkout, purchase over the window | Comparing sessions across two tools (definitions differ) | Pick one source and stay in it. |
| Abandoned checkouts | The store's checkout data | Reached checkout minus completed | n/a | Multiplying by average order value turns it into a model: ASSUMPTION, not FACT. |
| Search traffic | The search engine's own console for the site (e.g. Google Search Console) | Queries + pages | Third-party traffic estimators (modelled, not measured) | Console data is measured for your own site only. |
| Visibility in AI answers | A direct query to the engine, saved with date, location and exact prompt | The prompts actually run | Second-hand or cached claims | Results change with time, location and personalisation. Never state as a fixed fact. |

## Services / B2B (e.g. a CRM + invoicing + a booking tool)

| Metric | System of record | Sub-surfaces to sum | Proxy traps | Caveat |
|---|---|---|---|---|
| Revenue / billed | Invoicing or accounting tool | All invoices in window; credit notes subtracted; paid vs issued stated | CRM "deal value" (forecast, not billed) | Say issued vs paid. |
| Leads | Where the lead first lands (form tool, inbox, booking tool) | Every inbound channel | The CRM if not every channel feeds it | Dedupe before counting. |
| Pipeline | The CRM | Every stage, every owner | A spreadsheet copy | Stage probabilities are ASSUMPTION. |

## Pin these before pulling anything (they silently change every number)
- **Currency** and **gross vs net** (tax, shipping, refunds in or out).
- **Timezone.** Different tools may use different account timezones, which shifts daily and period totals.
- **Window.** Exact start and end dates, written in the output. "Last 12 months" must become real dates.
- **Account.** Confirm the store/ad account/property name before pulling.

## The cross-check habit (the 2x rule in practice)
- Email: platform-attributed revenue vs the store's last-click email revenue. A big gap is expected (last-click misses much of email's influence). Say so explicitly.
- Paid: platform-reported return vs the store's paid last-click revenue vs blended return. Where they diverge is the story.
- Any gap over about 2x is never "just pick one". Ask why; the answer usually decides whether the number is right.
