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

function M.close_buffer()
  local buffer = vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_delete(buffer, {})
end

function M.next_tab_buffer()
  local buffers = vim.api.nvim_list_bufs()
  local buffer = vim.api.nvim_get_current_buf()
  local index = 0

  for i, value in ipairs(buffers) do
    if value == buffer then
      index = i
    end
  end

  if buffers[index + 1] == nil then
    return nil
  else
    vim.api.nvim_win_set_buf(0, buffers[index + 1])
  end
end

function M.prev_tab_buffer()
  local buffers = vim.api.nvim_list_bufs()
  local buffer = vim.api.nvim_get_current_buf()
  local index = 0

  for i, value in ipairs(buffers) do
    if value == buffer then
      index = i
    end
  end

  if buffers[index - 1] == nil then
    return nil
  else
    vim.api.nvim_win_set_buf(0, buffers[index - 1])
  end
end

return M
