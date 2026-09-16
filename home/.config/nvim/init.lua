-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- New vertical splits open to the right of the current window.
vim.opt.splitright = true

-- New horizontal splits open below the current window.
vim.opt.splitbelow = true

-- Line numbers: absolute on the current line, relative on the rest.
vim.opt.number = true
vim.opt.relativenumber = true

-- 4-space soft tabs everywhere.
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Case-insensitive search, unless the pattern has an uppercase letter.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Share the system clipboard (Wayland, via wl-clipboard) with yank/paste.
vim.opt.clipboard = "unnamedplus"

-- Persist undo history across sessions.
vim.opt.undofile = true

-- Keep a gutter for diagnostics/signs so text doesn't shift when they appear.
vim.opt.signcolumn = "yes"

-- Keep a few lines of context above/below the cursor while scrolling.
vim.opt.scrolloff = 8

vim.g.mapleader = " "

-- Toggle relative numbering on/off (absolute numbers stay on either way).
vim.keymap.set("n", "<leader>n", function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative line numbers" })
