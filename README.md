# Ado Cursor for Omarchy — Free Edition (`Ado-by-Martk-Free`)

A ready-to-install Linux Xcursor package of **Ado cursor by Martk [FREE]** configured specifically for [Omarchy](https://omarchy.org/) (Hyprland + GTK + XWayland).

## Features

- **2 Animated Cursors + 13 Crisp Static Pixel-Art Cursors**:
  - 4-frame animated `wait` (`Ocupado.ani`) and `progress` (`Trabajando en segundo plano.ani`).
  - Static pixel-art cursors for `default`, `text`, `pointer`, `help`, `not-allowed`, `crosshair`, `pencil`, `up-arrow`, `move`, and `*-resize`.
- **Crisp Pixel Art at Any Scale**: Includes pre-built Xcursor sizes (`24`, `30`, `32`, `36`, `40`, `48`, `64`, `96`) with aligned hotspots.
- **Reliable Auto-Hide**: Configures `hide_on_key_press = true`, `inactive_timeout = 3`, and `no_hardware_cursors = 1` (software cursor mode) so cursors stay hidden while typing or idle without reappearing.
- **Safe Omarchy Integration**: Installs into `~/.local/share/icons/Ado-by-Martk-Free`, backs up `~/.config/hypr/looknfeel.lua` before adding cursor settings, and applies immediately without logging out.

---

## Quick Install

### Option 1: Clone & Run
```bash
git clone <your-repo-url> ado-cursor-omarchy-free
cd ado-cursor-omarchy-free
./install.sh
```

### Option 2: From Archive (`.tar.gz`)
```bash
tar -xzf ado-cursor-omarchy-free.tar.gz
cd ado-cursor-omarchy-free
./install.sh
```

### Custom Cursor Size
By default, `install.sh` sets cursor size `32` (matching the native 32×32 pixel-art grid). You can pass a custom size (`24`, `32`, `48`, `64`):
```bash
./install.sh 24
```

---

## Uninstall

To remove the cursor theme and restore Omarchy's default cursor:
```bash
./uninstall.sh
```

---

## Credits

- Original cursor artwork by **Martk** (`@MARTK_MARTK`).
