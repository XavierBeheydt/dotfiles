-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Enable LSP Servers
vim.lsp.enable({
	'lua_language_server',
	'rust_analyzer',
})

-- Show diagnostic messages inline (off by default on this Neovim version).
vim.diagnostic.config({ virtual_text = true })

local keymaps = require("config.keymaps")

vim.api.nvim_create_autocmd("LspAttach", {
    group = "config",
    callback = function(args)
        for _, map in ipairs(keymaps.lsp) do
            vim.keymap.set(map[1], map[2], map[3], { buffer = args.buf, desc = map[4] })
        end
    end,
})
