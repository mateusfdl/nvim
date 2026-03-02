local M = {}

M.cmd = { "dart", "language-server", "--protocol=lsp" }

M.filetypes = { "dart" }

function M.on_attach(client, _)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
end

M.settings = {
	dart = {
		completeFunctionCalls = true,
		showTodos = true,
		analysisExcludedFolders = {
			vim.fn.expand("$HOME/.pub-cache"),
			vim.fn.expand("$HOME/fvm"),
		},
		updateImportsOnRename = true,
		enableSnippets = true,
	},
}

M.init_options = {
	closingLabels = true,
	flutterOutline = true,
	onlyAnalyzeProjectsWithOpenFiles = true,
	suggestFromUnimportedLibraries = true,
}

M.capabilities = {
	textDocument = {
		completion = {
			completionItem = {
				snippetSupport = true,
			},
		},
	},
}

return M
