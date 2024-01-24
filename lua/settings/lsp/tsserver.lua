require("utils.mappings")
local M = {}

_G.organize_imports = function()
  vim.lsp.buf.execute_command {
    command = '_typescript.organizeImports',
    arguments = {
      vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
    }
  }
end

function M.on_attach(_, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":lua organize_imports()<CR>", { silent = true, noremap = true })
end

return M
