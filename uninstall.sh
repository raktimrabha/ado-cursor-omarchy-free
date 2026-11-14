#!/usr/bin/env bash
set -euo pipefail

THEME_NAME="Ado-by-Martk-Free"
DEFAULT_SIZE="24"

echo "Uninstalling ${THEME_NAME} cursor theme..."

rm -rf "$HOME/.local/share/icons/$THEME_NAME" "$HOME/.icons/$THEME_NAME"
rm -f "$HOME/.local/share/icons/default/index.theme" "$HOME/.icons/default/index.theme"

LOOKNFEEL="$HOME/.config/hypr/looknfeel.lua"
if [[ -f "$LOOKNFEEL" ]]; then
  cp "$LOOKNFEEL" "${LOOKNFEEL}.bak.$(date +%s)"
  python3 - "$LOOKNFEEL" <<'PY'
import re, sys
p = sys.argv[1]
txt = open(p, "r", encoding="utf-8").read()
txt = re.sub(r"\n?-- >>> Ado-by-Martk(?:-Free)? cursor start >>>.*?-- <<< Ado-by-Martk(?:-Free)? cursor end <<<\n?", "\n", txt, flags=re.S)
txt = re.sub(r"\n?-- Cursor theme and size \(Ado cursor by Martk(?:\s*\[Free\])?\)\.\n.*?^\}\)\n?", "\n", txt, flags=re.S | re.M)
open(p, "w", encoding="utf-8").write(txt.rstrip() + "\n")
PY
fi

if command -v hyprctl >/dev/null 2>&1; then
  hyprctl reload >/dev/null 2>&1 || true
  hyprctl setcursor default "$DEFAULT_SIZE" >/dev/null 2>&1 || true
fi

if command -v gsettings >/dev/null 2>&1; then
  gsettings set org.gnome.desktop.interface cursor-theme "default" 2>/dev/null || true
  gsettings set org.gnome.desktop.interface cursor-size "$DEFAULT_SIZE" 2>/dev/null || true
fi

echo "Done! Reverted to default cursor."
