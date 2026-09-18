-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Enable LSP Servers
vim.lsp.enable({
	'lua_language_server',
	-- 'rust_analyzer',
})

local keymaps = require("config.keymaps")

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        for _, map in ipairs(keymaps.lsp) do
            vim.keymap.set(map[1], map[2], map[3], { buffer = args.buf, desc = map[4] })
        end
    end,
})
