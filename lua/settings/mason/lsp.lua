local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = {},
	automatic_installation = false,
	handlers = nil,
})

local function default_on_attach(client, bufnr)
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end

	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local loaded_servers = {}

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
}

local function ensure_server_installed(server_name)
	if loaded_servers[server_name] then
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

	loaded_servers[server_name] = true
	return true
end

local function find_root_dir(patterns, file_path)
	local current_dir = vim.fn.fnamemodify(file_path, ":h")

	while current_dir ~= "/" do
		for _, pattern in ipairs(patterns) do
			if vim.fn.glob(current_dir .. "/" .. pattern) ~= "" then
				return current_dir
			end
		end
		current_dir = vim.fn.fnamemodify(current_dir, ":h")
	end

	return vim.fn.getcwd()
end

local function get_root_dir(server_info, file_path)
	if server_info.config.root_dir then
		return server_info.config.root_dir(file_path)
	end
	return find_root_dir(server_info.root_patterns, file_path)
end

local server_configs = {
	ts_ls = {
		config = require("settings.lsp.ts_ls"),
		filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
		root_patterns = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	},
	solargraph = {
		config = require("settings.lsp.solargraph"),
		filetypes = { "ruby" },
		root_patterns = { "Gemfile", ".git" },
	},
	gopls = {
		config = require("settings.lsp.golang"),
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_patterns = { "go.mod", "go.work", ".git" },
	},
	lua_ls = {
		config = require("settings.lsp.lua"),
		filetypes = { "lua" },
		root_patterns = {
			".luarc.json",
			".luarc.jsonc",
			".luacheckrc",
			".stylua.toml",
			"stylua.toml",
			"selene.toml",
			"selene.yml",
			".git",
		},
	},
	bashls = {
		config = require("settings.lsp.bash"),
		filetypes = { "bash", "sh" },
		root_patterns = { ".git" },
	},
	clangd = {
		config = require("settings.lsp.clangd"),
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		root_patterns = {
			".clangd",
			".clang-tidy",
			".clang-format",
			"compile_commands.json",
			"compile_flags.txt",
			".git",
		},
	},
	elixirls = {
		config = require("settings.lsp.elixir"),
		filetypes = { "elixir", "eelixir" },
		root_patterns = { "mix.exs", ".git" },
	},
	jsonls = {
		config = require("settings.lsp.json"),
		filetypes = { "json", "jsonc" },
		root_patterns = { ".git" },
	},
	tailwindcss = {
		config = require("settings.lsp.tailwind"),
		filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
		root_patterns = { "tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs", "tailwind.config.mjs" },
		conditional_setup = function(file_path)
			local root_dir = find_root_dir(
				{ "tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs", "tailwind.config.mjs" },
				file_path
			)
			return root_dir ~= vim.fn.getcwd() or vim.fn.glob(root_dir .. "/tailwind.config.*") ~= ""
		end,
	},
	sourcekit = {
		config = require("settings.lsp.sourcekit"),
		filetypes = { "swift" },
		root_patterns = { "Package.swift", ".git" },
		skip_install = true,
	},
	hls = {
		config = require("settings.lsp.haskell"),
		filetypes = { "haskell", "lhaskell" },
		root_patterns = { "*.cabal", "stack.yaml", "cabal.project", ".git" },
	},
	rust_analyzer = {
		config = require("settings.lsp.rust"),
		filetypes = { "rust" },
		root_patterns = { "Cargo.toml", "Cargo.lock", ".git" },
	},
}

local function setup_lsp_server(server_name, server_info, bufnr)
	local server_config = server_info.config
	local file_path = vim.api.nvim_buf_get_name(bufnr)

	if server_info.conditional_setup and not server_info.conditional_setup(file_path) then
		return
	end

	if not server_info.skip_install and not ensure_server_installed(server_name) then
		vim.defer_fn(function()
			setup_lsp_server(server_name, server_info, bufnr)
		end, 1000)
		return
	end

	local root_dir = get_root_dir(server_info, file_path)
	local merged_capabilities = vim.tbl_deep_extend("force", capabilities, server_config.capabilities or {})

	local combined_on_attach = function(client, buf)
		default_on_attach(client, buf)
		if server_config.on_attach then
			server_config.on_attach(client, buf)
		end
	end

	vim.lsp.start({
		name = server_name,
		cmd = server_config.cmd,
		root_dir = root_dir,
		capabilities = merged_capabilities,
		on_attach = combined_on_attach,
		settings = server_config.settings,
		init_options = server_config.init_options,
	})
end

for server_name, server_info in pairs(server_configs) do
	vim.api.nvim_create_autocmd("FileType", {
		pattern = server_info.filetypes,
		callback = function(args)
			setup_lsp_server(server_name, server_info, args.buf)
		end,
	})
end
