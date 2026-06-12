local M = {}

local function_node_types = {
  function_declaration = true,
  function_definition = true,
  method_definition = true,
  method_declaration = true,
  function_expression = true,
  fun_expression = true,
  arrow_function = true,
  func_literal = true,
}

local binding_node_types = {
  value_definition = true,
  lexical_declaration = true,
  variable_declaration = true,
  assignment_statement = true,
  short_var_declaration = true,
  var_declaration = true,
}

local function is_curried_binding(node)
  if node:type() ~= "let_binding" then return false end
  for child in node:iter_children() do
    if child:type() == "parameter" then return true end
  end
  return false
end

local function holds_function(node)
  if function_node_types[node:type()] then return true end
  if is_curried_binding(node) then return true end
  for child in node:iter_children() do
    if child:named() and holds_function(child) then return true end
  end
  return false
end

local function is_target(node)
  if function_node_types[node:type()] then return true end
  return binding_node_types[node:type()] and holds_function(node)
end

function M.under_cursor(bufnr)
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok or parser == nil then
    error(string.format("tdw: no treesitter parser for buffer %d", bufnr), 0)
  end
  parser:parse()
  local node = vim.treesitter.get_node({ bufnr = bufnr })
  while node and not is_target(node) do
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
