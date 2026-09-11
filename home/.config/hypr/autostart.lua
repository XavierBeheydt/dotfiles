-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

local programs = require("hypr.programs")

-- TODO: build a session-restore system: on logout/shutdown, save which
-- apps are currently open (and their workspace/monitor/position) and
-- respawn + place them back here automatically on the next start,
-- instead of hardcoding the autostart list below.

hl.on("hyprland.start", function()
    -- Left screen (HDMI-A-1): terminal running tmux with btop
    hl.exec_cmd("[monitor HDMI-A-1] " .. programs.launchPrefix .. programs.terminal .. " -e tmux new-session -s main btop")

    -- hl.exec_cmd(programs.launchPrefix .. "nm-applet")
    -- hl.exec_cmd(programs.launchPrefix .. "quickshell")
end)
