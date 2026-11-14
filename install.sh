#!/usr/bin/env bash
set -euo pipefail

THEME_NAME="Ado-by-Martk-Free"
CURSOR_SIZE="${1:-32}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

upsert_ini_key() {
  local file="$1"
  local section="$2"
  local key="$3"
  local val="$4"
  mkdir -p "$(dirname "$file")"
  [[ -f "$file" ]] || printf "[%s]\n" "$section" > "$file"
  local tmp
  tmp="$(mktemp)"
  awk -v sec="[$section]" -v k="$key" -v v="$val" '
    BEGIN { in_sec=0; found=0; has_sec=0 }
    /^\[.*\]/ {
      if (in_sec && !found) { print k "=" v; found=1 }
      in_sec = ($0 == sec)
      if (in_sec) has_sec=1
    }
    in_sec && $0 ~ "^" k "=" { print k "=" v; found=1; next }
    { print }
    END {
      if (!has_sec) { print ""; print sec; print k "=" v }
      else if (in_sec && !found) { print k "=" v }
    }
  ' "$file" > "$tmp"
  mv "$tmp" "$file"
}

echo "Installing ${THEME_NAME} cursor theme (size ${CURSOR_SIZE})..."

# 1. Install Xcursor theme files (works on all Linux distros)
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

# 2. Omarchy (looknfeel.lua) or plain Hyprland (hyprland.conf)
LOOKNFEEL="$HOME/.config/hypr/looknfeel.lua"
HYPRCONF="$HOME/.config/hypr/hyprland.conf"

if [[ -f "$LOOKNFEEL" ]]; then
  cp "$LOOKNFEEL" "${LOOKNFEEL}.bak.$(date +%s)"
  strip_marked_block "$LOOKNFEEL" "^-- >>> Ado-by-Martk(-Free)? cursor start >>>" "^-- <<< Ado-by-Martk(-Free)? cursor end <<<"
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
elif [[ -f "$HYPRCONF" ]]; then
  cp "$HYPRCONF" "${HYPRCONF}.bak.$(date +%s)"
  strip_marked_block "$HYPRCONF" "^# >>> Ado-by-Martk(-Free)? cursor start >>>" "^# <<< Ado-by-Martk(-Free)? cursor end <<<"
  cat <<EOF >> "$HYPRCONF"

# >>> Ado-by-Martk-Free cursor start >>>
env = XCURSOR_THEME,${THEME_NAME}
env = XCURSOR_SIZE,${CURSOR_SIZE}
env = HYPRCURSOR_SIZE,${CURSOR_SIZE}

cursor {
  no_hardware_cursors = 1
}
# <<< Ado-by-Martk-Free cursor end <<<
EOF
fi

if command -v hyprctl >/dev/null 2>&1 && [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
  hyprctl reload >/dev/null 2>&1 || true
  hyprctl setcursor "$THEME_NAME" "$CURSOR_SIZE" >/dev/null 2>&1 || true
fi

# 3. Sway
SWAYCONF="$HOME/.config/sway/config"
if [[ -f "$SWAYCONF" ]]; then
  cp "$SWAYCONF" "${SWAYCONF}.bak.$(date +%s)"
  strip_marked_block "$SWAYCONF" "^# >>> Ado-by-Martk(-Free)? cursor start >>>" "^# <<< Ado-by-Martk(-Free)? cursor end <<<"
  cat <<EOF >> "$SWAYCONF"

# >>> Ado-by-Martk-Free cursor start >>>
seat seat0 xcursor_theme ${THEME_NAME} ${CURSOR_SIZE}
# <<< Ado-by-Martk-Free cursor end <<<
EOF
  if command -v swaymsg >/dev/null 2>&1 && [[ -n "${SWAYSOCK:-}" ]]; then
    swaymsg seat seat0 xcursor_theme "$THEME_NAME" "$CURSOR_SIZE" >/dev/null 2>&1 || true
  fi
fi

# 4. GNOME / Cinnamon / MATE / GTK
if command -v gsettings >/dev/null 2>&1; then
  gsettings set org.gnome.desktop.interface cursor-theme "$THEME_NAME" 2>/dev/null || true
  gsettings set org.gnome.desktop.interface cursor-size "$CURSOR_SIZE" 2>/dev/null || true
fi

if [[ -d "$HOME/.config/gtk-3.0" ]] || command -v gtk3-launch >/dev/null 2>&1; then
  upsert_ini_key "$HOME/.config/gtk-3.0/settings.ini" "Settings" "gtk-cursor-theme-name" "$THEME_NAME"
  upsert_ini_key "$HOME/.config/gtk-3.0/settings.ini" "Settings" "gtk-cursor-theme-size" "$CURSOR_SIZE"
fi
if [[ -d "$HOME/.config/gtk-4.0" ]]; then
  upsert_ini_key "$HOME/.config/gtk-4.0/settings.ini" "Settings" "gtk-cursor-theme-name" "$THEME_NAME"
  upsert_ini_key "$HOME/.config/gtk-4.0/settings.ini" "Settings" "gtk-cursor-theme-size" "$CURSOR_SIZE"
fi

# 5. KDE Plasma
if command -v plasma-apply-cursortheme >/dev/null 2>&1; then
  plasma-apply-cursortheme "$THEME_NAME" >/dev/null 2>&1 || true
fi
if command -v kwriteconfig6 >/dev/null 2>&1; then
  kwriteconfig6 --file kcminputrc --group Mouse --key cursorTheme "$THEME_NAME" 2>/dev/null || true
  kwriteconfig6 --file kcminputrc --group Mouse --key cursorSize "$CURSOR_SIZE" 2>/dev/null || true
elif command -v kwriteconfig5 >/dev/null 2>&1; then
  kwriteconfig5 --file kcminputrc --group Mouse --key cursorTheme "$THEME_NAME" 2>/dev/null || true
  kwriteconfig5 --file kcminputrc --group Mouse --key cursorSize "$CURSOR_SIZE" 2>/dev/null || true
fi

# 6. XFCE
if command -v xfconf-query >/dev/null 2>&1; then
  xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "$THEME_NAME" 2>/dev/null || true
  xfconf-query -c xsettings -p /Gtk/CursorThemeSize -s "$CURSOR_SIZE" 2>/dev/null || true
fi

# 7. X11 (~/.Xresources)
if [[ -f "$HOME/.Xresources" ]] || [[ -n "${DISPLAY:-}" ]]; then
  touch "$HOME/.Xresources"
  strip_marked_block "$HOME/.Xresources" "^! >>> Ado-by-Martk(-Free)? cursor start >>>" "^! <<< Ado-by-Martk(-Free)? cursor end <<<"
  cat <<EOF >> "$HOME/.Xresources"

! >>> Ado-by-Martk-Free cursor start >>>
Xcursor.theme: ${THEME_NAME}
Xcursor.size: ${CURSOR_SIZE}
! <<< Ado-by-Martk-Free cursor end <<<
EOF
  if command -v xrdb >/dev/null 2>&1 && [[ -n "${DISPLAY:-}" ]]; then
    xrdb -merge "$HOME/.Xresources" 2>/dev/null || true
  fi
fi

# 8. systemd / D-Bus environment
if command -v dbus-update-activation-environment >/dev/null 2>&1; then
  dbus-update-activation-environment --systemd \
    "XCURSOR_THEME=${THEME_NAME}" \
    "XCURSOR_SIZE=${CURSOR_SIZE}" \
    "HYPRCURSOR_SIZE=${CURSOR_SIZE}" 2>/dev/null || true
fi

echo "Done! ${THEME_NAME} is now active."
