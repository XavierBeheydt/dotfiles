-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- New vertical splits open to the right of the current window.
vim.opt.splitright = true

-- New horizontal splits open below the current window.
vim.opt.splitbelow = true

-- Line numbers: absolute on the current line, relative on the rest.
vim.opt.number = true
vim.opt.relativenumber = true

vim.g.mapleader = " "

-- Toggle relative numbering on/off (absolute numbers stay on either way).
vim.keymap.set("n", "<leader>n", function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative line numbers" })
