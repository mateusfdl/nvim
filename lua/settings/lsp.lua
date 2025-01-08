local group = vim.api.nvim_create_augroup("LazyTreesitterLoad", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	group = group,
	callback = function()
		local buf_name = vim.api.nvim_buf_get_name(0)
		-- Load only if the buffer is not [No Name]
		if buf_name ~= "" then
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local ruby = require("settings.lsp.solargraph")
			local ts = require("settings.lsp.tsserver")
			local go = require("settings.lsp.golang")
			local haskell = require("settings.lsp.haskell")
			local lua = require("settings.lsp.lua")
			local c = require("settings.lsp.clangd")
			local elixir = require("settings.lsp.elixir")
			local json = require("settings.lsp.json")
			local tailwind = require("settings.lsp.tailwind")
			local sourcekit = require("settings.lsp.sourcekit")

			local servers = {
				ts_ls = ts,
				solargraph = ruby,
				gopls = go,
				hls = haskell,
				lua_ls = lua,
				clangd = c,
				elixirls = elixir,
				jsonls = json,
				tailwindcss = tailwind,
				sourcekit = sourcekit,
			}

			for lsp, config in pairs(servers) do
				vim.schedule(function()
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
	end,
})
