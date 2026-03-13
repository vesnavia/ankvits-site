#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

if ! command -v sips >/dev/null 2>&1; then
  echo "Error: 'sips' is required but not found." >&2
  exit 1
fi

log() {
  printf '[images] %s\n' "$1"
}

get_width() {
  local input_path="$1"
  local width
  width="$(sips -g pixelWidth "$input_path" 2>/dev/null | awk '/pixelWidth/ {print int($2); exit}' || true)"
  if [[ -z "$width" ]]; then
    width=0
  fi
  printf '%s' "$width"
}

build_jpeg_set() {
  local input_path="$1"
  local output_dir="$2"
  local output_stem="$3"
  local quality="$4"
  shift 4
  local widths=("$@")

  if [[ ! -f "$input_path" ]]; then
    log "Skip missing: $input_path"
    return
  fi

  mkdir -p "$output_dir"

  local source_width
  source_width="$(get_width "$input_path")"
  local generated=0

  for width in "${widths[@]}"; do
    if [[ "$source_width" -gt 0 && "$width" -gt "$source_width" ]]; then
      continue
    fi

    local output_path="$output_dir/${output_stem}-${width}.jpg"
    sips -s format jpeg -s formatOptions "$quality" --resampleWidth "$width" "$input_path" --out "$output_path" >/dev/null 2>&1
    generated=$((generated + 1))
  done

  if [[ "$generated" -eq 0 ]]; then
    local fallback_width=1600
    if [[ "$source_width" -gt 0 ]]; then
      fallback_width="$source_width"
    fi
    local fallback_path="$output_dir/${output_stem}-${fallback_width}.jpg"
    sips -s format jpeg -s formatOptions "$quality" --resampleWidth "$fallback_width" "$input_path" --out "$fallback_path" >/dev/null 2>&1
  fi
}

log "Generating optimized hero background"
build_jpeg_set \
  "assets/images/butterfly_wing_texture.png" \
  "assets/images/optimized" \
  "hero-bg" \
  "62" \
  768 1280 1920

log "Generating optimized image sets for events/case-2"
for number in $(seq 1 22); do
  build_jpeg_set \
    "cases/events/case-2/${number}.png" \
    "cases/events/case-2/optimized" \
    "$number" \
    "72" \
    640 960 1280
done

log "Generating optimized image sets for ICAC main screens"
build_jpeg_set "cases/design/icac/ICAC CHINA.png" "cases/design/icac/optimized" "china" "72" 640 960 1280 1600
build_jpeg_set "cases/design/icac/ICAC ENGLISH.png" "cases/design/icac/optimized" "english" "72" 640 960 1280 1600
build_jpeg_set "cases/design/icac/structure.png" "cases/design/icac/optimized" "structure" "72" 640 960 1280 1600

log "Generating optimized image sets for ICAC marketing"
for number in $(seq 1 14); do
  build_jpeg_set \
    "cases/design/icac/marketing/${number}.png" \
    "cases/design/icac/marketing/optimized" \
    "$number" \
    "72" \
    640 960 1280
done

log "Generating optimized image sets for Vivi_Riviera"
build_jpeg_set "cases/branding/vivi-riviera/Vivi_Riviera.png" "cases/branding/vivi-riviera/optimized" "vivi-riviera" "70" 640 960 1200

log "Generating optimized image sets for Aris"
build_jpeg_set "cases/design/aris/before.png" "cases/design/aris/optimized" "before" "72" 640 960 1280
build_jpeg_set "cases/design/aris/after.png" "cases/design/aris/optimized" "after" "72" 640 960 1280 1600

log "Done"
