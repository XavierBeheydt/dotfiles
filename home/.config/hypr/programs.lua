-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Programs used across keybindings/autostart.

return {
    terminal     = "kitty",
    fileManager  = "dolphin",
    -- TODO: launcher not decided yet -- "hyprlauncher" is just Hyprland's
    -- default placeholder, not an installed program. Candidates: Vicinae
    -- (ready-made, unblocks this now) vs a custom Quickshell launcher
    -- (launcher/providers/ pattern, see docs/architecture-inspiration.md --
    -- makes more sense once quickshell/ itself is back, #7)
    menu         = "hyprlauncher",
    browser      = "firefox",
    launchPrefix = "uwsm app -- ",
    screenshot   = "screenshot",
    theme        = "theme",
}
