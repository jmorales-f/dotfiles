-- Keybindings
-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- CENTRAL KEYBIND CONFIG: every bind's full sequence is defined below.
-- To remap, change the variable value. The hl.bind lines use only these variables.

local settings = require("modules/settings")

-- === Modifiers ===
local mainMod = "SUPER"
local shift   = "SHIFT"
local control = "CTRL"

-- === Full bind sequences (edit to remap) ===
-- Apps / actions
local b_terminal   = mainMod .. " + T"                 -- SUPER + T
local b_browser    = mainMod .. " + F"                 -- SUPER + F
local b_kill       = mainMod .. " + Q"                 -- SUPER + Q
local b_file       = mainMod .. " + E"                 -- SUPER + E
local b_launcher   = control .. " + space"             -- CTRL + space
local b_exit       = mainMod .. " + " .. shift .. " + E" -- SUPER + SHIFT + E
local b_reload     = mainMod .. " + " .. shift .. " + R" -- SUPER + SHIFT + R
local b_fullscreen = mainMod .. " + M"                 -- SUPER + M

-- Screenshots
local b_shot_region = "Print"                -- Print
local b_shot_full   = mainMod .. " + Print"  -- SUPER + Print
local b_shot_window = shift .. " + Print"    -- SHIFT + Print

-- Scratchpads
local b_wallpaper  = mainMod .. " + " .. shift .. " + W" -- SUPER + SHIFT + W
local b_principia_workspace = mainMod .. " + " .. shift .. " + P" -- SUPER + SHIFT +P
local b_opencode   = mainMod .. " + O"                   -- SUPER + O
local b_lazydocker = mainMod .. " + D"                   -- SUPER + D
local b_btop       = mainMod .. " + P"                   -- SUPER + P

-- Focus (hjkl)
local b_focus_left  = mainMod .. " + h" -- SUPER + h
local b_focus_right = mainMod .. " + l" -- SUPER + l
local b_focus_up    = mainMod .. " + k" -- SUPER + k
local b_focus_down  = mainMod .. " + j" -- SUPER + j

-- Move windows (hjkl)
local b_move_left  = mainMod .. " + " .. control .. " + h" -- SUPER + CTRL + h
local b_move_right = mainMod .. " + " .. control .. " + l" -- SUPER + CTRL + l
local b_move_up    = mainMod .. " + " .. control .. " + k" -- SUPER + CTRL + k
local b_move_down  = mainMod .. " + " .. control .. " + j" -- SUPER + CTRL + j

-- Workspaces
local b_ws1 = "f1" -- f1
local b_ws2 = "f2" -- f2
local b_ws3 = "f3" -- f3
local b_ws4 = "f4" -- f4
local b_ws5 = "f5" -- f5

-- Move window to workspace
local b_move_to_ws1 = mainMod .. " + " .. control .. " + f1" -- SUPER + CTRL + f1
local b_move_to_ws2 = mainMod .. " + " .. control .. " + f2" -- SUPER + CTRL + f2
local b_move_to_ws3 = mainMod .. " + " .. control .. " + f3" -- SUPER + CTRL + f3
local b_move_to_ws4 = mainMod .. " + " .. control .. " + f4" -- SUPER + CTRL + f4
local b_move_to_ws5 = mainMod .. " + " .. control .. " + f5" -- SUPER + CTRL + f5

-- Mouse
local b_drag   = mainMod .. " + mouse:272" -- SUPER + mouse:272
local b_resize = mainMod .. " + mouse:273" -- SUPER + mouse:273

-- Media / hardware keys
local b_vol_up    = "XF86AudioRaiseVolume"  -- XF86AudioRaiseVolume
local b_vol_down  = "XF86AudioLowerVolume"  -- XF86AudioLowerVolume
local b_mute      = "XF86AudioMute"         -- XF86AudioMute
local b_mic_mute  = "XF86AudioMicMute"      -- XF86AudioMicMute
local b_bright_up = "XF86MonBrightnessUp"   -- XF86MonBrightnessUp
local b_bright_dn = "XF86MonBrightnessDown" -- XF86MonBrightnessDown
local b_next      = "XF86AudioNext"         -- XF86AudioNext
local b_pause     = "XF86AudioPause"        -- XF86AudioPause
local b_play      = "XF86AudioPlay"         -- XF86AudioPlay
local b_prev      = "XF86AudioPrev"         -- XF86AudioPrev

hl.bind(b_terminal, hl.dsp.exec_cmd(settings.terminal))
hl.bind(b_browser, hl.dsp.exec_cmd(settings.browser))
hl.bind(b_kill, hl.dsp.window.close())
hl.bind(b_file, hl.dsp.exec_cmd(settings.fileManager))
hl.bind(b_launcher, hl.dsp.exec_cmd("rofi -show menu -modes \"menu:$HOME/.config/menu/main\""))
hl.bind(b_exit, hl.dsp.exit())
hl.bind(b_reload, hl.dsp.exec_cmd("~/.config/scripts/reload"))
hl.bind(b_fullscreen, hl.dsp.window.fullscreen())

-- Screenshots: region (Print), full screen (SUPER+Print), active window (SHIFT+Print)
hl.bind(b_shot_region, hl.dsp.exec_cmd("~/.config/scripts/screenshot"))
hl.bind(b_shot_full, hl.dsp.exec_cmd("~/.config/scripts/screenshot full"))
hl.bind(b_shot_window, hl.dsp.exec_cmd("~/.config/scripts/screenshot window"))

-- Wallpaper picker in a scratchpad
hl.bind(b_wallpaper, hl.dsp.exec_cmd("~/.config/scripts/scratch wall \"kitty -e ~/.config/scripts/wallpaper_picker\""))

-- Principia VSCode workspace in a scratchpad.
-- Two windows are involved, spawned a moment apart, both needing to land in
-- special:pws without ever flashing on a visible workspace:
--   1. the kitty wrapper itself -- tagged via the exec_cmd workspace option,
--      same as the other scratchpads (otherwise the "kitty-workspace" rule
--      below would pull it onto workspace 2 and switch view there).
--   2. the actual VS Code window -- code's CLI just messages an
--      already-running instance over IPC, so it's never a child of the
--      process we spawn, and its title isn't set to the real workspace name
--      until just after it's mapped, ruling out exec-time assignment and
--      title-matched window rules alike. Instead: arm a flag right before
--      launching, and catch the window on open_early (fired before it's
--      ever painted) to redirect it into the scratchpad directly.
local principia_pending = false
hl.on("window.open_early", function(window)
    if principia_pending and window.class == "code-oss" then
        principia_pending = false
        hl.dispatch(hl.dsp.window.move({
            workspace = "special:pws",
            window = "address:" .. window.address,
            silent = true,
        }))
    end
end)

hl.bind(b_principia_workspace, function()
    if #hl.get_windows({ workspace = "special:pws" }) > 0 then
        hl.dispatch(hl.dsp.workspace.toggle_special("pws"))
        return
    end
    principia_pending = true
    hl.timer(function() principia_pending = false end, { timeout = 5000, type = "oneshot" })
    hl.dispatch(hl.dsp.exec_cmd(
        "kitty -e code --new-window ~/dev/principia-workspace/principia.code-workspace",
        { workspace = "special:pws" }
    ))
end)

-- opencode in a scratchpad
hl.bind(b_opencode, hl.dsp.exec_cmd("~/.config/scripts/scratch oc \"kitty -e opencode\""))

-- lazydocker in a scratchpad
hl.bind(b_lazydocker, hl.dsp.exec_cmd("~/.config/scripts/scratch ld \"kitty -e lazydocker\""))

-- btop in a scratchpad
hl.bind(b_btop, hl.dsp.exec_cmd("~/.config/scripts/scratch btop \"kitty -e btop\""))

-- Move focus with mainMod + hjkl
hl.bind(b_focus_left, hl.dsp.focus({ direction = "left" }))
hl.bind(b_focus_right, hl.dsp.focus({ direction = "right" }))
hl.bind(b_focus_up, hl.dsp.focus({ direction = "up" }))
hl.bind(b_focus_down, hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(b_move_left, hl.dsp.window.move({ direction = "left" }))
hl.bind(b_move_right, hl.dsp.window.move({ direction = "right" }))
hl.bind(b_move_up, hl.dsp.window.move({ direction = "up" }))
hl.bind(b_move_down, hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(b_ws1, hl.dsp.focus({ workspace = 1 }))
hl.bind(b_ws2, hl.dsp.focus({ workspace = 2 }))
hl.bind(b_ws3, hl.dsp.focus({ workspace = 3 }))
hl.bind(b_ws4, hl.dsp.focus({ workspace = 4 }))
hl.bind(b_ws5, hl.dsp.focus({ workspace = 5 }))

-- Move active window to a workspace with mainMod + CONTROL + [0-9]
hl.bind(b_move_to_ws1, hl.dsp.window.move({ workspace = 1 }))
hl.bind(b_move_to_ws2, hl.dsp.window.move({ workspace = 2 }))
hl.bind(b_move_to_ws3, hl.dsp.window.move({ workspace = 3 }))
hl.bind(b_move_to_ws4, hl.dsp.window.move({ workspace = 4 }))
hl.bind(b_move_to_ws5, hl.dsp.window.move({ workspace = 5 }))

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + " .. shift .. " + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(b_drag, hl.dsp.window.drag(), { mouse = true })
hl.bind(b_resize, hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(b_vol_up, hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind(b_vol_down, hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind(b_mute, hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind(b_mic_mute, hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind(b_bright_up, hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind(b_bright_dn, hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind(b_next, hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind(b_pause, hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind(b_play, hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind(b_prev, hl.dsp.exec_cmd("playerctl previous"), { locked = true })
