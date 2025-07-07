local M = {}

M.cmd = { vim.fn.stdpath("data") .. "/mason/bin/sourcekit-lsp" }

M.filetypes = { "swift", "objc", "objcpp" }

M.capabilities = {
	workspace = {
		didChangeWatchedFiles = {
			dynamicRegistration = true,
		},
	},
}

return M
