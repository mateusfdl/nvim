local lazy = require("lazy")

lazy.setup({
	{
		"glepnir/galaxyline.nvim",
		config = function()
			require("settings.status-line")
		end,
	},
	-- {
	-- 	dir = "~/codes/yetanotherline/",
	-- 	config = function()
	-- 		require("yetanotherline").setup()
	-- 	end,
	-- },
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
		event = "BufEnter",
		config = function()
			require("settings.nvim-treesitter")
		end,
	},
	{
		"nvim-lua/popup.nvim",
		event = "BufReadPre",
		init = function()
			require("utils.startup").lazy_load("popup.nvim")
		end,
	},
	{
		"nvim-lua/plenary.nvim",
	},
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
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = { "hrsh7th/vim-vsnip" },
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("settings.cmp")
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
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
		event = "BufReadPre",
		init = function()
			require("utils.startup").lazy_load("lsp-colors.nvim")
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
		"folke/neodev.nvim",
		event = "BufReadPre",
	},
	{
		"wakatime/vim-wakatime",
		event = { "BufReadPre", "BufWritePost", "InsertEnter" },
	},
	{
		"zbirenbaum/copilot.lua",
		event = { "BufReadPre", "BufWritePost", "InsertEnter" },
		config = function()
			require("settings.copilot")
		end,
	},
	{
		"hrsh7th/vim-vsnip",
		event = { "InsertEnter" },
	},
	{
		"hrsh7th/cmp-vsnip",
		event = { "InsertEnter" },
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
		"NeogitOrg/neogit",
		event = "BufReadPre",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
			"ibhagwan/fzf-lua",
		},
		init = function()
			require("neogit").setup()
		end,
		config = true,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("settings.colorizer")
		end,
	},
	{
		"David-Kunz/cmp-npm",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "InsertEnter",
		ft = "json",
		config = function()
			require("settings.cmp-npm")
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		event = "BufReadPre",
		ft = "rust",
		config = function()
			require("settings.lsp.rust")
		end,
	},
}, require("settings.lazy-setup"))
