#!/bin/bash
# ============================================================
# YouTube 按章节切割下载脚本
# 用法: bash yt_chapter_split.sh
# 前置: brew install yt-dlp ffmpeg  (如果没装过)
# ============================================================

# === 在这里改 URL ===
URL="https://www.youtube.com/watch?v=kwSVtQ7dziU"

# === 输出目录 ===
OUT_DIR="./chapters"
mkdir -p "$OUT_DIR"

# === 下载并按章节切割成 mp3 ===
TMPFILE=$(mktemp /tmp/yt_full_XXXXXX)
yt-dlp \
  -x \
  --audio-format mp3 \
  --audio-quality 0 \
  --split-chapters \
  --restrict-filenames \
  -o "$TMPFILE.%(ext)s" \
  -o "chapter:${OUT_DIR}/%(section_number)03d_%(section_title)s.%(ext)s" \
  "$URL"

# 清理完整文件
rm -f "$TMPFILE" "$TMPFILE".*

echo ""
echo "=== 完成！文件在 ${OUT_DIR}/ 目录下 ==="
echo ""
ls -1 "$OUT_DIR"
echo ""
echo "下一步：全选文件 → AirDrop 到 iPhone → VLC 打开播放"
