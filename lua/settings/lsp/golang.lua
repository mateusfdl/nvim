local M = {}

M.cmd = { vim.fn.stdpath("data") .. "/mason/bin/gopls" }

function M.on_attach(client, _)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
end

M.settings = {
	gopls = {
		analyses = {
			unusedparams = true,
		},
		staticcheck = true,
	},
}

M.capabilities = {
	workspace = {
		didChangeWatchedFiles = {
			-- for some reason its frozens VIM
			dynamicRegistration = false,
		},
	},
	textDocument = {
		completion = {
			completionItem = {
				snippetSupport = true,
			},
		},
	},
}

return M
