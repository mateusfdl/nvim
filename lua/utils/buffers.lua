local M = {}

function M.clean_around_buffers()
  local buffers = vim.api.nvim_list_bufs()

  local current_buff_v = vim.api.nvim_get_current_buf()

  for _, value in ipairs(buffers) do
    if value ~= current_buff_v then
      vim.api.nvim_buf_delete(value, { force = true })
    end
  end
end

return M
