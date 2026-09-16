-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

vim.g.mapleader = " "

-- Toggle relative numbering on/off (absolute numbers stay on either way).
-- g:RELATIVENUMBER keeps the setting across restarts (see config.options).
vim.keymap.set("n", "<leader>n", function()
    vim.g.RELATIVENUMBER = not vim.opt.relativenumber:get()
    vim.opt.relativenumber = vim.g.RELATIVENUMBER
end, { desc = "Toggle relative line numbers" })
