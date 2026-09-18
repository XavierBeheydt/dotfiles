-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- rustfmt (external) instead of the LSP formatter.
return { cmd = { "rustfmt", "--emit=stdout" } }
