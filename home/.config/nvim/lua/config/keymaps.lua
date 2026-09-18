-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

local M = {}

vim.g.mapleader = " "

-- Toggle relative numbering on/off (absolute numbers stay on either way).
-- g:RELATIVENUMBER keeps the setting across restarts (see config.options).
M.global = {
    { "n", "<leader>n", function()
        vim.g.RELATIVENUMBER = not vim.opt.relativenumber:get()
        vim.opt.relativenumber = vim.g.RELATIVENUMBER
    end, "Toggle relative line numbers" },
}

M.lsp = {
    { "n", "gd", vim.lsp.buf.definition, "Go to definition" },
    { "n", "gr", vim.lsp.buf.references, "List references" },
    { "n", "K", vim.lsp.buf.hover, "Hover documentation" },
    { "n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol" },
    { "n", "<leader>ca", vim.lsp.buf.code_action, "Code actions" },
    { "n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic" },
    { "n", "]d", vim.diagnostic.goto_next, "Next diagnostic" },
}

-- Register global keymaps
for _, map in ipairs(M.global) do
    vim.keymap.set(map[1], map[2], map[3], { desc = map[4] })
end

return M
