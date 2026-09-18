-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-- Settings restoration at Vim entering
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.opt.relativenumber = vim.g.RELATIVENUMBER
	end,
})
