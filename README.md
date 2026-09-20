# Dotfiles

> *Please make my life easier.*

A reproducible, Hyprland-based Arch Linux developer environment.

## Features & Components

* **Window Manager:** [Hyprland](https://hyprland.org/) (Lua config via `hyprland.lua` + `modules/`)
* **Status Bar:** [Waybar](https://github.com/Alexays/Waybar) (modular `config.jsonc` + per-module `modules/*.jsonc`)
* **Terminal Emulator:** [Kitty](https://sw.kovidgoyal.net/kitty/)
* **Terminal Multiplexer:** [Zellij](https://zellij.dev/)
* **Shell:** [Zsh](https://www.zsh.org/) with [Starship](https://starship.rs/) prompt, `fzf`, `eza`, and [Atuin](https://atuin.sh/) history
* **Text Editor:** [Neovim](https://neovim.io/) (Lua + `lazy.nvim`, see `config/nvim/`)
* **Application Launcher / System Menu:** [Rofi](https://github.com/lbonn/rofi) (`rofi-wayland`) driven by `config/menu/main`
* **Notifications:** `dunst`
* **Wallpaper Daemon:** `hyprpaper`
* **Workflow Automation:** Zellij `sessionizer` (`config/zsh/sessionizer.sh`, `Ctrl-A`) for jumping between project repos
* **Scratchpads & Helpers:** `config/scripts/{scratch,screenshot,wallpaper_picker,reload}`

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

Note: `install/install` expects the repo at `~/dev/dotfiles` (`DOTFILES_REPO="$HOME/dev/dotfiles"`).
Clone there, or edit `DOTFILES_REPO` in `install/install` first:

```bash
git clone git@github.com:betrayed/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
```

### 3. Run the Installer

The `install/install` script installs package lists (`packages_pacman.txt`, `packages_yay.txt`,
`packages_npm.txt`), removes `unnecessary_packages.txt`, enables services, and symlinks
`config/*` into `~/.config/`:

```bash
cd install
bash install
```

What it does, in order (`main()` in `install/install`):

1. `setup_system_basics`
2. `install_core_packages` (`packages_pacman.txt`)
3. `setup_docker` (adds user to `docker` group, enables service)
4. `enable_system_services` (bluetooth)
5. `set_default_shell` (chsh to zsh)
6. `install_yay_helper` + `install_aur_packages` (`packages_yay.txt`)
7. `install_npm` (nvm + node 22) + `install_npm_packages` (`packages_npm.txt`)
8. `setup_user_services` (symlinks + enables `docker-notify`, `ssh-agent`, `ssh-add`, `waybar`, `hyprland-session.target`)
9. `setup_dotfiles` (symlinks every `config/<app>` to `~/.config/<app>`, copies `wallpapers/` to `~/wallpapers/`)

To add/remove software, edit the `install/packages_*.txt` files and re-run the relevant step.

### 4. Apply Changes

After editing configs in this repo, they are live via the symlinks. Reload without logging out:

```bash
~/.config/scripts/reload
```

This runs `hyprctl reload`, restarts `waybar.service`, and reloads dunst.

## Repository Structure

```text
.
├── config/
│   ├── atuin/config.toml
│   ├── btop/btop.conf + themes/rose-pine.theme
│   ├── dunst/dunstrc
│   ├── hypr/
│   │   ├── hyprland.lua            # entry point, requires modules/*
│   │   ├── hyprpaper.conf          # current wallpaper (auto-updated by wallpaper_picker)
│   │   └── modules/
│   │       ├── appearance.lua      # gaps, borders, blur, animations, layouts
│   │       ├── autostart.lua       # hyprland-session.target + hyprpaper
│   │       ├── env.lua             # XCURSOR_SIZE, HYPRCURSOR_SIZE
│   │       ├── input.lua           # kb_layout, kb_options, touchpad, gestures
│   │       ├── keybinds.lua        # ALL keybind variables + hl.bind calls
│   │       ├── monitors.lua        # outputs, scaling, workspace→monitor mapping
│   │       ├── settings.lua        # shared programs (terminal, browser, fileManager)
│   │       └── window-rules.lua    # per-app workspace, float, size rules
│   ├── kitty/kitty.conf + rose-pine.conf
│   ├── menu/main                   # rofi system-menu hub (apps, power, bt, wallpaper, scratchpads)
│   ├── nvim/ (init.lua, lua/set.lua, lua/vanilla_keymaps.lua, lua/plugins/*)
│   ├── rofi/config.rasi + theme.rasi
│   ├── scripts/{reload,scratch,screenshot,wallpaper_picker}
│   ├── starship/starship.toml
│   ├── systemd/user/{hyprland-session.target,waybar.service,ssh-agent.service,ssh-add.service,docker-notify.service}
│   │   └── scripts/docker_notify.sh
│   ├── waybar/
│   │   ├── config.jsonc            # bar layout (modules-left/right)
│   │   ├── modules/*.jsonc + modules/hyprland/*.jsonc + modules/custom/*.jsonc
│   │   ├── scripts/{bluetooth,network,volume}
│   │   └── style.css + styles/{dividers,modules,states,fonts/*,themes/rose-pine.css}
│   ├── zellij/config.kdl + themes/rose-pine.kdl
│   └── zsh/
│       ├── .zshrc                  # sources ~/.config/zsh/main.zsh
│       ├── main.zsh                # sources modules/*.zsh
│       ├── modules/{aliases,atuin,completions,env,fzf,nvm,package_managers,prompt,sessionizer}.zsh
│       └── sessionizer.sh          # fzf repo picker, bound to Ctrl-A
├── install/
│   ├── install                     # bootstrapper (see above)
│   ├── packages_pacman.txt
│   ├── packages_yay.txt
│   ├── packages_npm.txt
│   └── unnecessary_packages.txt
└── wallpapers/*.png|*.jpg          # copied to ~/wallpapers on install
```

## Personalization

Single rule: edit the repo file, the `~/.config` symlink picks it up, then run
`~/.config/scripts/reload` (Hyprland/Waybar) or restart the app.

### Where things are centralized

| Want to change | Edit this file |
| --- | --- |
| Hyprland keybinds (all of them) | `config/hypr/modules/keybinds.lua` — full `b_*` sequences at top |
| Default apps (terminal, browser, file manager) | `config/hypr/modules/settings.lua` |
| Monitors, scale, workspace→monitor | `config/hypr/modules/monitors.lua` |
| Gaps, borders, blur, animations | `config/hypr/modules/appearance.lua` |
| Keyboard layout, touchpad, gestures | `config/hypr/modules/input.lua` |
| Window rules / auto-workspace | `config/hypr/modules/window-rules.lua` |
| Env vars / cursor size | `config/hypr/modules/env.lua` |
| Autostart services | `config/hypr/modules/autostart.lua` + `config/systemd/user/` |
| Wallpaper | `~/wallpapers/` + `config/hypr/hyprpaper.conf` (or run `wallpaper_picker`) |
| Waybar layout | `config/waybar/config.jsonc` (`modules-left` / `modules-right`) |
| Waybar module options | `config/waybar/modules/*.jsonc` |
| Waybar theme | `config/waybar/style.css` + `config/waybar/styles/themes/rose-pine.css` |
| Kitty (font, opacity, tabs) | `config/kitty/kitty.conf`, colors in `config/kitty/rose-pine.conf` |
| Rofi launcher/menu look | `config/rofi/config.rasi`, `config/rofi/theme.rasi` |
| System menu contents / BT MAC | `config/menu/main` (`CONTROLLER_MAC`, `rows_hub()`, `rows_power()`) |
| Zsh aliases | `config/zsh/modules/aliases.zsh` |
| Zsh env (`EDITOR`, `PATH`, `SSH_AUTH_SOCK`) | `config/zsh/modules/env.zsh` |
| Sessionizer search roots | `config/zsh/modules/sessionizer.zsh` (`WORKSPACES=`) |
| fzf colors / defaults | `config/zsh/modules/fzf.zsh` |
| Starship prompt symbols | `config/starship/starship.toml` |
| Neovim options | `config/nvim/lua/set.lua` |
| Neovim keymaps | `config/nvim/lua/vanilla_keymaps.lua`, `config/nvim/init.lua` |
| Neovim plugins | `config/nvim/lua/plugins/*.lua` |
| Helper scripts | `config/scripts/*` |
| Installed packages | `install/packages_{pacman,yay,npm}.txt` |

### Hyprland keybinds

All binds live in one place: `config/hypr/modules/keybinds.lua`.

* Each `b_*` variable at the top holds the **whole sequence** used to trigger the
  action (modifiers included). Changing the variable remaps the bind.
  Do not edit the `hl.bind(...)` lines unless you are adding/removing an action.
* Programs (`kitty`, `brave`, `dolphin`) come from `config/hypr/modules/settings.lua`.

```lua
-- === Modifiers ===
local mainMod = "SUPER"   -- change to "ALT" and every SUPER-based bind follows

-- === Full bind sequences (edit to remap) ===
local b_terminal   = mainMod .. " + T"                 -- SUPER + T
local b_browser    = mainMod .. " + F"                 -- SUPER + F
local b_focus_left = mainMod .. " + h"                 -- SUPER + h
local b_ws1        = "f1"                              -- f1
-- ...
```

Example remaps:

```lua
local b_terminal = mainMod .. " + Return"  -- SUPER+Return instead of SUPER+T
local b_focus_left = mainMod .. " + Left"  -- arrows instead of hjkl
local b_ws1 = "1"                          -- workspace 1 on "1" instead of "F1"
```

Default binds (with stock variables):

| Combo | Action |
| --- | --- |
| `SUPER+T` / `SUPER+F` / `SUPER+E` / `SUPER+Q` | terminal / browser / file manager / kill window |
| `CTRL+space` | rofi system menu (`menu/main`) |
| `SUPER+SHIFT+E` | exit Hyprland |
| `SUPER+SHIFT+R` | reload (`scripts/reload`) |
| `SUPER+M` | fullscreen |
| `Print` / `SUPER+Print` / `SHIFT+Print` | screenshot region / full / window |
| `SUPER+SHIFT+W` | wallpaper picker scratchpad |
| `SUPER+O` / `SUPER+D` / `SUPER+P` | opencode / lazydocker / btop scratchpads |
| `SUPER+h/j/k/l` | focus left/down/up/right |
| `SUPER+CTRL+h/j/k/l` | move window left/down/up/right |
| `F1`–`F5` | focus workspace 1–5 |
| `SUPER+CTRL+F1`–`F5` | move window to workspace 1–5 |
| `SUPER+LMB-drag` / `SUPER+RMB-drag` | move / resize window |
| `XF86Audio*`, `XF86MonBrightness*` | volume, mic mute, brightness, playerctl |

### Hyprland: monitors, input, appearance, rules

* `modules/monitors.lua` — `eDP-1` (laptop, scale `1.3333`) + `HDMI-A-1` (`1920x1080@120`).
  Workspaces 1–3 are pinned to HDMI, 4–5 to eDP. Edit `hl.monitor({...})` and
  `hl.workspace_rule({...})` for your hardware (`hyprctl monitors` to list names).
* `modules/input.lua` — `kb_layout = "latam"`, `kb_options = "caps:escape"`.
  Uncomment/swap the `us` / `intl` lines for a US layout. Touchpad and
  `workspace_swipe_invert` live here too.
* `modules/appearance.lua` — `gaps_in/out`, `border_size`, rose-pine border colors,
  blur, all `hl.curve` / `hl.animation` entries, dwindle/master layout, `misc`.
* `modules/window-rules.lua` — auto-workspace assignment (brave→1, kitty→2,
  DBeaver→3, discord/WhatsApp→4, YouTube/Music→5), discord popout float/pin/size,
  floating sizes for `nm-gui` / `pavucontrol`, scratchpad slide animation.
  Match fields are Lua patterns on `class` / `title` / `initial_title`.

### Wallpaper

* Files in `wallpapers/` are copied to `~/wallpapers/` on install.
* `SUPER+SHIFT+W` (or `wallpaper_picker [list]`) opens an fzf+kitty-icat picker,
  sets all monitors via `hyprctl hyprpaper wallpaper`, persists to
  `config/hypr/hyprpaper.conf`, and sends a notification.
* To set a static default, edit the `path = ...` line in `hyprpaper.conf`.

### Waybar

* `config.jsonc` only defines bar position and `modules-left` / `modules-right`
  (it `include`s every file under `modules/`). Add/remove a name there to
  show/hide a module.
* Per-module settings (format, icons, thresholds) are one file per module in
  `config/waybar/modules/` (e.g. `clock.jsonc`, `battery.jsonc`, `pulseaudio.jsonc`).
* Styling: `style.css` imports `styles/themes/rose-pine.css` (palette +
  `@accent`, `@bg`, `@fg`). Tweak that one file to retheme the whole bar;
  per-module margins live in `styles/modules.css`, dividers in `styles/dividers.css`.
* Helper click actions call `scripts/{bluetooth,network,volume}`.

### Kitty, Rofi, Menu

* `kitty.conf` — shell, font (`FiraCode Nerd Font`, size 10), opacity
  (`ctrl+page_up/down`), tab style, `hide_window_decorations`. Colors are
  `include rose-pine.conf` — swap that include to retheme.
* `rofi/config.rasi` + `theme.rasi` — rose-pine colors, 620px centered window,
  8-line listview. Invoked as `rofi -show menu -modes "menu:~/.config/menu/main"`.
* `menu/main` — single-file rofi script-mode hub. Personalize `CONTROLLER_MAC`,
  `desktop_roots()`, and the `rows_hub()` / `rows_power()` lists to add entries.
  Scratchpad entries call `~/.config/scripts/scratch <name> <cmd>`.

### Zsh + Sessionizer

* `main.zsh` sources every `modules/*.zsh` — add a new `modules/foo.zsh` and it
  loads automatically.
* `modules/aliases.zsh` — `ls`/`la`/`lt` (eza), `venv`, `icat`, `docker-compose`,
  `django`, `github` (open remote in browser).
* `modules/env.zsh` — `EDITOR=nvim`, `SSH_AUTH_SOCK`, Go `PATH`.
* `modules/sessionizer.zsh` — set `WORKSPACES="dev dev/principia-workspace/worktrees"`
  (paths relative to `$HOME`). `sessionizer.sh` finds `.git` dirs up to 2 deep,
  shows active/exited state from `zellij list-sessions`, and is bound to `Ctrl-A`
  (`bindkey -s '^a'`). Enter attaches, `ctrl-x` stops, `ctrl-d` deletes.

### Neovim

* `lua/set.lua` — line numbers, 2-space indent, `mapleader = ' '`, undo dir,
  `cursorline`, diagnostic signs.
* `lua/vanilla_keymaps.lua` — `<leader>e` explorer, `<C-h/j/k/l>` window moves,
  `<leader>{/}` tabs, `<Tab>` indent, `<leader>tt` toggles tab width 2↔4.
* `init.lua` — `<leader>cb` clear buffers, `<leader>l` Love2D runner, `gf` edit file.
* `lua/plugins/*.lua` — one file per plugin (lsp, telescope, treesitter, harpoon,
  gitsigns, lualine, theme, etc.). `lazy-lock.json` is gitignored.

### Scripts

| Script | Purpose |
| --- | --- |
| `scripts/reload` | `hyprctl reload` + restart waybar + `dunstctl reload` |
| `scripts/scratch <name> <cmd>` | toggle-or-launch a `special:<name>` scratchpad |
| `scripts/screenshot [region\|full\|window]` | grim+slurp → `~/screenshots/`, copy via `wl-copy` |
| `scripts/wallpaper_picker [list]` | fzf picker, applies via hyprpaper, persists conf |
| `waybar/scripts/{bluetooth,network,volume}` | click actions for bar modules |

### Theming

Rose-pine is the shared theme. To retheme, touch these files:

* Hyprland borders: `config/hypr/modules/appearance.lua` (`col.active_border`)
* Kitty: `config/kitty/rose-pine.conf` (swapped via `include` in `kitty.conf`)
* Waybar: `config/waybar/styles/themes/rose-pine.css`
* Rofi: `config/rofi/theme.rasi`
* Zellij: `config/zellij/themes/rose-pine.kdl` (+ `theme "rose-pine"` in `config.kdl`)
* btop: `config/btop/themes/rose-pine.theme`
* fzf: `config/zsh/modules/fzf.zsh` (`FZF_DEFAULT_OPTS`)
