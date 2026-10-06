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

