-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml" },
	settings = {
		["rust-analyzer"] = {
			check = { command = "clippy" },
			cargo = { allFeatures = true },
		},
	},
}
