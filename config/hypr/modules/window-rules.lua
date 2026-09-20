-- Window rules and workspace assignment
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.window_rule({
    name = "discord-popout-float",
    match = { class = "^(discord)$", initial_title = "^(Discord Popout)$" },
    float = true,
})
hl.window_rule({
    name = "discord-popout-pin",
    match = { class = "^(discord)$", initial_title = "^(Discord Popout)$" },
    pin = true,
})
hl.window_rule({
    name = "discord-popout-move",
    match = { class = "^(discord)$", initial_title = "^(Discord Popout)$" },
    move = "55% 59%",
})
hl.window_rule({
    name = "discord-popout-size",
    match = { class = "^(discord)$", initial_title = "^(Discord Popout)$" },
    size = "640 360",
})

-- Auto move
hl.window_rule({
    name = "brave-workspace",
    match = { class = "^(brave-browser)$" },
    workspace = "1",
})
hl.window_rule({
    name = "kitty-workspace",
    match = { class = "^(kitty)$" },
    workspace = "2",
})
hl.window_rule({
    name = "dbeaver-workspace",
    match = { class = "^(DBeaver)$" },
    workspace = "3",
})
hl.window_rule({
    name = "discord-workspace",
    match = { class = "^(discord)$" },
    workspace = "4",
})

-- DBeaver loading screen fix
hl.window_rule({
    name = "dbeaver-loading-workspace",
    match = { title = "^(Dbeaver)$" },
    workspace = "3",
})
hl.window_rule({
    name = "dbeaver-loading-float",
    match = { title = "^(Dbeaver)$" },
    float = true,
})

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "xwayland-dragging",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

-- more floating
hl.window_rule({
    name = "nmgui-float",
    match = { class = "^(com.network.manager)$" },
    float = true,
    size = "480 720",
})
hl.window_rule({
    name = "pavucontrol-float",
    match = { class = "^(org.pulseaudio.pavucontrol)$" },
    float = true,
    size = "720 480",
})

-- Scratchpad windows open from the top and close back up (drawer)
hl.window_rule({
    name = "scratchpad-anim",
    match = { workspace = "s[true]" },
    animation = "slide top",
})
