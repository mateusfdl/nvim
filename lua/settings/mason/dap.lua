local mason_nvim_dap = require("mason-nvim-dap")

mason_nvim_dap.setup({
	ensure_installed = {
		"delve",
		"js-debug-adapter",
		"lua-debug-adapter",
		"nlua",
		"codelldb",
		"cpptools",
	},
	automatic_installation = true,
})
