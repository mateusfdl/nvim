local M = {}

local bin = vim.system({ "which", "sourcekit-lsp" }):wait().stdout:gsub("\n", "")
M.cmd = { bin }
M.filetypes = { "swift", "objc", "objcpp" }

M.capabilities = {
	workspace = {
		didChangeWatchedFiles = {
			dynamicRegistration = true,
		},
	},
}

return M
