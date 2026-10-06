-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Settings restoration at Vim entering
vim.api.nvim_create_autocmd("VimEnter", {
	group = "config",
	callback = function()
		vim.opt.relativenumber = vim.g.RELATIVENUMBER
	end,
})

-- Built-in treesitter highlighting for every filetype with a parser
-- (Neovim bundles c, lua, markdown, query, vim, vimdoc); pcall skips the rest.
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("pack-treesitter", { clear = true }),
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})


-- Auto Reload or Refresh buffers when files is modified externaly.
-- Throttled; FocusGained always checks.
-- TODO: move the cooldown into options.lua (#44)
local checktime_cooldown = 2000
local checktime_last = 0
vim.api.nvim_create_autocmd(
	{ "FocusGained", "TermClose", "TermLeave", "BufEnter", "CursorHold", "CursorHoldI" },
	{
		group = vim.api.nvim_create_augroup("checktime", { clear = true }),
		callback = function(ev)
			local now = vim.uv.now()
			if ev.event ~= "FocusGained" and now - checktime_last < checktime_cooldown then
				return
			end
			checktime_last = now
			if vim.o.buftype ~= "nofile" and vim.fn.mode() ~= "c" then
				vim.cmd("checktime")
			end
		end,
	}
)
