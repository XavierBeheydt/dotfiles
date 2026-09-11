-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-----------------------
---- WINDOWS BINDS ----
-----------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/ for more

local closeWindowBind = hl.bind("SUPER + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind("SUPER + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + B", hl.dsp.window.pseudo())
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with SUPER + arrow keys
hl.bind("SUPER + left",  hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up",    hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down",  hl.dsp.focus({ direction = "down" }))

-- Alt-Tab: cycle focus through open windows (most-recently-used order),
-- and raise the newly focused window so it's not hidden behind others.
hl.bind("ALT + Tab",         hl.dsp.window.cycle_next({ prev = true }))
hl.bind("ALT + Tab",         hl.dsp.window.bring_to_top())
-- hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ prev = true }))
-- hl.bind("ALT + SHIFT + Tab", hl.dsp.window.bring_to_top())
