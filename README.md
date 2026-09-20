# Dotfiles

> *Please make my life easier.*

A reproducible, Hyprland-based Arch Linux developer environment.

## Features & Components

* **Window Manager:** [Hyprland](https://hyprland.org/)
* **Status Bar:** [Waybar](https://github.com/Alexays/Waybar)
* **Terminal Emulator:** [Kitty](https://sw.kovidgoyal.net/kitty/)
* **Terminal Multiplexer:** [Zellij](https://zellij.dev/)
* **Shell:** [Zsh](https://www.zsh.org/) customized with [Starship](https://starship.rs/) prompt, `fzf`, `eza`, and [Atuin](https://atuin.sh/) shell history.
* **Text Editor:** [Neovim](https://neovim.io/) (configured via Lua with `lazy.nvim`)
* **Application Launcher:** [Rofi](https://github.com/lbonn/rofi) (`rofi-wayland`, drun + dmenu)
* **Workflow Automation:** Includes a custom Zellij `sessionizer` script (in `config/zsh/`) for rapidly jumping between isolated project environments.

## Installation

### 1. Pre-requisites (Pacman Setup)
Ensure your package manager is initialized and up to date:
```bash
sudo pacman -Sy
sudo pacman-key --init
sudo pacman-key --populate
```

### 2. Clone the Repository
*Make sure you have your SSH keys set up for GitHub before cloning.*
```bash
git clone git@github.com:betrayed/dotfiles.git ~/sarcophagus/dotfiles
cd ~/sarcophagus/dotfiles
```

### 3. Run the Installer
The automated `install` script will process the package lists (`pacman`, `yay`, `npm`), install dependencies, and setup symlinks to `~/.config/`:
```bash
cd install
bash install.sh
```

## Repository Structure

* `config/` - Application configurations intended to be linked into `~/.config/` (Hyprland, Waybar, Nvim, Zellij, etc.).
* `install/` - Package manifests (`packages_pacman.txt`, `packages_yay.txt`, `packages_npm.txt`) and the main bootstrapper script.
* `config/scripts/` - System menu hub (`config/menu/main`) and shared scripts (`bluetooth`, `network`, `wallpaper_picker`, `reload`, `screenshot`, `scratch`, `volume`).
* `system/` - Custom systemd services (e.g., `docker-notify`, `ssh-agent`).
* `wallpapers/` - Wallpaper images, copied to `~/wallpapers` during install.
