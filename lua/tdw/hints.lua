local M = {}

M.namespace = vim.api.nvim_create_namespace("tdw")

function M.render(bufnr, start_row, trace)
  M.clear(bufnr)
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  for _, entry in ipairs(trace) do
    local row = start_row + entry.line
    if row >= 0 and row < line_count then
      vim.api.nvim_buf_set_extmark(bufnr, M.namespace, row, 0, {
        virt_text = { { "  " .. entry.hint, "Comment" } },
        virt_text_pos = "eol",
      })
    end
  end
end

function M.clear(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, M.namespace, 0, -1)
end

return M
