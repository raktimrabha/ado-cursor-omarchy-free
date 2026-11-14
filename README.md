# Ado Cursor for Omarchy - Free Linux Edition [`by Martk`](https://ko-fi.com/martk_martk)

## Support the Original Artist - Get the Full Animated Version!

Every pixel of this cursor pack was lovingly crafted by **Martk [`@MARTK_MARTK`](https://ko-fi.com/martk_martk)**. This repository only packages the **[Free Windows Edition](https://ko-fi.com/s/274fde222e)** converted for Linux — which gives you just a small preview of the artwork (only **2 animated cursors** and 13 static ones).

If you enjoy having Ado on your desktop, **please support Martk directly by buying the [Original Premium Fully Animated Windows Version on Ko-fi](https://ko-fi.com/s/349091ba4e)**!

> [!IMPORTANT]
> ### [Buy the Original Premium Fully Animated Ado Cursor on Ko-fi →](https://ko-fi.com/s/349091ba4e)
> Independent pixel artists rely on community support to keep creating. Buying the official Premium pack directly supports **Martk** and unlocks the **complete, fully animated experience** across the entire cursor set!

| Edition | Animations Included | Official Link |
| :--- | :--- | :--- |
| **Premium Edition (Recommended)** | **Full custom animations across the entire cursor pack** — every state brought to life by Martk | **[Buy Premium on Ko-fi](https://ko-fi.com/s/349091ba4e)** |
| **Free Edition** *(this repo's source)* | **2 animated cursors** (`wait` & `progress`) + 13 static cursors | [Original Free Windows Version on Ko-fi](https://ko-fi.com/s/274fde222e) |

---

## How to Install (Omarchy / Linux Free Edition)

> [!NOTE]
> I have only tested this directly on **Omarchy** (Hyprland), though `install.sh` auto-detects Hyprland, Sway, GNOME, KDE Plasma, XFCE, GTK, and X11 and should work on most Linux distros.

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

### Uninstall
To remove the cursor theme and restore your default cursor:
```bash
./uninstall.sh
```

---

## Features of This Linux Package

- **Free Edition Port (2 Animated + 13 Crisp Static Cursors)**:
  - 4-frame animated `wait` (`Ocupado.ani`) and `progress` (`Trabajando en segundo plano.ani`).
  - Static pixel-art cursors for `default`, `text`, `pointer`, `help`, `not-allowed`, `crosshair`, `pencil`, `up-arrow`, `move`, and `*-resize` *(want every cursor state fully animated? Grab [Martk's Premium Edition on Ko-fi](https://ko-fi.com/s/349091ba4e))*.
- **Crisp Pixel Art at Any Scale**: Includes pre-built Xcursor sizes (`24`, `30`, `32`, `36`, `40`, `48`, `64`, `96`) with aligned hotspots.
- **Auto-Detecting Linux Installer**: Installs into `~/.local/share/icons/Ado-by-Martk-Free` and automatically configures your detected desktop/compositor (Omarchy, Hyprland, Sway, GNOME/GTK, KDE Plasma, XFCE, or X11).
- **Reliable Auto-Hide (Omarchy / Hyprland)**: Configures `hide_on_key_press = true`, `inactive_timeout = 3`, and `no_hardware_cursors = 1` (software cursor mode) so cursors stay hidden while typing or idle without reappearing.

---

## Credits

- **Original Artist & Creator**: **Martk** [`@MARTK_MARTK`](https://ko-fi.com/martk_martk)
- **[Buy the Original Premium Fully Animated Windows Version (Ko-fi)](https://ko-fi.com/s/349091ba4e)**
- [Original Free Windows Version (Ko-fi)](https://ko-fi.com/s/274fde222e)
