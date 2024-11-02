local M = {}

M.filetypes = { "swift", "objc", "objcpp" }

M.capabilities = {
	workspace = {
		didChangeWatchedFiles = {
			dynamicRegistration = true,
		},
	},
}

return M
