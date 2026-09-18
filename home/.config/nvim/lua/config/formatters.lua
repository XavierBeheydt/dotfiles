-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

local formatters = require("formatters")

-- Lua: stylua (external) instead of the LSP formatter.
formatters.set("lua", { cmd = { "stylua", "-" } })

-- Rust: rustfmt (external) instead of the LSP formatter.
formatters.set("rust", { cmd = { "rustfmt", "--emit=stdout" } })

-- Other filetypes fall back to "lsp" (vim.lsp.buf.format()) by default.

vim.api.nvim_create_user_command("Format", formatters.format, {})
