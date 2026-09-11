-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

--------------------------
---- SCREENSHOT BINDS ----
--------------------------

local programs = require("hypr.programs")

hl.bind("SUPER + P", hl.dsp.exec_cmd(programs.screenshot .. " --region"))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd(programs.screenshot .. " --window"))
hl.bind("SUPER + CTRL + P", hl.dsp.exec_cmd(programs.screenshot .. " --output"))
hl.bind("SUPER + CTRL + ALT + P", hl.dsp.exec_cmd(programs.screenshot .. " --all"))
