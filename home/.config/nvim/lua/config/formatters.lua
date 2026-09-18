-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

vim.api.nvim_create_user_command("Format", require("formatters").format, {})
