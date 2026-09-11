-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input

---------------
---- INPUT ----
---------------

------------------
---- KEYBOARD ----
------------------

hl.config({
    input = {
        kb_layout  = "us,us",
        kb_variant = ",intl",
        kb_model   = "",
        kb_options = "grp:alt_shift_toggle",
        kb_rules   = "",

        repeat_rate  = 40,
        repeat_delay = 250,
    },
})

---------------
---- MOUSE ----
---------------

hl.config({
    input = {
        follow_mouse = 1,
        -- TODO: check and test about mouse sensi and accel
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        -- accel_profile = "flat", -- Best for gaming
        -- accel_profile = "adaptative", -- Best for working
    },
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = 0,
})

------------------
---- TOUCHPAD ----
------------------

hl.config({
    input = {
        touchpad = {
            natural_scroll       = false,
            clickfinger_behavior = false,
            scroll_factor        = 0.4,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

--------------
---- DPMS ----
--------------

-- Wake the monitor from DPMS off on keyboard/mouse activity, instead of
-- relying solely on hypridle's on-resume callback (which isn't always reliable).
hl.config({
    misc = {
        key_press_enables_dpms  = true,
        mouse_move_enables_dpms = true,
    },
})
