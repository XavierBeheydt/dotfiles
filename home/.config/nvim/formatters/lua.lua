-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Other possible formatters for Lua:
--   "lsp"                                -> use lua_language_server's own formatter instead
--   { cmd = { "lua-format", ... } }      -> Koihik/LuaFormatter (C++, .lua-format config file)
--   { cmd = { "lua-fmt", ... } }         -> trixnz/lua-fmt (Node.js, wraps LuaFormatter)
-- (neither lua-format nor lua-fmt is installed here, and their stdin/stdout
-- flags aren't verified like stylua's -- check `--help` before switching.)

-- stylua (external) instead of the LSP formatter.
return { cmd = { "stylua", "-" } }
