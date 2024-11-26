local M = {}

function M.attacher(client)
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false

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
			dynamicRegistration = true,
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
