local M = {}

M.languages = {
	"cpp",
	"c",
	"bash",
	"lua",
	"rust",
	"json",
	"ruby",
	"go",
	"typescript",
	"javascript",
	"proto",
	"elixir",
	"tsx",
	"yaml",
	"css",
	"html",
	"scss",
	"haskell",
	"toml",
	"vimdoc",
	"luadoc",
	"vim",
	"markdown",
	"scheme",
	"python",
	"java",
	"swift",
	"query",
	"zig",
	"qmljs",
	"cmake",
}

require("nvim-treesitter.configs").setup({
	ensure_installed = M.languages,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	refactor = {
		highlight_definitions = { enable = true },
		highlight_current_scope = { enable = true },
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "+",
			node_incremental = "+",
			node_decremental = "-",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
				["]a"] = {
					query = {
						"@receiver",
						"@method.name",
						"@string.arg",
						"@identifier.arg",
						"@composite.arg",
					},
					desc = "Jump to next chained function or parameter",
				},
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
				["[a"] = {
					query = {
						"@receiver",
						"@method.name",
						"@string.arg",
						"@identifier.arg",
						"@composite.arg",
					},
					desc = "Jump to previous chained function or parameter",
				},
			},
		},
	},
	context_commentstring = { enable = true },
	endwise = { enable = true },
	autotag = { enable = true },
})
