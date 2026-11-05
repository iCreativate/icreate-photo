#!/usr/bin/env bash
# Regenerate every app icon from docs/brand/icreate-mark.svg (the iCreate leaping figure).
#
# Needs: resvg (brew install resvg / cargo install resvg). On macOS, iconutil also writes the
# .icns. The outputs are committed, so packaging never needs these tools.
#
#   packaging/icons.sh
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIR="$ROOT/assets/app-icon"
BRAND="$ROOT/docs/brand"
SVG="$BRAND/icreate-mark.svg"
ID="za.co.icreativate.icreate-photo"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

command -v resvg >/dev/null || { echo "error: resvg not found (brew install resvg)" >&2; exit 1; }

BOX='viewBox="0 0 512 512"'
grep -q "$BOX" "$SVG" || { echo "error: expected $BOX in $SVG" >&2; exit 1; }
MAC="$TMP/mac.svg"
# Extra transparent margin for Apple's 824/1024 icon grid.
sed "s/$BOX/viewBox=\"-48 -48 608 608\"/" "$SVG" >"$MAC"
FLAT="$SVG"

render() { resvg -w "$2" -h "$2" "$1" "$3" </dev/null; }

render "$MAC" 1024 "$DIR/photocraft-1024.png"
cp "$SVG" "$DIR/photocraft.svg"
cp "$SVG" "$DIR/photocraft-small.svg"
cp "$SVG" "$DIR/icreate-photo.svg"

for s in 16 24 32 48 64 128 256 512; do
  mkdir -p "$DIR/hicolor/${s}x${s}/apps"
  render "$FLAT" "$s" "$DIR/hicolor/${s}x${s}/apps/$ID.png"
done
mkdir -p "$DIR/hicolor/scalable/apps"
cp "$SVG" "$DIR/hicolor/scalable/apps/$ID.svg"

ICO_PNGS=()
for s in 16 20 24 32 40 48 64 128 256; do
  render "$FLAT" "$s" "$TMP/ico-$s.png"
  ICO_PNGS+=("$TMP/ico-$s.png")
done
(cd "$ROOT" && cargo run -q -p xtask -- ico "$DIR/photocraft.ico" "${ICO_PNGS[@]}")

if command -v iconutil >/dev/null; then
  SET="$TMP/photocraft.iconset"
  mkdir -p "$SET"
  for s in 16 32 128 256 512; do
    render "$MAC" "$s" "$SET/icon_${s}x${s}.png"
    render "$MAC" $((s * 2)) "$SET/icon_${s}x${s}@2x.png"
  done
  iconutil -c icns -o "$DIR/photocraft.icns" "$SET"
else
  echo "warning: iconutil not found (macOS only); photocraft.icns not regenerated" >&2
fi
echo "icons written to $DIR"
