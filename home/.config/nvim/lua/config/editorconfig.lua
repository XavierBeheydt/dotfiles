-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Writes an .editorconfig in the cwd from the current buffer's settings
-- (see config.options for the defaults these come from).
local function generate()
    local end_of_line = ({ unix = "lf", dos = "crlf", mac = "cr" })[vim.o.fileformat] or "lf"

    local lines = {
        "root = true",
        "",
        "[*]",
        "indent_style = " .. (vim.o.expandtab and "space" or "tab"),
        "indent_size = " .. vim.o.shiftwidth,
        "end_of_line = " .. end_of_line,
        "charset = " .. vim.o.fileencoding,
        "insert_final_newline = true",
        "trim_trailing_whitespace = true",
    }

    local path = vim.fn.getcwd() .. "/.editorconfig"
    vim.fn.writefile(lines, path)
    vim.notify(".editorconfig written to " .. path, vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("EditorconfigGenerate", generate, {})
