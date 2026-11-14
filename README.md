# Ado Cursor for Omarchy — Free Edition (`Ado-by-Martk-Free`)

A ready-to-install Linux Xcursor port of **Ado cursor by Martk [FREE]**, configured specifically for [Omarchy](https://omarchy.org/) (Hyprland + GTK + XWayland).

> [!IMPORTANT]
> ### Support the Artist — Get the Full Animated Premium Pack!
> This repository packages the **Free Edition** of Martk's Ado cursor set (which includes 2 animated cursors and 13 static cursors).
>
> If you love how this cursor looks on your desktop, **please support the original artist by purchasing the [Original Premium Fully Animated Version on Ko-fi](https://ko-fi.com/s/349091ba4e)**! The premium Windows release features **full custom animations across the entire cursor set** with even more personality and detail crafted by Martk.
>
> **[Buy the Full Animated Ado Cursor by Martk on Ko-fi →](https://ko-fi.com/s/349091ba4e)**

---

## Features

- **A Taste of the Full Set (2 Animated + 13 Crisp Static Cursors)**:
  - 4-frame animated `wait` (`Ocupado.ani`) and `progress` (`Trabajando en segundo plano.ani`).
  - Static pixel-art cursors for `default`, `text`, `pointer`, `help`, `not-allowed`, `crosshair`, `pencil`, `up-arrow`, `move`, and `*-resize` *(want every state fully animated? Check out the [Premium Edition on Ko-fi](https://ko-fi.com/s/349091ba4e))*.
- **Crisp Pixel Art at Any Scale**: Includes pre-built Xcursor sizes (`24`, `30`, `32`, `36`, `40`, `48`, `64`, `96`) with aligned hotspots.
- **Reliable Auto-Hide**: Configures `hide_on_key_press = true`, `inactive_timeout = 3`, and `no_hardware_cursors = 1` (software cursor mode) so cursors stay hidden while typing or idle without reappearing.
- **Safe Omarchy Integration**: Installs into `~/.local/share/icons/Ado-by-Martk-Free`, backs up `~/.config/hypr/looknfeel.lua` before adding cursor settings, and applies immediately without logging out.

---

## Quick Install

### Option 1: Clone & Run
```bash
git clone https://github.com/raktimrabha/ado-cursor-omarchy-free.git
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

## Credits & Support the Creator

- **Original Artwork & Animation**: Created by **Martk** (`@MARTK_MARTK`).
- **Love this cursor?** Don't miss out on the complete experience! Grab the **[Original Premium Fully Animated Version for Windows on Ko-fi](https://ko-fi.com/s/349091ba4e)** to unlock all animations and directly support Martk's artwork.
