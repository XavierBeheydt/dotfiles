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
