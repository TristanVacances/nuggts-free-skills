# European typography for print PDFs

The rules that go wrong in a rendered PDF, not the full style guide.

## The one that looks like a bug and is not

`Intl.NumberFormat("fr-FR")` (and some other European locales) groups thousands with
**U+202F, the narrow no-break space**. It is typographically correct, but it renders
unreliably: in some serif fonts at large sizes it collapses to almost nothing. The same
bytes can read `2500` in a big heading and `2 500` in body text, so it looks like an
inconsistency between pages when the strings are identical.

**For print, replace it with a regular no-break space (U+00A0), which renders at every
size:**

```js
const fmt = new Intl.NumberFormat("fr-FR", { style: "currency", currency: "EUR" });
const forPrint = (n) => fmt.format(n).replace(/[\u202F\u2009]/g, "\u00A0");
```

Do the same for any `Intl` output that reaches a PDF: dates, units, percentages.

## Space before punctuation: French only

French takes a no-break space before `: ; ! ?` and inside guillemets `« … »`.
**Portuguese, Spanish and Italian do not.** Copying the French rule into a sibling
language is a common error.

| language | before `: ; ! ?` | quotes |
|---|---|---|
| French | no-break space (U+00A0) | `« texte »` |
| Portuguese / Spanish / Italian | none | language-specific; check the house style |

Use U+00A0 rather than U+202F, for the rendering reason above.

## Apostrophes and accented text in code

French uses the curly apostrophe `’` (U+2019). It matters twice:

1. Visually, in a serif at heading sizes.
2. In any regex that matches words: include the apostrophe in the letter class, or
   elisions split (`l’entreprise`, `d’accord`).

In JavaScript, `\b` and `\w` are ASCII-only, so an accented letter counts as a non-word
character and a "word boundary" appears mid-word. Anchor explicitly instead:

```js
const LETTERS = "A-Za-zÀ-ÖØ-öø-ÿ'’";
new RegExp(`(?<![${LETTERS}])${word}(?![${LETTERS}])`, "gu");
```

## Dates

- French: the first of the month is ordinal, **`1er septembre`**; every other day is a
  plain number. Months are lowercase.
- Portuguese: `1º de setembro`.
- Test with a date on the 1st: it is the case that slips through because it rarely comes up.

## Before signing off a French PDF

- [ ] No U+202F left in the rendered text (if poppler is installed:
      `pdftotext out.pdf - | grep -c $'\xe2\x80\xaf'` → 0)
- [ ] Curly apostrophes throughout
- [ ] No-break space before `: ; ! ?` in French copy, and absent in other languages
- [ ] `1er` handled for the first of the month
- [ ] Read one page aloud. Typography errors survive automated checks.
