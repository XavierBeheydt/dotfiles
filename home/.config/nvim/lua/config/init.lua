-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Cleared here (not per-file) so :ReloadNvimSettings can re-require
-- everything without piling up duplicate autocmds.
vim.api.nvim_create_augroup("config", { clear = true })

require("config.options")
require("config.completion")
require("config.keymaps")
require("config.autocmds")
require("config.lsp")
require("config.formatters")
require("config.editorconfig")
require("config.pack")
require("config.reload")
