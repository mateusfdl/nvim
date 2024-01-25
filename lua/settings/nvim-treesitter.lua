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
  textobjects = {
    lookahead = true,
    select = {
      enable = true,
      include_surrounding_whitespace = true,
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = { [']m'] = '@function.outer', [']M'] = '@class.outer' },
      goto_previous_start = { ['[m'] = '@function.outer', ['[M'] = '@class.outer' },
    },
  },
  context_commentstring = { enable = true },
}
