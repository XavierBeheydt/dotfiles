-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Run the fenced code blocks of a markdown buffer in a terminal. Like :split
-- and :vsplit, :MarkdownRun opens it below and :VMarkdownRun on the right:
-- as a tmux pane when inside tmux, as a Neovim split otherwise.
--
--   config.lua     defaults + setup(opts)
--   functions.lua  pure helpers: finding the block / lines to run
--   runner.lua     the terminal (tmux pane or Neovim split)

local config = require("languages.markdown.config")
local functions = require("languages.markdown.functions")
local runner = require("languages.markdown.runner")

local M = {}

-- The command to run `lang` blocks with: the first candidate found in PATH.
-- Returns `nil, message` when there is none (or no interpreter for `lang`).
local function resolve(lang)
	local candidates = config.options.interpreters[lang]
	if not candidates then
		return nil, ("no interpreter for '%s'"):format(lang)
	end
	candidates = type(candidates) == "table" and candidates or { candidates }
	for _, cmd in ipairs(candidates) do
		if vim.fn.executable(cmd) == 1 then
			return cmd
		end
	end
	return nil, ("'%s' not found in PATH (needed for %s blocks)"):format(table.concat(candidates, "' or '"), lang)
end

-- Run the block under the cursor, or the lines `range = { first, last }`,
-- in a runner below (or on the right if `vertical`).
function M.run(range, vertical)
	local cursor = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	local code, lang = functions.pick(lines, cursor, range)
	if not code then
		vim.notify("MarkdownRun: " .. lang, vim.log.levels.WARN)
		return
	end
	if not lang then
		vim.notify("MarkdownRun: the code block has no language", vim.log.levels.WARN)
		return
	end

	-- Checked before anything is written or opened.
	local interpreter, err = resolve(lang)
	if not interpreter then
		vim.notify("MarkdownRun: " .. err, vim.log.levels.ERROR)
		return
	end

	-- Cleaned up with Neovim's session temp dir at exit.
	local script = vim.fn.tempname()
	vim.fn.writefile(code, script)

	runner.run({ interpreter, script }, vim.fn.getcwd(), vertical)
end

-- `opts` overrides config.defaults. Safe to call again: the autocmd group is
-- cleared first.
function M.setup(opts)
	config.setup(opts)

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("languages-markdown", { clear = true }),
		pattern = "markdown",
		callback = function(ev)
			-- No range: the block under the cursor. With one (":" in visual
			-- mode prefills '<,'>): just those lines of the block.
			for name, vertical in pairs({ MarkdownRun = false, VMarkdownRun = true }) do
				vim.api.nvim_buf_create_user_command(ev.buf, name, function(cmd)
					M.run(cmd.range > 0 and { cmd.line1, cmd.line2 } or nil, vertical)
				end, {
					range = true,
					desc = "Run a fenced code block in a terminal " .. (vertical and "on the right" or "below"),
				})
			end
		end,
	})
end

return M
