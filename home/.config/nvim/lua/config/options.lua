-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- New vertical splits open to the right of the current window.
vim.opt.splitright = true

-- New horizontal splits open below the current window.
vim.opt.splitbelow = true

-- Line numbers: absolute on the current line, relative on the rest.
vim.opt.number = true

-- Change line number to relative number and check if already set.
if vim.g.RELATIVENUMBER == nil then
	vim.g.RELATIVENUMBER = false
end
vim.opt.relativenumber = vim.g.RELATIVENUMBER

-- Add signs column
vim.opt.signcolumn = "yes"

-- Search options
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- File defaults: LF line endings, UTF-8, 4 spaces (no tabs). A project's
-- .editorconfig (native support, no plugin needed) overrides these per file.
vim.opt.fileformat = "unix"
vim.opt.fileencoding = "utf-8"
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
