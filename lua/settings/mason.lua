local mason = require("mason")

mason.setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	},
	install_root_dir = vim.fn.stdpath("data") .. "/mason",
	PATH = "skip",
	pip = {
		upgrade_pip = false,
		install_args = {},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
	registries = {
		"github:mason-org/mason-registry",
	},
	providers = {
		"mason.providers.registry-api",
		"mason.providers.client",
	},
})

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 4,
	},
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
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
})