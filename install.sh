#!/bin/bash
# Instala o reinstala Mas+:
#   curl -fsSL https://raw.githubusercontent.com/frangoulu/mas-releases/main/install.sh | bash
set -euo pipefail

URL="https://github.com/frangoulu/mas-releases/releases/latest/download/Mas.zip"
DEST="/Applications"
[[ -w "$DEST" ]] || DEST="$HOME/Applications"
mkdir -p "$DEST"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "Descargando Mas+…"
curl -fsSL "$URL" -o "$TMP/Mas.zip"
ditto -x -k "$TMP/Mas.zip" "$TMP"

pkill -x Mas 2>/dev/null || true
rm -rf "$DEST/Mas.app"
mv "$TMP/Mas.app" "$DEST/Mas.app"

echo "Listo: Mas+ quedó en $DEST. Abriendo…"
open "$DEST/Mas.app"
