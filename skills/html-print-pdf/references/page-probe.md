# Page probe: measure what governs each page

Paste this script at the end of a **check copy** of the document (never the file you hand
over), just before `</body>`. It needs pages marked up as `.page` elements of fixed size.

It reports, per page:
- **signed slack** in mm (negative = overflow, large positive = under-fill)
- **lines to cut** when a page overflows (the deficit in whole rendered lines)
- the **governing column**: in a multi-column row, the tallest one, which is the only one
  worth cutting from

Three ways to read it:
1. **Plain Claude app / anyone:** open the check copy in Chrome or Edge. A small panel in the
   top-right corner lists every page. The panel never prints.
2. **Browser console:** the same table appears in DevTools → Console.
3. **Headless Chrome (Claude Code / terminal):** run with `--dump-dom` and read the JSON in
   `<script id="page-probe-result">`.

Adjust the call at the bottom: `page` = your page selector, `footer` = the folio/footer
inside each page (optional), `columns` = the column selector (optional).

```html
<script>
(function () {
  "use strict";
  var PX_PER_MM = 96 / 25.4;
  function mm(px) { return Math.round((px / PX_PER_MM) * 10) / 10; }

  function lowestBottom(pageEl, stopEl) {
    var lowest = -Infinity, all = pageEl.querySelectorAll("*");
    for (var i = 0; i < all.length; i++) {
      var el = all[i];
      if (stopEl && (el === stopEl || stopEl.contains(el))) continue;
      var r = el.getBoundingClientRect();
      if (r.width === 0 && r.height === 0) continue;
      if (getComputedStyle(el).visibility === "hidden") continue;
      if (r.bottom > lowest) lowest = r.bottom;
    }
    return lowest === -Infinity ? pageEl.getBoundingClientRect().top : lowest;
  }

  // Measure each column's CONTENT, not its box: grid/flex items stretch to the row
  // height, so their boxes all report the same number.
  function columns(pageEl, sel) {
    if (!sel) return null;
    var cols = Array.prototype.slice.call(pageEl.querySelectorAll(sel));
    if (!cols.length) return null;
    var heights = cols.map(function (el, i) {
      var top = el.getBoundingClientRect().top, bottom = top;
      for (var j = 0; j < el.children.length; j++) {
        var r = el.children[j].getBoundingClientRect();
        if (r.width === 0 && r.height === 0) continue;
        if (r.bottom > bottom) bottom = r.bottom;
      }
      return { label: (el.className || "col") + " #" + (i + 1), heightMm: mm(bottom - top) };
    });
    var tallest = Math.max.apply(null, heights.map(function (h) { return h.heightMm; }));
    var tied = heights.filter(function (h) { return h.heightMm === tallest; });
    return { columns: heights, governing: tied.map(function (h) { return h.label; }).join(" + ") };
  }

  window.PAGE_PROBE = function (opts) {
    var o = Object.assign({ page: ".page", footer: null, columns: null,
                            minSlackMm: 3, underfillRatio: 0.4 }, opts || {});
    var pages = Array.prototype.slice.call(document.querySelectorAll(o.page));
    if (!pages.length) {
      var msg = 'page probe: selector "' + o.page + '" matched nothing. Not a clean result.';
      console.error(msg);
      var errStyle = document.createElement("style"); errStyle.textContent = "@media print{#probe-panel{display:none!important}}"; document.head.appendChild(errStyle);
      var errBox = document.createElement("div"); errBox.id = "probe-panel"; errBox.setAttribute("style", "position:fixed;top:8px;right:8px;z-index:99999;background:#fff;color:#b00020;border:2px solid #b00020;font:12px/1.4 monospace;padding:8px"); errBox.textContent = msg; document.body.appendChild(errBox);
      var errSink = document.createElement("script"); errSink.id = "page-probe-result"; errSink.type = "application/json"; errSink.textContent = JSON.stringify({ ok: false, error: msg }); document.body.appendChild(errSink);
      return { ok: false, error: msg };
    }
    var report = pages.map(function (pageEl, i) {
      var pr = pageEl.getBoundingClientRect();
      var foot = o.footer ? pageEl.querySelector(o.footer) : null;
      var limit = foot ? foot.getBoundingClientRect().top
                       : pr.bottom - (parseFloat(getComputedStyle(pageEl).paddingBottom) || 0);
      var slack = mm(limit - lowestBottom(pageEl, foot));
      var block = mm(limit - pr.top);
      var flags = [];
      if (slack < 0) flags.push("OVERFLOW");
      else if (slack < o.minSlackMm) flags.push("TIGHT (<" + o.minSlackMm + "mm)");
      if (slack > o.underfillRatio * block)
        flags.push("UNDERFILL (" + Math.round(slack / block * 100) + "% blank)");
      var p = pageEl.querySelector("p, li, td") || pageEl;
      var cs = getComputedStyle(p), lhPx = parseFloat(cs.lineHeight) || 1.2 * parseFloat(cs.fontSize);
    var lh = mm(lhPx || 0);
      var cut = slack < o.minSlackMm && lh > 0 ? Math.ceil((o.minSlackMm - slack) / lh) : 0;
      var c = columns(pageEl, o.columns) || {};
      return { page: i + 1, slackMm: slack, lineHeightMm: lh, linesToCut: cut,
               governing: c.governing || "-", columns: c.columns || [], flags: flags };
    });
    var bad = report.filter(function (r) { return r.flags.length; });
    var result = { ok: bad.length === 0, pages: report,
      summary: report.length + " pages, " + bad.length + " flagged" };

    console.table(report.map(function (r) { return { page: r.page, slack_mm: r.slackMm,
      lines_to_cut: r.linesToCut, governing: r.governing, flags: r.flags.join(", ") || "ok" }; }));

    // JSON sink for headless --dump-dom
    var sink = document.getElementById("page-probe-result") || document.createElement("script");
    sink.id = "page-probe-result"; sink.type = "application/json";
    sink.textContent = JSON.stringify(result);
    document.body.appendChild(sink);

    // On-screen panel (screen only, never printed)
    var style = document.createElement("style");
    style.textContent = "#probe-panel{position:fixed;top:8px;right:8px;z-index:99999;" +
      "background:#fff;color:#111;border:2px solid #111;font:12px/1.4 monospace;" +
      "padding:8px;max-height:90vh;overflow:auto}#probe-panel .bad{color:#b00020}" +
      "@media print{#probe-panel{display:none!important}}";
    document.head.appendChild(style);
    var panel = document.getElementById("probe-panel") || document.createElement("div");
    panel.id = "probe-panel";
    panel.innerHTML = "<b>" + result.summary + "</b><br>" + report.map(function (r) {
      return '<span class="' + (r.flags.length ? "bad" : "") + '">p' + r.page + ": " +
        r.slackMm + "mm" + (r.linesToCut ? ", cut " + r.linesToCut + " lines" : "") +
        (r.governing !== "-" ? ", tallest: " + r.governing : "") +
        (r.flags.length ? " [" + r.flags.join(", ") + "]" : "") + "</span>";
    }).join("<br>");
    document.body.appendChild(panel);
    return result;
  };

  // Run once fonts are loaded; fonts change line breaks, so measuring earlier lies.
  (document.fonts ? document.fonts.ready : Promise.resolve()).then(function () {
    PAGE_PROBE({ page: ".page", footer: ".folio", columns: ".col" });
  });
})();
</script>
```

## Reading the numbers

| result | meaning | what to do |
|---|---|---|
| `slack >= 3mm`, no flag | page fits with headroom | nothing |
| `TIGHT` | fits by less than 3 mm | will often break after a small edit or a font change; cut one line |
| `OVERFLOW` | content runs past the page | cut `linesToCut` whole lines from the **tallest** column |
| `UNDERFILL` | more than 40% of the page is empty | merge with the next section, or move a block in |

The 3 mm headroom and 40% under-fill thresholds are starting defaults. Change them in the
call if your document needs different ones.

## What the probe cannot see

It measures the vertical axis only. It is silent on horizontal collisions, clipped text,
widows and orphans, missing images, and fonts that fell back. That is why the visual check
of every page is not optional.
