-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

local M = {}

-- filetype -> "lsp" | { cmd = {...} }
-- Unregistered filetypes default to "lsp".
M.formatters = {}

function M.set(filetype, formatter)
    M.formatters[filetype] = formatter
end

local function format_external(cmd)
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local input = table.concat(lines, "\n") .. "\n"

    local result = vim.system(cmd, { stdin = input, text = true }):wait()
    if result.code ~= 0 then
        vim.notify("format: " .. cmd[1] .. " failed\n" .. (result.stderr or ""), vim.log.levels.ERROR)
        return
    end

    local new_lines = vim.split(result.stdout, "\n")
    if new_lines[#new_lines] == "" then
        table.remove(new_lines)
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
end

function M.format()
    local formatter = M.formatters[vim.bo.filetype]

    if formatter == nil or formatter == "lsp" then
        vim.lsp.buf.format({ async = false })
    elseif type(formatter) == "table" and formatter.cmd then
        format_external(formatter.cmd)
    end
end

return M
