local M = {}

local function_node_types = {
  function_declaration = true,
  function_definition = true,
  method_definition = true,
  method_declaration = true,
  function_expression = true,
  arrow_function = true,
  func_literal = true,
}

function M.under_cursor(bufnr)
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok or parser == nil then
    error(string.format("tdw: no treesitter parser for buffer %d", bufnr), 0)
  end
  parser:parse()
  local node = vim.treesitter.get_node({ bufnr = bufnr })
  while node and not function_node_types[node:type()] do
    node = node:parent()
  end
  if node == nil then error("tdw: no function under cursor", 0) end
  local start_row, _, end_row, end_col = node:range()
  if end_col == 0 then end_row = end_row - 1 end
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row + 1, false)
  return {
    text = table.concat(lines, "\n"),
    start_row = start_row,
    end_row = end_row,
    lang = parser:lang(),
  }
end

return M
