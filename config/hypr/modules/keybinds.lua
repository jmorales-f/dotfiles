-- Keybindings
-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- CENTRAL KEYBIND CONFIG: to remap any bind, just change the variable value
-- below. The hl.bind lines underneath use only these variables.

local settings = require("modules/settings")

-- === Modifiers (edit to remap) ===
local mainMod = "SUPER"
local shift   = "SHIFT"
local control = "CTRL"

-- === Movement keys (edit to remap) ===
local left  = "h"
local right = "l"
local up    = "k"
local down  = "j"

-- === Workspace keys (edit to remap) ===
local w1 = "f1"
local w2 = "f2"
local w3 = "f3"
local w4 = "f4"
local w5 = "f5"

-- === Action / app keys (edit to remap) ===
local k_terminal   = "T"
local k_browser    = "F"
local k_kill       = "Q"
local k_file       = "E"
local k_launcher   = "space"
local k_exit       = "E"
local k_reload     = "R"
local k_fullscreen = "M"
local k_shot       = "Print"
local k_wall       = "W"
local k_oc         = "O"
local k_docker     = "D"
local k_btop       = "P"

-- === Mouse buttons (edit to remap) ===
local m_drag   = "mouse:272"
local m_resize = "mouse:273"

-- === Media / hardware keys (edit to remap) ===
local vol_up    = "XF86AudioRaiseVolume"
local vol_down  = "XF86AudioLowerVolume"
local mute      = "XF86AudioMute"
local mic_mute  = "XF86AudioMicMute"
local bright_up = "XF86MonBrightnessUp"
local bright_dn = "XF86MonBrightnessDown"
local m_next    = "XF86AudioNext"
local m_pause   = "XF86AudioPause"
local m_play    = "XF86AudioPlay"
local m_prev    = "XF86AudioPrev"

hl.bind(mainMod .. " + " .. k_terminal, hl.dsp.exec_cmd(settings.terminal))
hl.bind(mainMod .. " + " .. k_browser, hl.dsp.exec_cmd(settings.browser))
hl.bind(mainMod .. " + " .. k_kill, hl.dsp.window.kill())
hl.bind(mainMod .. " + " .. k_file, hl.dsp.exec_cmd(settings.fileManager))
hl.bind(control .. " + " .. k_launcher, hl.dsp.exec_cmd("rofi -show menu -modes \"menu:$HOME/.config/menu/main\""))
hl.bind(mainMod .. " + " .. shift .. " + " .. k_exit, hl.dsp.exit())
hl.bind(mainMod .. " + " .. shift .. " + " .. k_reload, hl.dsp.exec_cmd("~/.config/scripts/reload"))
hl.bind(mainMod .. " + " .. k_fullscreen, hl.dsp.window.fullscreen())

-- Screenshots: region (Print), full screen (SUPER+Print), active window (SHIFT+Print)
hl.bind(k_shot, hl.dsp.exec_cmd("~/.config/scripts/screenshot"))
hl.bind(mainMod .. " + " .. k_shot, hl.dsp.exec_cmd("~/.config/scripts/screenshot full"))
hl.bind(shift .. " + " .. k_shot, hl.dsp.exec_cmd("~/.config/scripts/screenshot window"))

-- Wallpaper picker in a scratchpad
hl.bind(mainMod .. " + " .. shift .. " + " .. k_wall, hl.dsp.exec_cmd("~/.config/scripts/scratch wall \"kitty -e ~/.config/scripts/wallpaper_picker\""))

-- opencode in a scratchpad
hl.bind(mainMod .. " + " .. k_oc, hl.dsp.exec_cmd("~/.config/scripts/scratch oc \"kitty -e opencode\""))

-- lazydocker in a scratchpad
hl.bind(mainMod .. " + " .. k_docker, hl.dsp.exec_cmd("~/.config/scripts/scratch ld \"kitty -e lazydocker\""))

-- btop in a scratchpad
hl.bind(mainMod .. " + " .. k_btop, hl.dsp.exec_cmd("~/.config/scripts/scratch btop \"kitty -e btop\""))

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + " .. left, hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + " .. right, hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + " .. up, hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + " .. down, hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mainMod .. " + " .. control .. " + " .. left, hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + " .. control .. " + " .. right, hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + " .. control .. " + " .. up, hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + " .. control .. " + " .. down, hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(w1, hl.dsp.focus({ workspace = 1 }))
hl.bind(w2, hl.dsp.focus({ workspace = 2 }))
hl.bind(w3, hl.dsp.focus({ workspace = 3 }))
hl.bind(w4, hl.dsp.focus({ workspace = 4 }))
hl.bind(w5, hl.dsp.focus({ workspace = 5 }))

-- Move active window to a workspace with mainMod + CONTROL + [0-9]
hl.bind(mainMod .. " + " .. control .. " + " .. w1, hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + " .. control .. " + " .. w2, hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + " .. control .. " + " .. w3, hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + " .. control .. " + " .. w4, hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + " .. control .. " + " .. w5, hl.dsp.window.move({ workspace = 5 }))

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + " .. shift .. " + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + " .. m_drag, hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + " .. m_resize, hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(vol_up, hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind(vol_down, hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind(mute, hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind(mic_mute, hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind(bright_up, hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind(bright_dn, hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind(m_next, hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind(m_pause, hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind(m_play, hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind(m_prev, hl.dsp.exec_cmd("playerctl previous"), { locked = true })
