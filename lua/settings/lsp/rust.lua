local M = {}

M.cmd = { vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer" }

M.settings = {
	["rust-analyzer"] = {
		assist = {
			importEnforceGranularity = true,
			importPrefix = "crate",
		},
		cargo = {
			allFeatures = true,
		},
		checkOnSave = {
			command = "clippy",
		},
		inlayHints = {
			lifetimeElisionHints = {
				enable = false,
				useParameterNames = true,
			},
		},
	},
}

M.on_attach = function(_, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>rr", function()
		vim.cmd("!cargo run")
	end, opts)
	vim.keymap.set("n", "<leader>rt", function()
		vim.cmd("!cargo test")
	end, opts)
	vim.keymap.set("n", "<leader>rc", function()
		vim.cmd("!cargo check")
	end, opts)
end

return M
