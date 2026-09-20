-- Input, per-device config and gestures
-- See https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    input = {
        kb_layout = "latam",
        -- kb_layout = "us",
        -- kb_variant = "intl",
        kb_options = "caps:escape",

        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
            disable_while_typing = true,
        },
    },
})

hl.config({
    gestures = {
        workspace_swipe_invert = false,
    },
})
