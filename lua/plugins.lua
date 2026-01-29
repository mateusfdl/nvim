local lazy = require("lazy")

lazy.setup({
	{
		"mateusfdl/yetanotherline",
		config = function()
			require("yetanotherline").setup()
		end,
	},
	{
		"kyazdani42/nvim-web-devicons",
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
		"nvim-telescope/telescope.nvim",
		lazy = true,
		init = function()
			require("utils.startup").lazy_load("telescope.nvim")
		end,
		config = function()
			require("settings.telescope")
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
		config = function()
			require("settings.mason")
		end,
	},
	{
		"saghen/blink.cmp",
		lazy = true,
		event = "InsertEnter",
		config = function()
			require("settings.blink")
		end,
	},
	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
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
		event = "BufReadPre",
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
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		event = {
			"BufReadPre " .. vim.fn.expand("~") .. "/org/**/*.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/org/**/*.md",
		},
		cmd = {
			"ObsidianNew",
			"ObsidianNewNoteFromTemplate",
			"ObsidianOpen",
			"ObsidianSearch",
			"ObsidianQuickSwitch",
			"ObsidianToday",
			"ObsidianTemplate",
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("settings.obsidian")
		end,
	},
	{
		"NeogitOrg/neogit",
		cmd = { "Neogit" },
		lazy = true,
	},
	{
		"xvzc/chezmoi.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			cmd = {
				"ChezmoiEdit",
				"ChezmoiList",
			},
			config = function()
				require("settings.chezmoi").setup()
			end,
		},
	},
	{ "wakatime/vim-wakatime" },
	{
		"jim-at-jibba/nvim-stride",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = true,
		event = "InsertEnter",
		config = function()
			require("settings.ai")
		end,
	},
}, require("settings.lazy-setup"))

require("extensions.zettelkasten").setup()
