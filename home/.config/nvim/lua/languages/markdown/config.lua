-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Defaults and user overrides, the way LazyVim's config module does it:
-- setup(opts) deep-merges opts over defaults. Read `options` at call time
-- (never cache it), since setup() replaces the table.

local M = {}

-- Candidates tried in order: the first one found in PATH is used.
local python = { "python3", "python" }
local node = { "node", "nodejs" } -- Debian and friends call it nodejs

M.defaults = {
	-- Info-string language -> interpreter: a command, or a list of candidates.
	-- The block is written to a temp file that is passed as the interpreter's
	-- only argument. Set a language to false to disable it.
	interpreters = {
		bash = "bash",
		sh = "sh",
		shell = "bash",
		zsh = "zsh",
		fish = "fish",
		python = python,
		py = python,
		node = node,
		nodejs = node,
		javascript = node,
		js = node,
		ruby = "ruby",
		rb = "ruby",
		lua = { "lua", "luajit" },
	},
	-- Runner size, as a fraction of the screen (height below, width on the right).
	size = 0.35,
}

M.options = vim.deepcopy(M.defaults)

function M.setup(opts)
	M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
