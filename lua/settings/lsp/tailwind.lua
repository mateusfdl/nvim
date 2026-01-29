local M = {}

M.cmd = { vim.fn.stdpath("data") .. "/mason/bin/tailwindcss-language-server", "--stdio" }

local capabilities = require("blink.cmp").get_lsp_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.colorProvider = { dynamicRegistration = false }
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
M.capabilities = capabilities

M.on_attach = function(client, bufnr)
	if client.server_capabilities.colorProvider then
		require("utils.document-colors").buf_attach(bufnr)
		require("colorizer").attach_to_buffer(
			bufnr,
			{ mode = "background", css = true, names = false, tailwind = false }
		)
	end
end

M.settings = {
	tailwindCSS = {
		lint = {
			cssConflict = "warning",
			invalidApply = "error",
			invalidConfigPath = "error",
			invalidScreen = "error",
			invalidTailwindDirective = "error",
			invalidVariant = "error",
			recommendedVariantOrder = "warning",
		},
		experimental = {
			classRegex = {
				"tw`([^`]*)",
				'tw="([^"]*)',
				'tw={"([^"}]*)',
				"tw\\.\\w+`([^`]*)",
				"tw\\(.*?\\)`([^`]*)",
				{ "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
				{ "classnames\\(([^)]*)\\)", "'([^']*)'" },
				{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
				{ "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
			},
		},
		validate = true,
	},
}
M.filetypes = { "html", "mdx", "javascriptreact", "typescriptreact", "vue", "svelte" }

return M
