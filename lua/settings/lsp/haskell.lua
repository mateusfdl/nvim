local M = {}

function M.on_attach(client)
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false
end

M.cmd = { vim.fn.stdpath("data") .. "/mason/bin/haskell-language-server-wrapper", "--lsp" }
M.settings = {
	haskell = {
		formattingProvider = "stylish-haskell",
		[[ formattingProvider = "",
				cabalFormattingProvider = "cabalfmt", ]],
	},
}

return M
