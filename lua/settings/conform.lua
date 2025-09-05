require("conform").setup({
	formatters_by_ft = {
		typescript = { "biome", "prettier", stop_after_first = true },
		javascript = { "biome", "prettier", stop_after_first = true },
		ruby = { "rubocop" },
		lua = { "stylua" },
		vue = { "prettier" },
		swift = { "swiftformat" },
		c = { "clangd" },
		cpp = { "clangd" },
		go = { "gofmt" },
		zig = { "zig_fmt" },
	},
	formatters = {
		biome = {
			require_cwd = true,
		},
		["biome-check"] = {
			require_cwd = true,
		},
		prettier = {
			require_cwd = true,
			options = {
				ft_parsers = {
					json = "json",
				},
			},
		},
	},
})
