# Study method: the demanding-tutor recall loop

Read when the user moves from building the brain to studying it.

Do not study passively. Use the brain (or any loaded source set) with an LLM acting as a demanding tutor, not a summariser. If you use a notebook-style tool that cites sources, check its citations against the source before trusting them.

- **Prompt 1, mental models:** "the 5 mental models experts in <subject> actually use", each with a plain explanation, an example, and the common mistake. Feeds the ELI20 layer.
- **Prompt 2, field debates:** "the 3 major disagreements in <subject>": each camp's argument, where consensus sits, the load-bearing assumption. A live debate maps to `contested N vs M`.
- **Prompt 3, 10 hard questions, answers withheld:** edge cases, applications, trade-offs, generated without showing answers. The learner answers first.
- **The loop:** answer each from memory, take a harsh grade, return to the cited notes, reword the correction in your own words, repeat until correct. The harsh grade is the honesty gate; rewording is the retention step.
- **Progressive diagrams:** for anything with 3 or more moving parts, draw a short series where each frame redraws the previous one and adds exactly one part (A to B, then +C, then +the return path). The learner watches the system assemble instead of decoding a finished tangle. Works for text diagrams and generated images.
