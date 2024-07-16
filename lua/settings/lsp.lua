local capabilities = require("cmp_nvim_lsp").default_capabilities()

local ruby = require("settings.lsp.solargraph")
local ts = require("settings.lsp.tsserver")
local go = require("settings.lsp.golang")
local haskell = require("settings.lsp.haskell")
local rust = require("settings.lsp.rust")
local lua = require("settings.lsp.lua")
local c = require("settings.lsp.clangd")
local elixir = require("settings.lsp.elixir")
local json = require("settings.lsp.json")
local tailwind = require("settings.lsp.tailwind")

local servers = {
	tsserver = ts,
	solargraph = ruby,
	gopls = go,
	rust_analyzer = rust,
	hls = haskell,
	lua_ls = lua,
	clangd = c,
	elixirls = elixir,
	jsonls = json,
	tailwindcss = tailwind,
}

function add_capabilities()
	for lsp, config in pairs(servers) do
		require("lspconfig")[lsp].setup({
			capabilities = capabilities,
			on_attach = config.on_attach,
			cmd = config.cmd,
			settings = config.settings,
			filetypes = config.filetypes,
		})
	end
end

add_capabilities()
