# Visual QC

**Stop shipping the sixth finger.** A quality gate for AI images, video frames, renders and mockups that measures the real pixels and reads them item by item, instead of saying "looks great".

**What it does:** give it an image (or two versions, or a few frames) and what it's for. It:
1. asks for the spec once (size, platform, brand colours, exact text, reference image)
2. works out which checks actually mean something (a pixel diff is useless across two camera angles, for example)
3. measures with code: size, aspect ratio, blank or duplicate frames, clipped highlights, colour against your brand hex, what changed between versions
4. reads the image one checklist item at a time: counts, spelling letter by letter, hands, faces, on-model characters, AI artefacts, with a zoomed tile for small details
5. sends it to a reviewer other than whoever made it, because a model grading its own picture sees what it meant to make
6. hands you PASS / FLAG / NEEDS HUMAN EYES, with a table that says what was measured, what was only looked at, and what couldn't be checked

Works in the Claude app with code execution on. Video checks work best in Claude Code or Cowork with ffmpeg; in the plain app you upload a few stills and it tells you what it couldn't check (motion smoothness stays "not checked").

**Before:** "The poster looks great, ready to post!" Then a follower points out the banner says "GRAND OPENNING".
**After:** "FLAG: top banner, 2nd word misspelled. Size 1080x1350 measured OK. Hands checked on zoomed tiles. Second opinion from a fresh chat. Fix the text in your design tool, don't re-roll."

**Credits:** a Nuggts original, written after declaring generated frames "consistent" one time too many. Uses standard image measures (pixel difference, SSIM, ffmpeg's freeze and scene detection).

Install: see [INSTALL.md](../../INSTALL.md).
