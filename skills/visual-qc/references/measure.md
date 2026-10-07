# Measurement snippets

Python with Pillow and numpy. Run them in code execution on the uploaded files. Change the
file names to match. Every snippet prints its numbers: report only what it printed.

If `import` fails, report the check as `not checked` and say which library was missing.

In Claude Code or Cowork these snippets write their output files (`diff_map.png`, `tile_*.png`, `frame_*.png`) into the current folder. Before running one that saves files, list the names, check none already exists, and wait for a yes; or write them into a fresh `qc_out/` folder. In the plain Claude app they stay in the chat sandbox and need no approval.

## 1. Basic facts (every image)

```python
from PIL import Image
import os
for path in ["image.png"]:
    im = Image.open(path)
    w, h = im.size
    from math import gcd
    g = gcd(w, h)
    print(path, f"{w}x{h}", f"ratio {w//g}:{h//g} ({w/h:.3f})", im.format, im.mode,
          "alpha" if "A" in im.getbands() else "no alpha",
          f"{os.path.getsize(path)/1024:.0f} KB")
```

Common targets to compare against (check the platform's current guidance; these change):
square 1:1, portrait 4:5, vertical 9:16, landscape 16:9.

## 2. Blank frames and clipping

```python
import numpy as np
from PIL import Image
a = np.asarray(Image.open("image.png").convert("L"), dtype=float)
print("pixel spread (std):", round(a.std(), 2), "-> near 0 means blank/flat")
print("pure black %:", round((a <= 2).mean()*100, 2), " pure white %:", round((a >= 253).mean()*100, 2))
```

There is no universal cut-off. A spread of almost zero is a blank frame; large clipped
areas are worth a look, not an automatic fail (a white studio background is clipped on
purpose).

## 3. Sample real colours vs a brand hex

```python
import numpy as np
from PIL import Image
im = np.asarray(Image.open("image.png").convert("RGB")).astype(int)
brand = tuple(int("1F3A5F"[i:i+2], 16) for i in (0, 2, 4))   # replace the hex
# region to sample: (left, top, right, bottom) in pixels, picked after looking at the image
l, t, r, b = 100, 200, 300, 260
patch = im[t:b, l:r].reshape(-1, 3)
mean = patch.mean(axis=0).round().astype(int)
print("brand", brand, "measured mean", tuple(int(v) for v in mean),
      "distance", round(float(np.linalg.norm(mean - np.array(brand))), 1))
# grid of real samples, to set thresholds from actual pixels
for y in range(t, b, max(1, (b-t)//4)):
    print([tuple(int(v) for v in im[y, x]) for x in range(l, r, max(1, (r-l)//6))])
```

The distance is plain RGB distance: good for "did this drift a lot", not a perceptual
colour-science measure. Say which region you sampled.

## 4. Duplicate or near-duplicate images / frames

```python
import numpy as np
from PIL import Image
paths = ["f1.png", "f2.png", "f3.png"]
def small(p):
    return np.asarray(Image.open(p).convert("L").resize((64, 64)), dtype=float)
imgs = [small(p) for p in paths]
for i in range(len(paths)):
    for j in range(i+1, len(paths)):
        d = np.abs(imgs[i] - imgs[j]).mean()
        print(paths[i], paths[j], "mean difference:", round(d, 2), "(0 = identical)")
```

## 5. Same-framing diff map (cases B and C only)

```python
import numpy as np
from PIL import Image
A = Image.open("a.png").convert("RGB")
B = Image.open("b.png").convert("RGB")
if A.size != B.size:
    print("WARNING: sizes differ", A.size, B.size, "-> resizing B; only valid if framing is the same")
    B = B.resize(A.size)
a, b = np.asarray(A, dtype=float), np.asarray(B, dtype=float)
diff = np.abs(a - b).mean(axis=2)
print("mean difference:", round(diff.mean(), 2), " % pixels changed (>25):", round((diff > 25).mean()*100, 2))
Image.fromarray(np.clip(diff*3, 0, 255).astype("uint8")).save("diff_map.png")
print("saved diff_map.png (bright = changed)")
```

Look at `diff_map.png` and name what the bright regions are. If scikit-image is
available, `skimage.metrics.structural_similarity` gives an SSIM score as well (closer to
1 = more similar); never use it across different camera angles.

## 6. Crop into tiles for a closer read

```python
from PIL import Image
im = Image.open("image.png")
w, h = im.size
cols, rows = 3, 3
for r in range(rows):
    for c in range(cols):
        box = (c*w//cols, r*h//rows, (c+1)*w//cols, (r+1)*h//rows)
        tile = im.crop(box)
        tile = tile.resize((tile.width*2, tile.height*2))
        tile.save(f"tile_r{r}c{c}.png")
print("saved", rows*cols, "tiles; open each one and read it")
```

Use for text, hands, faces, small objects and counting. These files stay in the chat
sandbox; ask before saving them anywhere else.

## 7. Video frames

**Try in the sandbox first:**

```python
try:
    import cv2
    cap = cv2.VideoCapture("clip.mp4")
    n = int(cap.get(cv2.CAP_PROP_FRAME_COUNT)); fps = cap.get(cv2.CAP_PROP_FPS)
    if not cap.isOpened() or n <= 0:
        raise RuntimeError(f"could not decode the clip (frames={n})")
    print("frames", n, "fps", fps)
    saved = 0
    for k, idx in enumerate(range(0, n, max(1, n//8))):
        cap.set(cv2.CAP_PROP_POS_FRAMES, idx); ok, f = cap.read()
        if ok:
            cv2.imwrite(f"frame_{k:02d}.png", f); saved += 1
    print("saved", saved, "frames")
    if saved == 0:
        print("cannot open video here: no frame could be read")
except Exception as e:
    print("cannot open video here:", e)
```

If that fails: ask the user to upload stills (exported frames or screenshots at a few
timestamps). Then run snippets 4 and 5 on consecutive frames.

**Claude Code / Cowork with ffmpeg on the user's machine** (show the commands and get a
yes before writing files into their folders):

```bash
# 8 evenly spaced frames into a new folder
mkdir -p qc_frames && ffmpeg -i clip.mp4 -vf "fps=8/$(ffprobe -v error -show_entries format=duration -of csv=p=0 clip.mp4)" qc_frames/f%02d.png
# if ffprobe is missing, use -vf fps=1 instead (one frame per second)
# frozen stretches (same picture for 0.5 s or more)
ffmpeg -i clip.mp4 -vf freezedetect=n=-60dB:d=0.5 -map 0:v -f null - 2>&1 | grep freeze
# sudden jumps (unexpected cuts or morph pops); 0.3 is a starting threshold, tune it
ffmpeg -i clip.mp4 -vf "select='gt(scene,0.3)',metadata=print" -f null - 2>&1 | grep scene_score
# same-framing difference map of two stills
ffmpeg -i a.png -i b.png -filter_complex "[0][1]blend=all_mode=difference" -frames:v 1 diff_ffmpeg.png
```

What these can't tell you: whether a motion is *natural*. They flag freezes and jumps;
smooth-but-wrong morphing still needs a frame-by-frame read and a second reviewer.
