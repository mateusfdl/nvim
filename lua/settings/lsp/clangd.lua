local M = {}

local clangd = vim.fn.exepath("clangd")
if clangd == "" then
	clangd = vim.fn.stdpath("data") .. "/mason/bin/clangd"
end

M.cmd = {
	clangd,
	"--background-index",
	"--clang-tidy",
	"--completion-style=detailed",
	"--function-arg-placeholders",
	"--header-insertion=iwyu",
	"--pch-storage=memory",
	"--cross-file-rename",
	"--enable-config",
}

if vim.fn.isdirectory("/nix") == 1 then
	table.insert(M.cmd, "--query-driver=/run/current-system/sw/bin/cc,/run/current-system/sw/bin/c++,/run/current-system/sw/bin/gcc,/run/current-system/sw/bin/g++,/nix/store/*/bin/cc,/nix/store/*/bin/c++,/nix/store/*/bin/gcc,/nix/store/*/bin/g++")
end

M.filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "h", "hpp", "cxx", "cc" }

M.init_options = {
	usePlaceholders = true,
	completeUnimported = true,
	clangdFileStatus = true,
	semanticHighlighting = true,
}

M.capabilities = {
	offsetEncoding = { "utf-16" },
}

return M
