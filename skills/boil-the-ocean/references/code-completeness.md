# Code completeness: the execution-time bar for code builds

Load this only when the thing you're boiling the ocean on is **code**. For a deck, a
document or a research report, ignore it: the base doctrine already covers you.

"Complete" for code is not "it ran once on the happy path". It's the list below. Each
item is a place where code rots silently if you skip it. Silent failure is the default
failure mode, so these items are the definition of done, not optional polish.

## 1. Tests: green, and you watched them go green
- Run the suite and show the output. A passing claim without the run is not a result.
- Cover three paths for every new flow, not just the happy one: **missing input**, **empty input**, **upstream error**. Most production bugs live in the two you didn't write.
- Ask: *what would a hostile QA engineer write to break this?* Write that test.
- **A test that reads a config file is not a test of behaviour.** Asserting that a rule is *present* in a config proves only that someone typed it. Test the real behaviour: the live response, or the real matching engine.
- **Pin or probe the version of every tool or API the build rests on.** Read the installed interface (type definitions, headers, generated schema) before coding against an unfamiliar API. Documentation and memory drift; the installed artefact is the authority.
- **Look vendor facts up live, never from memory.** Library flags, platform limits, model names: check current docs. Stale vendor facts are a top cause of broken builds.
- **With generative APIs, the output schema is part of the prompt.** Adding fields to a repeated nested element can quietly wreck output quality while still validating. Keep repeated elements lean, and re-run representative inputs after ANY schema change.
- **Compute what's computable; don't ask the model to infer it.** An instruction followed inconsistently ("answer in the user's language") becomes reliable once the fact is computed in code and stated.
- **Write the acceptance list before editing**, as checks you can run. Then do one human pass for contradictions no automated check can see.
- No flaky tests. Mock or isolate anything that depends on time, randomness, network or ordering. A flaky test trains you to ignore red.
- **A copy-only change to a site still needs a post-deploy check at real viewport sizes.** Look for horizontal overflow on mobile, console errors, and wrong per-page titles. Diffs don't show layout bugs.
- **A visual deliverable isn't verified until it's rendered and looked at.** Valid data is not a rendered page.
- **"A test covers this" in a comment or README is a citation, not a guarantee.** Find the test. If it doesn't exist, write it, break the invariant on purpose, and watch it fail.

## 2. No silent failures: every error has a name
- No bare catch-all that swallows the error and continues. Name the specific error, then decide: retry, degrade with a visible message, or re-raise with context.
- Log with **context**: what was attempted, with what inputs, for whom. A bug report three weeks later should be reconstructable from logs alone.
- AI calls are their own failure class: malformed JSON, empty response, refusal, a plausible but invalid payload. Handle each separately.
- **An empty search result is not proof of absence. Run a positive control** by searching the same scope for something you know is there. A tool that silently skipped files looks identical to a clean result.
- **Cleanup globs can delete a neighbour's files.** Scope every "clear old outputs" pattern to exactly what the tool owns, and assert output counts afterwards.

## 3. Observability: you can see it work and see it break
- New code paths log at entry, exit and each significant branch. For a feature, name the metric that says it's working and the one that says it's broken.
- Scheduled jobs must leave a legible trace. A job that fails at 3am and says nothing looks the same as one that never ran.

## 4. Security: the new surface is threat-modeled
- Every new input is validated and rejected loudly on bad data (missing, empty, wrong type, too long, injection attempts).
- Every new data access is scoped to the right user. Changing an ID must never reach someone else's data.
- Secrets live in env vars or a keychain: never hardcoded, always rotatable. Check a new dependency's track record before adding it.
- Check every injection vector that applies: SQL, command, template, **and prompt injection**.
- **Any server-side fetch of a URL influenced by input is an SSRF risk.** Allow only http/https. Resolve the host and refuse private, loopback and link-local addresses. Re-validate on every redirect. Cap size and time.

## 5. Deploy and rollback: shipping is planned, not hoped
- Migrations are backward-compatible and reversible.
- Put risky slices behind a flag where it fits.
- **After deploy, verify a code-side artefact** (a new header, function name or log line). Version labels and "up to date" messages prove nothing.
- **Against production, only exercise the side-effect-free half of a behaviour** (the rejection, the 404, the GET). Prove the accepting path in a test harness. A "quick live check" that writes real data corrupts the numbers you're trying to measure.
- Know the rollback (revert, previous version, flag toggle) and roughly how long it takes.
- **What works in your session may not work in the shipped artefact.** A tool available to you while building isn't automatically reachable by the deployed app. Wire the app to something it can reach at runtime.

## 6. Documentation: a cold pickup works
- Write enough that someone can resume without you: a README, a handoff note, reasoning on the non-obvious parts.
- Write down anything deferred. A vague "clean it up later" that isn't written is lost, not deferred.
- **Every step handed to a human needs a proof artefact.** Record three things: what to do · what proof looks like · where the proof gets written.
- **Write retrospectives from the artefacts, not from memory or summaries.** Re-derive every number from the thing it describes.

## The close
Before calling a code build done, walk this list together with the base doctrine:
**run the check, show the output, confirm the code-side artefact.** Then say it's done,
plainly. If an item is out of scope, say which one and why. A named skip is fine; a
silent one is the failure this file exists to prevent.
