-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

--------------------
---- APPS BINDS ----
--------------------

local programs = require("hypr.programs")

hl.bind("SUPER + Return", hl.dsp.exec_cmd(programs.launchPrefix .. programs.terminal))
hl.bind("SUPER + T",      hl.dsp.exec_cmd(programs.launchPrefix .. programs.browser))
hl.bind("SUPER + Y",      hl.dsp.exec_cmd(programs.launchPrefix .. "env GDK_BACKEND=x11 WEBKIT_DISABLE_DMABUF_RENDERER=1 luakit"))
-- hl.bind("SUPER + Q",      hl.dsp.exec_cmd(programs.terminal))
hl.bind("SUPER + E",      hl.dsp.exec_cmd(programs.fileManager))
hl.bind("SUPER + R",      hl.dsp.exec_cmd(programs.menu))
