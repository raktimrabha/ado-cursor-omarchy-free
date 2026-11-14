#!/usr/bin/env bash
set -euo pipefail

THEME_NAME="Ado-by-Martk-Free"
CURSOR_SIZE="${1:-32}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing ${THEME_NAME} cursor theme (size ${CURSOR_SIZE})..."

mkdir -p "$HOME/.local/share/icons" "$HOME/.icons" "$HOME/.local/share/icons/default" "$HOME/.icons/default"
rm -rf "$HOME/.local/share/icons/$THEME_NAME"
cp -r "$SCRIPT_DIR/$THEME_NAME" "$HOME/.local/share/icons/$THEME_NAME"
ln -sfn "$HOME/.local/share/icons/$THEME_NAME" "$HOME/.icons/$THEME_NAME"

cat <<EOF | tee "$HOME/.local/share/icons/default/index.theme" "$HOME/.icons/default/index.theme" >/dev/null
[Icon Theme]
Name=Default
Comment=Default Cursor Theme
Inherits=${THEME_NAME}
EOF

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
  cat <<EOF >> "$LOOKNFEEL"

-- >>> Ado-by-Martk-Free cursor start >>>
-- Cursor theme and size (Ado cursor by Martk [Free]).
hl.env("XCURSOR_THEME", "${THEME_NAME}")
hl.env("XCURSOR_SIZE", "${CURSOR_SIZE}")
hl.env("HYPRCURSOR_SIZE", "${CURSOR_SIZE}")

hl.config({
  cursor = {
    hide_on_key_press = true,
    inactive_timeout = 3,
    no_hardware_cursors = 1,
  },
})
-- <<< Ado-by-Martk-Free cursor end <<<
EOF
fi

if command -v hyprctl >/dev/null 2>&1; then
  hyprctl reload >/dev/null 2>&1 || true
  hyprctl setcursor "$THEME_NAME" "$CURSOR_SIZE" >/dev/null 2>&1 || true
fi

if command -v gsettings >/dev/null 2>&1; then
  gsettings set org.gnome.desktop.interface cursor-theme "$THEME_NAME" 2>/dev/null || true
  gsettings set org.gnome.desktop.interface cursor-size "$CURSOR_SIZE" 2>/dev/null || true
fi

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
  dbus-update-activation-environment --systemd \
    "XCURSOR_THEME=${THEME_NAME}" \
    "XCURSOR_SIZE=${CURSOR_SIZE}" \
    "HYPRCURSOR_SIZE=${CURSOR_SIZE}" 2>/dev/null || true
fi

echo "Done! ${THEME_NAME} is now active."
