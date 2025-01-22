local M = {}
M.lsp_clients = {}

local async = require("plenary.async")

function M.setup_lsp_servers()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	local lsp_configs = {
		ts_ls = require("settings.lsp.ts_ls"),
		solargraph = require("settings.lsp.solargraph"),
		gopls = require("settings.lsp.golang"),
		hls = require("settings.lsp.haskell"),
		lua_ls = require("settings.lsp.lua"),
		clangd = require("settings.lsp.clangd"),
		elixirls = require("settings.lsp.elixir"),
		jsonls = require("settings.lsp.json"),
		tailwindcss = require("settings.lsp.tailwind"),
		sourcekit = require("settings.lsp.sourcekit"),
	}

	for lsp, config in pairs(lsp_configs) do
		async.run(function()
			require("lspconfig")[lsp].setup({
				capabilities = capabilities,
				on_attach = config.on_attach,
				cmd = config.cmd,
				settings = config.settings,
				filetypes = config.filetypes,
				init_options = config.init_options,
			})
		end)
	end
end

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		async.run(M.setup_lsp_servers)
	end,
})

return M
