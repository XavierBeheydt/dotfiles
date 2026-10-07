-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- The terminal a block runs in: a tmux pane when inside tmux, a Neovim split
-- otherwise. One runner is kept and reused, so running another block
-- replaces the previous one instead of piling up panes, unless the
-- orientation changes: then the runner is reopened the other way.

local config = require("languages.markdown.config")

local M = {}

-- State of the current runner: M.pane (tmux) or M.win + M.buf (split), and
-- M.vertical, the orientation it was opened with.

local function in_tmux()
	return (vim.env.TMUX or "") ~= "" and (vim.env.TMUX_PANE or "") ~= "" and vim.fn.executable("tmux") == 1
end

local function tmux(args)
	return vim.system(vim.list_extend({ "tmux" }, args), { text = true }):wait()
end

local function run_in_tmux(argv, cwd, vertical)
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

	if M.pane then
		-- Reuse the runner pane; respawn fails once it has been closed.
		-- (Probing with display-message doesn't work: it exits 0 for a pane
		-- that's gone.)
		if
			M.vertical == vertical
			and tmux(vim.list_extend({ "respawn-pane", "-k", "-t", M.pane, "-c", cwd }, cmd)).code == 0
		then
			return
		end
		-- Other orientation, or gone: start over.
		tmux({ "kill-pane", "-t", M.pane })
		M.pane = nil
	end

	local res = tmux(vim.list_extend({
		"split-window",
		-- tmux names it the other way round: -h puts the panes side by side
		-- (Vim's :vsplit), -v stacks them (Vim's :split).
		vertical and "-h" or "-v",
		"-d", -- keep the focus in Neovim
		"-l",
		math.floor(config.options.size * 100) .. "%",
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
	M.pane, M.vertical = vim.trim(res.stdout), vertical
end

local function run_in_split(argv, cwd, vertical)
	local buf = vim.api.nvim_create_buf(false, true)

	-- The runner window, unless something else was opened in it since.
	local win
	if M.win and vim.api.nvim_win_is_valid(M.win) and vim.api.nvim_win_get_buf(M.win) == M.buf then
		win = M.win
	end

	if win and M.vertical == vertical then
		vim.api.nvim_win_set_buf(win, buf)
		vim.api.nvim_buf_delete(M.buf, { force = true })
	else
		if win then -- other orientation: start over
			vim.api.nvim_win_close(win, true)
			vim.api.nvim_buf_delete(M.buf, { force = true })
		end
		local win_config = { win = -1 } -- the whole editor, not just the current window
		if vertical then
			win_config.split, win_config.width = "right", math.floor(vim.o.columns * config.options.size)
		else
			win_config.split, win_config.height = "below", math.floor(vim.o.lines * config.options.size)
		end
		M.win = vim.api.nvim_open_win(buf, false, win_config)
	end
	M.buf, M.vertical = buf, vertical

	-- jobstart(term = true) turns the *current* buffer into the terminal.
	vim.api.nvim_buf_call(buf, function()
		vim.fn.jobstart(argv, { term = true, cwd = cwd })
	end)
end

-- Run `argv` from `cwd` in the runner, below (or on the right if `vertical`).
function M.run(argv, cwd, vertical)
	if in_tmux() then
		run_in_tmux(argv, cwd, vertical)
	else
		run_in_split(argv, cwd, vertical)
	end
end

return M
