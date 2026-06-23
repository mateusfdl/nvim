local lazy = require("lazy")

lazy.setup({
	{
		"mateusfdl/yetanotherline",
		event = "UIEnter",
		config = function()
			require("yetanotherline").setup()
		end,
	},
	{
		"kyazdani42/nvim-web-devicons",
		lazy = true,
		config = function()
			require("settings.devicons")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		lazy = true,
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			require("settings.treesitter")
		end,
		init = require("utils.startup").lazy_load("nvim-treesitter"),
	},
	{ "nvim-lua/plenary.nvim" },
	{
		"folke/snacks.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			picker = {},
		},
	},
	{
		"dmtrKovalenko/fff.nvim",
		build = function()
			require("fff.download").download_or_build_binary()
		end,
		lazy = false,
		config = function()
			require("settings.fff")
		end,
	},
	{
		"christoomey/vim-tmux-runner",
		ft = "ruby",
		config = function()
			require("settings.tmux-runner")
		end,
	},
	{
		"tpope/vim-surround",
		event = "BufReadPre",
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonLog", "MasonUninstall", "MasonUninstallAll" },
		config = function()
			require("settings.mason")
		end,
	},
	{
		"saghen/blink.cmp",
		lazy = true,
		event = "InsertEnter",
		version = "1.*",
		config = function()
			require("settings.blink")
		end,
	},
	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {},
			disable_filetype = { "vim" },
		},
		event = "BufReadPre",
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		lazy = true,
		init = function()
			require("utils.startup").lazy_load("mason-lspconfig.nvim")
		end,
		config = function()
			require("settings.lsp")
		end,
	},
	{
		"voldikss/vim-floaterm",
		event = "VeryLazy",
		config = function()
			require("settings.float-term")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		keys = {
			{ mode = "n", "<Leader>o", ":NvimTreeToggle<CR>" },
			{ mode = "n", "<Leader>O", ":NvimTreeFindFileToggle<CR>" },
			{ mode = "n", "<leader>r", ":NvimTreeRefresh<CR>" },
			{ mode = "n", "<leader>n", ":NvimTreeFindFile<CR>" },
		},
		config = function()
			require("settings.tree")
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"stevearc/conform.nvim",
		event = "BufReadPre",
		config = function()
			require("settings.conform")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		event = "BufReadPre",
		config = function()
			require("settings.buffer-line")
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"mfussenegger/nvim-lint",
		event = "BufReadPre",
		init = function()
			vim.api.nvim_create_autocmd({ "TextChanged" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
		config = function()
			require("settings.lint")
		end,
		lazy = true,
		ft = function()
			return require("settings.lint").file_types()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = function()
			require("settings.gitsigns")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		lazy = true,
		init = require("utils.startup").lazy_load("nvim-colorizer.lua"),
		config = function()
			require("settings.colorizer")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		cmd = {
			"DapToggleBreakpoint",
			"DapContinue",
			"DapRunToCursor",
			"DapStepInto",
			"DapStepOver",
			"DapStepOut",
			"DapStepBack",
			"DapRestart",
			"DapTerminate",
			"DapDisconnect",
		},
		dependencies = {
			{
				"jay-babu/mason-nvim-dap.nvim",
				cmd = { "DapInstall", "DapUninstall" },
				dependencies = { "williamboman/mason.nvim" },
				config = function()
					require("settings.mason.dap")
				end,
			},
			{ "rcarriga/nvim-dap-ui" },
			{ "theHamsta/nvim-dap-virtual-text", config = true },
			{ "leoluz/nvim-dap-go" },
			{ "mxsdev/nvim-dap-vscode-js" },
			{ "nvim-neotest/nvim-nio" },
			{ "jbyuki/one-small-step-for-vimkind" },
		},
		config = function()
			require("settings.dap")
		end,
	},
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		lazy = true,
		event = {
			"BufReadPre " .. vim.fn.getenv("NOTES_VAULT") .. "/**/*.md",
			"BufNewFile " .. vim.fn.getenv("NOTES_VAULT") .. "/**/*.md",
		},
		cmd = { "Obsidian" },
		config = function()
			require("settings.obsidian")
		end,
	},
	{
		"wakatime/vim-wakatime",
		event = "VeryLazy",
		config = function()
			require("wakatime").setup({ plugin_name = "vim-wakatime" })
		end,
	},
}, require("settings.lazy-setup"))

require("extensions.zettelkasten").setup()
require("tdw").setup()
