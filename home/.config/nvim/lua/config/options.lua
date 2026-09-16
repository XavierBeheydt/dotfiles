-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- New vertical splits open to the right of the current window.
vim.opt.splitright = true

-- New horizontal splits open below the current window.
vim.opt.splitbelow = true

-- Line numbers: absolute on the current line, relative on the rest.
vim.opt.number = true

-- g:RELATIVENUMBER (all-uppercase) is persisted across restarts by shada's
-- default '!' flag; default to false on the very first launch.
--
-- Shada is only loaded *after* this file is sourced, so this initial
-- assignment is just the first-launch fallback. The actual persisted
-- value (once shada has loaded it) is re-applied on VimEnter, see
-- config.autocmds.
if vim.g.RELATIVENUMBER == nil then
    vim.g.RELATIVENUMBER = false
end
vim.opt.relativenumber = vim.g.RELATIVENUMBER
