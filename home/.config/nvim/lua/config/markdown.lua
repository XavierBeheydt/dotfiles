-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Run the fenced code blocks of a markdown buffer in a terminal: a tmux pane
-- below Neovim when inside tmux, a vertical split on the right otherwise.
-- One runner is kept and reused, so running another block replaces the
-- previous one instead of piling up panes.

local M = {}

-- Info-string language -> interpreter. The block is written to a temp file
-- that is passed as the interpreter's only argument.
M.interpreters = {
	bash = "bash",
	sh = "sh",
	shell = "bash",
	zsh = "zsh",
	fish = "fish",
	python = "python3",
	py = "python3",
}

-- Runner size, as a fraction of the screen (height in tmux, width otherwise).
M.size = 0.35

-- Fence opener: indent, fence run (3+ backticks or tildes), info string.
local function parse_open(line)
	local indent, fence, info = line:match("^(%s*)(```+)(.*)$")
	if not fence then
		indent, fence, info = line:match("^(%s*)(~~~+)(.*)$")
	end
	-- A backtick fence can't have backticks in its info string: that's
	-- inline code (```like this```) on a single line, not a fence.
	if fence and fence:sub(1, 1) == "`" and info:find("`", 1, true) then
		return nil
	end
	return indent, fence, info
end

local function is_close(line, fence)
	local run = line:match("^%s*(" .. fence:sub(1, 1) .. "+)%s*$")
	return run ~= nil and #run >= #fence
end

local function dedent(line, width)
	return line:sub(math.min(#line:match("^%s*"), width) + 1)
end

-- Fenced blocks of `lines` as { lang, open, close, first, last, indent }:
-- 1-based line numbers, `first`..`last` being the content (`last < first`
-- for an empty block). An unclosed fence runs to the end of the buffer.
function M.parse(lines)
	local blocks, current = {}, nil
	for i, line in ipairs(lines) do
		if not current then
			local indent, fence, info = parse_open(line)
			if fence then
				local lang = info:match("^%s*{?%.?([%w_+#-]+)")
				current = {
					lang = lang and lang:lower(),
					open = i,
					first = i + 1,
					indent = #indent,
					fence = fence,
				}
			end
		elseif is_close(line, current.fence) then
			current.close, current.last = i, i - 1
			table.insert(blocks, current)
			current = nil
		end
	end
	if current then
		current.close, current.last = #lines, #lines
		table.insert(blocks, current)
	end
	return blocks
end

-- What to run, as `code_lines, lang` (`lang` is nil for an untagged block) or
-- `nil, error_message`.
-- Without `range`: the block under the cursor line `cursor`. With
-- `range = { first, last }`: those lines, clamped to the first block they
-- touch (so a selection that includes the fences, or runs past them, still
-- yields only code).
function M.pick(lines, cursor, range)
	local from, to = cursor, cursor
	if range then
		from, to = range[1], range[2]
	end

	local block
	for _, b in ipairs(M.parse(lines)) do
		if b.open <= to and b.close >= from then
			block = b
			break
		end
	end
	if not block then
		return nil, "not in a fenced code block"
	end

	if range then
		from, to = math.max(from, block.first), math.min(to, block.last)
	else
		from, to = block.first, block.last
	end

	local code = {}
	for i = from, to do
		table.insert(code, dedent(lines[i], block.indent))
	end
	if vim.trim(table.concat(code)) == "" then
		return nil, "nothing to run"
	end
	return code, block.lang
end

local function in_tmux()
	return (vim.env.TMUX or "") ~= "" and (vim.env.TMUX_PANE or "") ~= "" and vim.fn.executable("tmux") == 1
end

local function tmux(args)
	return vim.system(vim.list_extend({ "tmux" }, args), { text = true }):wait()
end

local function run_in_tmux(argv, cwd)
	-- tmux execs a multi-argument command directly (no `default-shell`, which
	-- here is fish). The wrapper keeps the pane around once the block is done,
	-- or its output would vanish with it.
	local wrapper = {
		"sh",
		"-c",
		'"$@"; rc=$?; printf "\\n[exit %d] press Enter to close " "$rc"; read _',
		"sh",
	}
	local cmd = vim.list_extend(wrapper, argv)

	-- Reuse the runner pane; respawn fails once it has been closed. (Probing
	-- with display-message doesn't work: it exits 0 for a pane that's gone.)
	if M.pane and tmux(vim.list_extend({ "respawn-pane", "-k", "-t", M.pane, "-c", cwd }, cmd)).code == 0 then
		return
	end

	local res = tmux(vim.list_extend({
		"split-window",
		"-v",
		"-d", -- keep the focus in Neovim
		"-l",
		math.floor(M.size * 100) .. "%",
		"-t",
		vim.env.TMUX_PANE,
		"-c",
		cwd,
		"-P",
		"-F",
		"#{pane_id}",
	}, cmd))
	if res.code ~= 0 then
		vim.notify("MarkdownRun: tmux split-window failed\n" .. (res.stderr or ""), vim.log.levels.ERROR)
		return
	end
	M.pane = vim.trim(res.stdout)
end

local function run_in_split(argv, cwd)
	local buf = vim.api.nvim_create_buf(false, true)

	-- Reuse the runner window, unless something else was opened in it since.
	if M.win and vim.api.nvim_win_is_valid(M.win) and M.buf and vim.api.nvim_win_get_buf(M.win) == M.buf then
		local old = M.buf
		vim.api.nvim_win_set_buf(M.win, buf)
		vim.api.nvim_buf_delete(old, { force = true })
	else
		M.win = vim.api.nvim_open_win(buf, false, {
			split = "right",
			win = -1, -- the whole editor, not just the current window
			width = math.floor(vim.o.columns * M.size),
		})
	end
	M.buf = buf

	-- jobstart(term = true) turns the *current* buffer into the terminal.
	vim.api.nvim_buf_call(buf, function()
		vim.fn.jobstart(argv, { term = true, cwd = cwd })
	end)
end

-- Run the block under the cursor, or the lines `range = { first, last }`.
function M.run(range)
	local cursor = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	local code, lang = M.pick(lines, cursor, range)
	if not code then
		vim.notify("MarkdownRun: " .. lang, vim.log.levels.WARN)
		return
	end
	if not lang then
		vim.notify("MarkdownRun: the code block has no language", vim.log.levels.WARN)
		return
	end

	local interpreter = M.interpreters[lang]
	if not interpreter then
		vim.notify(("MarkdownRun: no interpreter for '%s'"):format(lang), vim.log.levels.WARN)
		return
	end
	if vim.fn.executable(interpreter) ~= 1 then
		vim.notify(("MarkdownRun: '%s' not found in PATH"):format(interpreter), vim.log.levels.ERROR)
		return
	end

	-- Cleaned up with Neovim's session temp dir at exit.
	local script = vim.fn.tempname()
	vim.fn.writefile(code, script)

	local argv, cwd = { interpreter, script }, vim.fn.getcwd()
	if in_tmux() then
		run_in_tmux(argv, cwd)
	else
		run_in_split(argv, cwd)
	end
end

vim.api.nvim_create_autocmd("FileType", {
	group = "config",
	pattern = "markdown",
	callback = function(ev)
		-- No range: the block under the cursor. With one (e.g. from a visual
		-- selection): just those lines of the block.
		vim.api.nvim_buf_create_user_command(ev.buf, "MarkdownRun", function(opts)
			M.run(opts.range > 0 and { opts.line1, opts.line2 } or nil)
		end, { range = true, desc = "Run a fenced code block in a terminal" })

		vim.keymap.set("n", "<leader>cr", "<cmd>MarkdownRun<CR>", { buffer = ev.buf, desc = "Run code block" })
		-- ":" in visual mode prefills the '<,'> range.
		vim.keymap.set("x", "<leader>cr", ":MarkdownRun<CR>", { buffer = ev.buf, desc = "Run selected code" })
	end,
})

return M
