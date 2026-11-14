#!/usr/bin/env bash
set -euo pipefail

THEME_NAME="Ado-by-Martk-Free"
DEFAULT_SIZE="24"

strip_marked_block() {
  local file="$1"
  local start_re="$2"
  local end_re="$3"
  local tmp
  tmp="$(mktemp)"
  awk -v s="$start_re" -v e="$end_re" '
    $0 ~ s { skip=1; next }
    skip && $0 ~ e { skip=0; next }
    !skip { print }
  ' "$file" > "$tmp"
  mv "$tmp" "$file"
}

echo "Uninstalling ${THEME_NAME} cursor theme..."

rm -rf "$HOME/.local/share/icons/$THEME_NAME" "$HOME/.icons/$THEME_NAME"
rm -f "$HOME/.local/share/icons/default/index.theme" "$HOME/.icons/default/index.theme"

LOOKNFEEL="$HOME/.config/hypr/looknfeel.lua"
if [[ -f "$LOOKNFEEL" ]]; then
  cp "$LOOKNFEEL" "${LOOKNFEEL}.bak.$(date +%s)"
  strip_marked_block "$LOOKNFEEL" "^-- >>> Ado-by-Martk(-Free)? cursor start >>>" "^-- <<< Ado-by-Martk(-Free)? cursor end <<<"
fi

HYPRCONF="$HOME/.config/hypr/hyprland.conf"
if [[ -f "$HYPRCONF" ]]; then
  cp "$HYPRCONF" "${HYPRCONF}.bak.$(date +%s)"
  strip_marked_block "$HYPRCONF" "^# >>> Ado-by-Martk(-Free)? cursor start >>>" "^# <<< Ado-by-Martk(-Free)? cursor end <<<"
fi

if command -v hyprctl >/dev/null 2>&1 && [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
  hyprctl reload >/dev/null 2>&1 || true
  hyprctl setcursor default "$DEFAULT_SIZE" >/dev/null 2>&1 || true
fi

SWAYCONF="$HOME/.config/sway/config"
if [[ -f "$SWAYCONF" ]]; then
  cp "$SWAYCONF" "${SWAYCONF}.bak.$(date +%s)"
  strip_marked_block "$SWAYCONF" "^# >>> Ado-by-Martk(-Free)? cursor start >>>" "^# <<< Ado-by-Martk(-Free)? cursor end <<<"
fi

if command -v gsettings >/dev/null 2>&1; then
  gsettings set org.gnome.desktop.interface cursor-theme "default" 2>/dev/null || true
  gsettings set org.gnome.desktop.interface cursor-size "$DEFAULT_SIZE" 2>/dev/null || true
fi

if command -v plasma-apply-cursortheme >/dev/null 2>&1; then
  plasma-apply-cursortheme breeze_cursors >/dev/null 2>&1 || true
fi

if command -v xfconf-query >/dev/null 2>&1; then
  xfconf-query -c xsettings -p /Gtk/CursorThemeName -r 2>/dev/null || true
  xfconf-query -c xsettings -p /Gtk/CursorThemeSize -r 2>/dev/null || true
fi

if [[ -f "$HOME/.Xresources" ]]; then
  strip_marked_block "$HOME/.Xresources" "^! >>> Ado-by-Martk(-Free)? cursor start >>>" "^! <<< Ado-by-Martk(-Free)? cursor end <<<"
  if command -v xrdb >/dev/null 2>&1 && [[ -n "${DISPLAY:-}" ]]; then
    xrdb -merge "$HOME/.Xresources" 2>/dev/null || true
  fi
fi

echo "Done! Reverted to default cursor."
