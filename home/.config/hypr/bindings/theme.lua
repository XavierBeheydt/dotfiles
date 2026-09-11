-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

---------------------
---- THEME BINDS ----
---------------------

local programs = require("hypr.programs")

hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd(programs.theme .. " toggle"))
