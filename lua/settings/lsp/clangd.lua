local M = {}

M.cmd = { vim.fn.stdpath("data") .. "/mason/bin/clangd", "--background-index", "--clang-tidy", "--log=verbose" }
M.filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "h" }

return M
