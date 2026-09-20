-- Keybindings
-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local settings = require("modules/settings")

local mainMod    = settings.mainMod
local shift      = settings.shift
local control    = settings.control
local left       = settings.left
local right      = settings.right
local up         = settings.up
local down       = settings.down
local w1         = settings.w1
local w2         = settings.w2
local w3         = settings.w3
local w4         = settings.w4
local w5         = settings.w5

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(settings.terminal))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(settings.browser))
hl.bind(mainMod .. " + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(settings.fileManager))
hl.bind(control .. " + space", hl.dsp.exec_cmd("rofi -show menu -modes \"menu:$HOME/.config/menu/main\""))
hl.bind(mainMod .. " + " .. shift .. " + E", hl.dsp.exit())
hl.bind(mainMod .. " + " .. shift .. " + R", hl.dsp.exec_cmd("~/.config/scripts/reload"))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen())

-- Screenshots: region (Print), full screen (SUPER+Print), active window (SHIFT+Print)
hl.bind("Print", hl.dsp.exec_cmd("~/.config/scripts/screenshot"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("~/.config/scripts/screenshot full"))
hl.bind(shift .. " + Print", hl.dsp.exec_cmd("~/.config/scripts/screenshot window"))

-- Wallpaper picker in a scratchpad
hl.bind(mainMod .. " + " .. shift .. " + W", hl.dsp.exec_cmd("~/.config/scripts/scratch wall \"kitty -e ~/.config/scripts/wallpaper_picker\""))

-- opencode in a scratchpad
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("~/.config/scripts/scratch oc \"kitty -e opencode\""))

-- lazydocker in a scratchpad
  hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("~/.config/scripts/scratch ld \"kitty -e lazydocker\""))

-- btop in a scratchpad
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/.config/scripts/scratch btop \"kitty -e btop\""))

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
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
