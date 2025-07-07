local M = {}

M.cmd = { vim.fn.stdpath("data") .. "/mason/bin/lua-language-server" }

M.settings = {
	Lua = {
		diagnostics = {
			globals = { "vim", "describe", "it", "before_each", "after_each", "packer_plugins" },
		},
		workspace = {
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("$VIMRUNTIME/pack")] = true,
				[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
			},
			maxPreload = 100000,
			preloadFileSize = 10000,
		},
	},
}

return M
