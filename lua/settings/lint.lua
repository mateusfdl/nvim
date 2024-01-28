local language_linters = {
  javascript = { 'eslint' },
  typescript = { 'eslint' },
  json = { 'eslint' },
  yaml = { 'eslint' },
  markdown = { 'markdownlint' },
  lua = { 'luacheck' },
  rust = { 'rustfmt' },
  go = { 'golangcilint' },
  ruby = { 'rubocop' },
  c = { 'clang-format' },
  cpp = { 'clang-format' },
  cmake = { 'cmake-format' },
  make = { 'cmake-format' },
  dockerfile = { 'dockerlint' },
  bash = { 'shellcheck' },
}

local file_types = function()
  local ft = {}

  for k, _ in pairs(language_linters) do
    table.insert(ft, k)
  end

  return ft
end

require('lint').linters_by_ft = language_linters

return {
  file_types = file_types,
}
