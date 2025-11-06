local M = {}
local mason_lsp = require("settings.mason.lsp")
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local md_namespace = vim.api.nvim_create_namespace("matheus/lsp_float")

local function merge_capabilities(extra)
	return vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_capabilities, extra or {})
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

local function setup_diagnostics()
	vim.diagnostic.config({
		virtual_text = { prefix = "●", spacing = 4 },
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.INFO] = "",
				[vim.diagnostic.severity.HINT] = "",
			},
		},
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "none",
			source = true,
			header = "",
			prefix = "",
		},
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		delay = 50,
		max_width = 80,
		max_height = 20,
	})
end

local function enhanced_float_handler(handler)
	return function(err, result, ctx, config)
		if err then
			vim.notify("LSP hover error: " .. vim.inspect(err), vim.log.levels.ERROR)
			return
		end
		if not (result and result.contents) then
			vim.notify("No hover content", vim.log.levels.DEBUG)
			return
		end

		local buf, win = handler(
			err,
			result,
			ctx,
			vim.tbl_deep_extend("force", config or {}, {
				border = "none",
				max_height = math.floor(vim.o.lines * 0.5),
				max_width = math.floor(vim.o.columns * 0.4),
			})
		)
		if not buf or not win then
			return
		end

		vim.wo[win].concealcursor = "n"

		for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
			for pattern, hl_group in pairs({
				["|%S-|"] = "@text.reference",
				["@%S+"] = "@parameter",
				["^%s*(Parameters:)"] = "@text.title",
				["^%s*(Return:)"] = "@text.title",
				["^%s*(See also:)"] = "@text.title",
				["{%S-}"] = "@parameter",
			}) do
				local from = 1
				while from do
					local to
					from, to = line:find(pattern, from)
					if from then
						vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
							end_col = to,
							hl_group = hl_group,
						})
					end
					from = to and to + 1 or nil
				end
			end
		end

		if not vim.b[buf].markdown_keys then
			vim.keymap.set("n", "K", function()
				local url = (vim.fn.expand("<cWORD>")):match("|(%S-)|")
				if url then
					return vim.cmd.help(url)
				end
				local col = vim.api.nvim_win_get_cursor(0)[2] + 1
				local from, to
				from, to, url = vim.api.nvim_get_current_line():find("%[.-%]%((%S-)%)")
				if from and col >= from and col <= to then
					vim.system({ "open", url }, nil, function(res)
						if res.code ~= 0 then
							vim.notify("Failed to open URL " .. url, vim.log.levels.ERROR)
						end
					end)
				end
			end, { buffer = buf, silent = true })
			vim.b[buf].markdown_keys = true
		end
	end
end

local function on_attach(client, bufnr)
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end

	if client.server_capabilities.documentHighlightProvider then
		local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
		vim.api.nvim_create_autocmd({ "CursorHold" }, {
			group = group,
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = group,
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end

	if
		client.server_capabilities.semanticTokensProvider
		and type(client.server_capabilities.semanticTokensProvider) == "table"
	then
		if
			client.server_capabilities.semanticTokensProvider.full
			and type(client.server_capabilities.semanticTokensProvider.full) == "table"
		then
			client.server_capabilities.semanticTokensProvider.full.delta = true
		end
	end
end

local function setup_lsp_server(server_name, server_info, bufnr)
	local server_config = server_info.config
	local file_path = vim.api.nvim_buf_get_name(bufnr)

	if server_info.conditional_setup and not server_info.conditional_setup(file_path) then
		return
	end
	if not mason_lsp.ensure_server_installed(server_name) then
		vim.defer_fn(function()
			setup_lsp_server(server_name, server_info, bufnr)
		end, 1000)
		return
	end

	local root_dir = get_root_dir(server_info, file_path)
	local merged_caps = merge_capabilities(server_config.capabilities)

	local combined_on_attach = function(client, buf)
		on_attach(client, buf)
		if server_config.on_attach then
			server_config.on_attach(client, buf)
		end
	end

	vim.lsp.start({
		name = server_name,
		cmd = server_config.cmd,
		root_dir = root_dir,
		capabilities = merged_caps,
		on_attach = combined_on_attach,
		settings = server_config.settings,
		init_options = server_config.init_options,
		flags = {
			debounce_text_changes = 150,
			allow_incremental_sync = true,
		},
	})
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
	zls = {
		config = require("settings.lsp.zig"),
		filetypes = { "zig" },
		root_patterns = { "build.zig", ".git" },
	},
	qmlls = {
		config = require("settings.lsp.qmlls"),
		filetypes = { "qml", "qmljs" },
		root_patterns = { "CMakeLists.txt", "*.pro", "*.qmlproject", ".git" },
	},
}

local function setup_lsp_autocmds()
	for server_name, server_info in pairs(server_configs) do
		vim.api.nvim_create_autocmd("FileType", {
			pattern = server_info.filetypes,
			callback = function(args)
				local buf_name = vim.api.nvim_buf_get_name(args.buf)
				if buf_name ~= "" then
					setup_lsp_server(server_name, server_info, args.buf)
				end
			end,
		})
	end
end

local function ensure_lsp_attached_to_current_buffer()
	local current_buf = vim.api.nvim_get_current_buf()
	local buf_name = vim.api.nvim_buf_get_name(current_buf)
	local filetype = vim.bo[current_buf].filetype

	if buf_name == "" or filetype == "" then
		return
	end

	local clients = vim.lsp.get_clients({ bufnr = current_buf })
	if #clients > 0 then
		return
	end

	for server_name, server_info in pairs(server_configs) do
		for _, ft in ipairs(server_info.filetypes) do
			if ft == filetype then
				setup_lsp_server(server_name, server_info, current_buf)
				break
			end
		end
	end
end

vim.defer_fn(function()
	ensure_lsp_attached_to_current_buffer()
end, 100)

setup_lsp_autocmds()

setup_diagnostics()

function M.hover()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })

	if #clients == 0 then
		vim.notify("No active LSP client for this buffer", vim.log.levels.WARN)
		return
	end

	local client = clients[1]
	local params = vim.lsp.util.make_position_params(0, client.offset_encoding)

	vim.lsp.buf_request(
		bufnr,
		vim.lsp.protocol.Methods.textDocument_hover,
		params,
		enhanced_float_handler(vim.lsp.handlers.hover)
	)
end

return M
