local lazy = require("lazy")

lazy.setup({
	{
		"glepnir/galaxyline.nvim",
		config = function()
			require("settings.status-line")
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
		event = "BufEnter",
		config = function()
			require("settings.nvim-treesitter")
		end,
	},
	{
		"nvim-lua/popup.nvim",
		init = function()
			require("utils.startup").lazy_load("popup.nvim")
		end,
	},
	{
		"nvim-lua/plenary.nvim",
		init = function()
			require("utils.startup").lazy_load("plenary.nvim")
		end,
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
		lazy = true,
		config = function()
			require("settings.tmux-runner")
		end,
	},
	{
		"tpope/vim-surround",
		event = "BufEnter",
	},
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		lazy = true,
		init = function()
			require("utils.startup").lazy_load("nvim-lspconfig")
		end,
		config = function()
			require("settings.lsp")
			require("settings.diagnostics")
		end,
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
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)

      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'folke/lsp-colors.nvim',
    event = "InsertEnter",
    init = function()
      require("utils.startup").lazy_load "lsp-colors.nvim"
    end,
  },
  {
    'voldikss/vim-floaterm',
    event = "VeryLazy",
    config = function()
      require("settings.float-term")
    end
  },
  {
    "nvim-neorg/neorg",
    lazy = true,
    dependencies = { "luarocks.nvim" },
    config = function()
      require("settings.neorg")
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      require("utils.startup").lazy_load "nvim-tree.lua"
    end,
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
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    "folke/neodev.nvim",
    lazy = true,
  },
  {
    'wakatime/vim-wakatime',
    lazy = true,
    cmd = { "BufEnter", "BufWritePost", "InsertEnter" },
  },
  {
    'zbirenbaum/copilot.lua',
    lazy = true,
    cmd = { "BufEnter", "BufWritePost", "InsertEnter" },
    config = function()
      require("settings.copilot")
    end
  },
  {
    'hrsh7th/vim-vsnip',
    cmd = { "BufEnter", "BufWritePost", "InsertEnter" },
  },
  {
    'stevearc/conform.nvim',
    init = function()
      require("utils.startup").lazy_load "conform.nvim"
    end,
    config = function()
      require("settings.conform")
    end
  },
  {
    'akinsho/bufferline.nvim',
    init = function()
      require("utils.startup").lazy_load "bufferline.nvim"
    end,
    config = function()
      require("settings.buffer-line")
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "mfussenegger/nvim-lint",
    event = 'BufReadPre',
    init = function()
      vim.api.nvim_create_autocmd({ 'TextChanged' }, {
        callback = function() require('lint').try_lint() end,
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
    event = 'BufReadPre',
    config = function()
      require("settings.gitsigns")
    end
  },
  {
    "NeogitOrg/neogit",
    event = 'BufReadPre',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
    },
    config = true
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  }
}, require("settings.lazy-setup"))
