-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- One module per language, for features that go beyond what formatters/ and
-- lsp/ (both discovered by filetype) cover. A module is a directory
-- (init.lua + config.lua + helpers) exposing setup(opts); each one only acts
-- on buffers of its own language.

require("languages.markdown").setup()
