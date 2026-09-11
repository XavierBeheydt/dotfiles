-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

---------------------
---- SHELL BINDS ----
---------------------

-- Quickshell bar (home/.config/quickshell). It is revealed by moving the
-- pointer to the top middle of a screen; this pins it out on every screen
-- instead, and unpins it. `qs` is quickshell's CLI, the call lands on the
-- IpcHandler declared in shell.qml.
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("qs ipc call bar toggle"))
