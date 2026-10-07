-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Clears the cached config/pack/languages modules and re-requires "config",
-- so editing a file under lua/config/, lua/pack/ or lua/languages/ can be
-- picked up without restarting Neovim. Autocmds are safe to re-run: they
-- live in the "config" augroup, cleared at the top of config/init.lua.
local function reload()
    for name, _ in pairs(package.loaded) do
        if
            name == "pack"
            or name == "languages"
            or name == "config"
            or name:match("^config%.")
            or name:match("^languages%.")
        then
            package.loaded[name] = nil
        end
    end
    require("config")
    vim.notify("nvim config reloaded", vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("ReloadNvimSettings", reload, {})
