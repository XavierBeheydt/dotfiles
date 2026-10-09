-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Enable LSP Servers
vim.lsp.enable({
	'lua_language_server',
	'rust_analyzer',
})

-- Hard-wrap a diagnostic message to the current window width, so long errors
-- aren't cut off at the edge of the screen. virtual_text can't wrap, hence
-- virtual_lines, which renders one virtual line per "\n" in the message.
local function wrap_diagnostic(diagnostic)
    local width = math.max(vim.api.nvim_win_get_width(0) - 12, 20)
    local lines = {}
    for _, line in ipairs(vim.split(diagnostic.message, "\n", { plain = true })) do
        while vim.fn.strdisplaywidth(line) > width do
            -- Break at the last space that fits, or hard-cut when there is none.
            local cut = line:sub(1, width):match("^.*()%s") or width
            table.insert(lines, vim.trim(line:sub(1, cut)))
            line = vim.trim(line:sub(cut + 1))
        end
        table.insert(lines, line)
    end
    return table.concat(lines, "\n")
end

-- Inline diagnostics: wrapped, cursor line only. On by default.
local inline = { current_line = true, format = wrap_diagnostic }
vim.diagnostic.config({ virtual_text = false, virtual_lines = inline })

vim.keymap.set("n", "<leader>ci", function()
    local on = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = on and inline or false })
end, { desc = "Toggle inline diagnostics" })

local keymaps = require("config.keymaps")

vim.api.nvim_create_autocmd("LspAttach", {
    group = "config",
    callback = function(args)
        for _, map in ipairs(keymaps.lsp) do
            vim.keymap.set(map[1], map[2], map[3], { buffer = args.buf, desc = map[4] })
        end
    end,
})
