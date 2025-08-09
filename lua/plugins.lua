local lazy = require("lazy")

lazy.setup({
	{
		-- "mateusfdl/schadenfreude.nvim",
		dir = "~/Documents/codes/schadenfreude.nvim",
		config = function()
			require("settings.schadenfreude")
		end,
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "rcarriga/nvim-notify" },
	},
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
	{
		"nvim-lua/popup.nvim",
		event = "BufReadPre",
		init = function()
			require("utils.startup").lazy_load("popup.nvim")
		end,
	},
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
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
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("settings.mason.lsp")
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		config = function()
			require("settings.mason.dap")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		init = require("utils.startup").lazy_load("nvim-cmp"),
		config = function()
			require("settings.cmp")
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-vsnip",
		},
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

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"folke/lsp-colors.nvim",
		lazy = true,
		init = require("utils.startup").lazy_load("lsp-colors.nvim"),
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
		"hrsh7th/vim-vsnip",
		lazy = true,
		init = require("utils.startup").lazy_load("vim-vsnip"),
	},
	{
		"hrsh7th/cmp-vsnip",
		lazy = true,
		init = require("utils.startup").lazy_load("cmp-vsnip"),
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
		dependencies = {
			"leoluz/nvim-dap-go",
			"mxsdev/nvim-dap-vscode-js",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"jbyuki/one-small-step-for-vimkind",
		},
		config = function()
			require("settings.dap")
		end,
		lazy = true,
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
		"wojciech-kulik/xcodebuild.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		lazy = true,
		ft = "swift",
		config = function()
			require("settings.xcodebuild")
		end,
	},
}, require("settings.lazy-setup"))
