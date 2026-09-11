-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output    = "HDMI-A-1",
    mode      = "3840x2160@143.99",
    position  = "0x0",
    scale     = 1.5,
    transform = 1,
})

hl.monitor({
    output   = "DP-3",
    mode     = "5120x1440@119.97",
    position = "1440x300",
    scale    = 1.0,
})
