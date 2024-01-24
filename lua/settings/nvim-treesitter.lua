require 'nvim-treesitter.configs'.setup {
  ensure_installed = { 'cpp', 'c', 'bash', 'lua', 'rust', 'json', 'ruby', 'go', 'typescript', 'javascript' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
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
}

vim.keymap.set("n", "[[", function()
  require("treesitter-context").go_to_context()
end, { silent = true })
