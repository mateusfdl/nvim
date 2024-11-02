local M = {}

M.cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" }
M.filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "h" }

return M
