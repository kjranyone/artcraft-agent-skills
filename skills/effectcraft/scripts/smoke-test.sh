#!/usr/bin/env bash
# End-to-end smoke test: build a comp with an animated, blurred text layer,
# save, render one frame and an H.264 movie, then validate the artifacts.
# Usage: smoke-test.sh
set -euo pipefail

CLI=${EFFECTCRAFT_CLI:-effectcraft-cli}
command -v "$CLI" >/dev/null || { echo "smoke: $CLI not found" >&2; exit 2; }

TMP=$(mktemp -d /tmp/ec-smoke.XXXXXX)
cleanup() { rm -rf "$TMP"; }
trap cleanup EXIT

PROJ="$TMP/smoke.ecproj"; OUT="$TMP/out.mp4"; PNG="$TMP/frame.png"

echo "smoke: $("$CLI" --version) in $TMP"

"$CLI" --empty --save-as "$PROJ" run \
  file.newProject '{}' \
  comp.new '{"name":"Smoke","width":640,"height":360,"frameRate":30,"duration":3}' \
  layer.newText '{"text":"SMOKE","size":96,"fill":"#ff5533","position":[320,180]}' \
  prop.addKey '{"layer":2,"path":"transform.position","timeBase":"comp","time":0,"value":[100,180]}' \
  prop.addKey '{"layer":2,"path":"transform.position","timeBase":"comp","time":2,"value":[540,180]}' \
  effect.apply '{"effect":"Gaussian Blur","layers":[2]}' \
  --json > "$TMP/run.json"

cat "$TMP/run.json" | head -8

"$CLI" --project "$PROJ" render-frame --out "$PNG" --time 1.0 --max-side 320 >/dev/null
"$CLI" --project "$PROJ" render --out "$OUT" --format h264 --start 0 --end 2 > "$TMP/render.log" 2>&1
cat "$TMP/render.log"

PYBIN=""
for cand in python3 python; do
  # skip the Windows Store python3.exe stub: it exists but cannot run code
  if command -v "$cand" >/dev/null 2>&1 && "$cand" -c "pass" >/dev/null 2>&1; then
    PYBIN="$cand"; break
  fi
done
[ -n "$PYBIN" ] || { echo "smoke: no usable python (python3/python)" >&2; exit 3; }
"$PYBIN" - "$PROJ" "$OUT" "$PNG" <<'PY'
import json, struct, sys, zlib
proj, out, png = sys.argv[1:4]

def check(cond, msg):
    print(("ok   " if cond else "FAIL ") + msg)
    if not cond:
        raise SystemExit(1)

import os
check(os.path.getsize(proj) > 1000, f"project saved ({os.path.getsize(proj)} bytes)")
check(os.path.getsize(out) > 1000, f"export written ({os.path.getsize(out)} bytes)")
check(os.path.getsize(png) > 1000, f"frame written ({os.path.getsize(png)} bytes)")

# PNG header + dimensions (IHDR)
raw = open(png, "rb").read()
check(raw[:8] == b"\x89PNG\r\n\x1a\n", "PNG signature")
w, h = struct.unpack(">II", raw[16:24])
check((w, h) == (320, 180), f"PNG is 320x180 ({w}x{h})")

# MP4: ftyp box + mvhd duration ~2 s
raw = open(out, "rb").read()
check(b"ftyp" in raw[:16], "MP4 container (ftyp)")
pos, mvhd = 0, None
while pos + 8 <= len(raw):
    size = int.from_bytes(raw[pos:pos+4], "big")
    kind = raw[pos+4:pos+8]
    if size == 1:
        size = int.from_bytes(raw[pos+8:pos+16], "big"); body = pos + 16
    else:
        body = pos + 8
    if kind == b"moov":
        inner = body
        while inner + 8 <= pos + size:
            s2 = int.from_bytes(raw[inner:inner+4], "big")
            if raw[inner+4:inner+8] == b"mvhd":
                mvhd = inner + 8; break
            inner += s2
        break
    if size <= 0: break
    pos += size
check(mvhd is not None, "MP4 has moov/mvhd")
ver = raw[mvhd]
if ver == 1:
    ts = int.from_bytes(raw[mvhd+20:mvhd+24], "big"); dur = int.from_bytes(raw[mvhd+24:mvhd+32], "big")
else:
    ts = int.from_bytes(raw[mvhd+12:mvhd+16], "big"); dur = int.from_bytes(raw[mvhd+16:mvhd+20], "big")
secs = dur / ts if ts else 0
check(1.9 <= secs <= 2.1, f"MP4 duration {secs:.3f}s (timescale {ts})")

print("SMOKE OK")
PY
