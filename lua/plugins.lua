local lazy = require("lazy")

lazy.setup({
  {
    'glepnir/galaxyline.nvim',
    config = function()
      require('settings.status-line')
    end,
  },
  {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require("settings.devicons")
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    init = function()
      require("utils.startup").lazy_load "nvim-treesitter"
    end,
    build = ":TSUpdate",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    config = function()
      require("settings.nvim-treesitter")
    end
  },
  {
    'nvim-lua/popup.nvim',
    init = function()
      require("utils.startup").lazy_load "popup.nvim"
    end,
  },
  {
    'nvim-lua/plenary.nvim',
    init = function()
      require("utils.startup").lazy_load "plenary.nvim"
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    init = function()
      require("utils.startup").lazy_load "telescope.nvim"
    end,
    config = function()
      require("settings.telescope")
    end
  },
  {
    'christoomey/vim-tmux-runner',
    lazy = true,
    config = function()
      require("settings.tmux-runner")
    end
  },
  {
    'tpope/vim-surround',
    init = function()
      require("utils.startup").lazy_load "vim-surround"
    end,
  },
  {
    'mhinz/vim-signify',
    lazy = true,
  },
  {
    'neovim/nvim-lspconfig',
    init = function()
      require("utils.startup").lazy_load "nvim-lspconfig"
    end,
    config = function()
      require("settings.lsp")
      require("settings.diagnostics")
    end
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    init = function()
      require("utils.startup").lazy_load "cmp-nvim-lsp"
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    config = function()
      require("settings.cmp")
    end
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
    lazy = true,
    init = function()
      require("utils.startup").lazy_load "lsp-colors.nvim"
    end,
  },
  {
    'voldikss/vim-floaterm',
    lazy = true,
    config = function()
      require("settings.float-term")
    end
  },
  {
    "nvim-neorg/neorg",
    lazy = true,
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
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = { "mfussenegger/nvim-dap" }
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
    'rebelot/kanagawa.nvim',
    lazy = true,
    config = function()
      require("settings.theme")
    end
  },
  {
    'hrsh7th/vim-vsnip',
    lazy = true,
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
    lazy = false,
    ft = function()
      return require("settings.lint").file_types()
    end,
  }
})
