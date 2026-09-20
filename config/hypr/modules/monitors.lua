-- Monitors, workspace assignment and xwayland
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "auto",
    scale = "1.3333",
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@120",
    position = "0x0",
    scale = "auto",
})

-- workspace = 4, monitor:eDP-1
-- workspace = 5, monitor:eDP-1
hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1" })

-- workspace = 1, monitor:HDMI-A-1
-- workspace = 2, monitor:HDMI-A-1
-- workspace = 3, monitor:HDMI-A-1
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1" })

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})
