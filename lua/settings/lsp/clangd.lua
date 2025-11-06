local M = {}

M.cmd = { 
	vim.fn.stdpath("data") .. "/mason/bin/clangd", 
	"--background-index", 
	"--clang-tidy", 
	"--completion-style=detailed",
	"--function-arg-placeholders",
	"--header-insertion=iwyu",
	"--pch-storage=memory",
	"--cross-file-rename",
	"--enable-config"
}
M.filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "h", "hpp", "cxx", "cc" }
M.init_options = {
	usePlaceholders = true,
	completeUnimported = true,
	clangdFileStatus = true,
	semanticHighlighting = true
}
M.capabilities = {
	offsetEncoding = { "utf-16" },
}

return M
