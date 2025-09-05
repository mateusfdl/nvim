local M = {}
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = {},
	automatic_installation = false,
	handlers = nil,
})

M.loaded_servers = {}

local mason_package_names = {
	ts_ls = "typescript-language-server",
	solargraph = "solargraph",
	gopls = "gopls",
	lua_ls = "lua-language-server",
	bashls = "bash-language-server",
	clangd = "clangd",
	elixirls = "elixir-ls",
	jsonls = "json-lsp",
	tailwindcss = "tailwindcss-language-server",
	hls = "haskell-language-server",
	rust_analyzer = "rust-analyzer",
	zls = "zls",
}

function M.ensure_server_installed(server_name)
	if M.loaded_servers[server_name] then
		return true
	end

	local mason_registry = require("mason-registry")
	local package_name = mason_package_names[server_name] or server_name

	if not mason_registry.has_package(package_name) then
		vim.notify("Mason package '" .. package_name .. "' not found for " .. server_name, vim.log.levels.ERROR)
		return false
	end

	local server_package = mason_registry.get_package(package_name)

	if not server_package:is_installed() then
		vim.notify("Installing " .. package_name .. "...", vim.log.levels.INFO)
		server_package:install()
		return false
	end

	M.loaded_servers[server_name] = true
	return true
end

return M
