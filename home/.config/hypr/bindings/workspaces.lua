-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

--------------------------
---- WORKSPACES BINDS ----
--------------------------

-- Switch workspaces with SUPER + [0-9]
-- Move active window to a workspace (staying on the current one) with SUPER + SHIFT + [0-9]
-- Move active window to a workspace and follow it there with SUPER + ALT + [0-9]
for i = 1, 10 do
    local digit = i % 10 -- 10 maps to key 0
    hl.bind("SUPER + " .. digit,         hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. digit, hl.dsp.window.move({ workspace = i, follow = false }))
    hl.bind("SUPER + ALT + " .. digit,   hl.dsp.window.move({ workspace = i, follow = true }))
end

-- Example special workspace (scratchpad)
hl.bind("SUPER + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with SUPER + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
