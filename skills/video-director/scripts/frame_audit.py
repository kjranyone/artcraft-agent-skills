# frame_audit.py - 実行可能な検収ルーブリック (video-director skill)
#
# 使い方:
#   python frame_audit.py --manifest manifest.json --project X.ecproj --mp4 X.mp4 [--frames 24]
#
# 入力: manifest.json(ビルダーが書き出した設計意図) + プロジェクト + mp4
# 検証: 設計意図 vs 実際 をルーブリック(A-E)で判定しレポートを出力
import json, subprocess, sys, os, argparse, tempfile, re

CLI = r"C:\Program Files\EffectCraft\effectcraft-cli.exe"

def vis_windows(okeys):
    if not okeys: return [(0.0, 1e9)]
    ks = sorted(okeys)
    ivs, cur = [], None
    for i, (t, v) in enumerate(ks):
        nv = ks[i + 1][1] if i + 1 < len(ks) else None
        if v > 50 and cur is None: cur = t
        if nv is not None and nv <= 50 and cur is not None:
            ivs.append((cur, nv)); cur = None
    if cur is not None: ivs.append((cur, 1e9))
    return [(s, e) for s, e in ivs if e > s]

def overlap(a, b):
    ix = max(0, min(a[0] + a[2], b[0] + b[2]) - max(a[0], b[0]))
    iy = max(0, min(a[1] + a[3], b[1] + b[3]) - max(a[1], b[1]))
    return ix * iy

def jp_width(text, size):
    return sum(size * (0.5 if ch == " " else 1.0 if ord(ch) > 0x2E80 else 0.55) for ch in text)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--manifest", default="manifest.json")
    ap.add_argument("--project", required=True)
    ap.add_argument("--mp4", default=None)
    ap.add_argument("--frames", type=int, default=24)
    a = ap.parse_args()

    report, fails, warns = [], 0, 0
    def emit(sev, cid, msg):
        nonlocal fails, warns
        if sev == "FAIL": fails += 1
        elif sev == "WARN": warns += 1
        report.append(f"[{sev}] {cid}: {msg}")

    man = json.load(open(a.manifest, encoding="utf-8"))
    texts = []
    for t in man["texts"]:
        t["windows"] = vis_windows(t.get("okeys"))
        texts.append(t)

    for t in texts:
        if t["text"].strip() in ("", "テキスト", "Text", "Sample Text", "プレースホルダ"):
            emit("FAIL", "C1", f"プレースホルダテキスト: {t['name']} = {t['text']!r}")
        if (t["size"] or 0) < 22:
            emit("FAIL", "B2", f"文字サイズ不足: {t['name']} = {t['size']}px")
        for (s, e) in t["windows"]:
            if e < 1e8 and (e - s) < 0.8:
                emit("FAIL", "B3", f"可視時間不足: {t['name']} {s:.2f}-{e:.2f}s ({e-s:.2f}s)")

    for t in texts:
        for (s, e) in t["windows"]:
            w = jp_width(t["text"], t["size"])
            h = t["size"] * 1.25
            x = t["x"] - (0 if t.get("justify") == "left" else w / 2)
            y = t["y"] - h * 0.45
            out = max(0, -x) + max(0, x + w - 1920) + max(0, -y) + max(0, y + h - 1080)
            if out > 0.05 * (w + h):
                emit("FAIL", "A1", f"フレーム外見切れ: {t['name']} ({x:.0f},{y:.0f}) サイズ{w:.0f}x{h:.0f} はみ出し{out:.0f}px")

    core = [t for t in texts if not t["name"].endswith("_bg")]
    for i in range(len(core)):
        for j in range(i + 1, len(core)):
            ta, tb = core[i], core[j]
            for (sa, ea) in ta["windows"]:
                for (sb, eb) in tb["windows"]:
                    lo, hi = max(sa, sb), min(ea, eb)
                    if hi - lo <= 0.05: continue
                    wa, ha = jp_width(ta["text"], ta["size"]), ta["size"] * 1.25
                    wb, hb = jp_width(tb["text"], tb["size"]), tb["size"] * 1.25
                    ax = ta["x"] - (0 if ta.get("justify") == "left" else wa / 2)
                    bx = tb["x"] - (0 if tb.get("justify") == "left" else wb / 2)
                    ov = overlap((ax, ta["y"] - ha * 0.4, wa, ha), (bx, tb["y"] - hb * 0.4, wb, hb))
                    if ov > 0.10 * min(wa * ha, wb * hb) and ov > 4000:
                        emit("FAIL", "B1", f"テキスト重なり: {ta['name']} × {tb['name']} @ {lo:.2f}-{hi:.2f}s")

    if texts:
        centered = sum(1 for t in texts if abs(t["x"] - 960) < 8)
        if centered / len(texts) > 0.7:
            emit("WARN", "C3", f"中央揃えの単調さ: {centered}/{len(texts)} が x=960")

    outdir = tempfile.mkdtemp(prefix="audit_frames_")
    frame_paths = []
    for i in range(a.frames):
        t = round((i + 0.5) * 30.0 / a.frames, 3)
        fp = os.path.join(outdir, f"f{i:03d}.png")
        subprocess.run([CLI, "--project", a.project, "render-frame", "--out", fp, "--time", str(t)],
                       capture_output=True, text=True)
        if os.path.exists(fp): frame_paths.append((t, fp))

    for (t1, f1), (t2, f2) in zip(frame_paths, frame_paths[1:]):
        r = subprocess.run(["magick", "compare", "-metric", "RMSE", f1, f2, "null:"],
                           capture_output=True, text=True)
        m = re.search(r"\(([\d.]+)\)", r.stderr or "")
        rmse = float(m.group(1)) if m else 1.0
        if rmse < 0.004:
            emit("FAIL", "D1", f"静止フレーム: {t1:.2f}-{t2:.2f}s RMSE={rmse:.4f}")

    for t, fp in frame_paths[:12]:
        full = subprocess.run(["magick", fp, "-colorspace", "gray", "-format", "%[fx:mean]", "info:"],
                              capture_output=True, text=True).stdout.strip()
        try: wm = float(full)
        except: continue
        for edge, crop in (("L", "3x1080+0+0"), ("R", "3x1080+1917+0"), ("T", "1920x3+0+0"), ("B", "1920x3+0+1077")):
            r = subprocess.run(["magick", fp, "-crop", crop, "-colorspace", "gray",
                                "-format", "%[fx:mean]", "info:"], capture_output=True, text=True)
            try: v = float(r.stdout.strip())
            except: continue
            if abs(v - wm) > 0.25:
                emit("INFO", "A3", f"縁にコンテンツ: t={t}s {edge}縁 (辺{v:.2f} vs 全面{wm:.2f}) - 意図的ブリードなら免除")
                break

    if a.mp4:
        if os.path.exists(a.mp4):
            emit("INFO", "E2", f"MP4 {os.path.getsize(a.mp4)/1e6:.1f}MB")
        else:
            emit("FAIL", "E1", f"MP4が存在しない: {a.mp4}")

    print("=" * 62)
    print("FRAME AUDIT REPORT -", a.project)
    print("=" * 62)
    for line in report: print(line)
    print("-" * 62)
    print(f"FAIL: {fails} / WARN: {warns} / logged: {len(report)}")
    sys.exit(1 if fails else 0)

if __name__ == "__main__":
    main()
