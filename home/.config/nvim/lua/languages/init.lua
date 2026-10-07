-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- One file per language, for features that go beyond what formatters/ and
-- lsp/ (both discovered by filetype) cover. Each file registers its own
-- FileType autocmd, so it only acts on its language's buffers.

require("languages.markdown")
