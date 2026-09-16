-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Shada (which restores g:RELATIVENUMBER, see config.options) is loaded
-- after this config is sourced, so re-apply the persisted value once
-- VimEnter fires and shada is guaranteed to be loaded.
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.opt.relativenumber = vim.g.RELATIVENUMBER
    end,
})
