-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

----------------------
---- MOUSE BINDS -----
----------------------

-- Move/resize windows with SUPER + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
