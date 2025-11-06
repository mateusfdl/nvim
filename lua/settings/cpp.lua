local M = {}

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "h", "hpp" },
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		
		vim.bo[bufnr].tabstop = 2
		vim.bo[bufnr].shiftwidth = 2
		vim.bo[bufnr].expandtab = true
		vim.bo[bufnr].cindent = true
		
		vim.keymap.set("n", "<leader>ch", ":ClangdSwitchSourceHeader<CR>", 
			{ buffer = bufnr, desc = "Switch between header/source" })
		
		vim.keymap.set("n", "<leader>cr", ":ClangdRename<CR>", 
			{ buffer = bufnr, desc = "Clangd rename symbol" })
		
		vim.keymap.set("n", "<leader>ci", ":ClangdSymbolInfo<CR>", 
			{ buffer = bufnr, desc = "Symbol info" })
		
		vim.keymap.set("n", "<leader>ct", ":ClangdTypeHierarchy<CR>", 
			{ buffer = bufnr, desc = "Type hierarchy" })
		
		vim.keymap.set("n", "<leader>cm", ":ClangdMemoryUsage<CR>", 
			{ buffer = bufnr, desc = "Memory usage" })
		
		vim.keymap.set("n", "<leader>cc", function()
			local file = vim.fn.expand("%:p")
			local output = vim.fn.expand("%:r")
			local cmd = string.format("cd %s && g++ -g -Wall -Wextra -std=c++17 %s -o %s", 
				vim.fn.expand("%:p:h"), vim.fn.expand("%:t"), output)
			vim.cmd("!" .. cmd)
		end, { buffer = bufnr, desc = "Quick compile C++ file" })
		
		vim.keymap.set("n", "<leader>cx", function()
			local output = vim.fn.expand("%:r")
			vim.cmd("!" .. output)
		end, { buffer = bufnr, desc = "Run compiled executable" })
	end,
})

vim.g.cpp_class_scope_highlight = 1
vim.g.cpp_member_variable_highlight = 1
vim.g.cpp_class_decl_highlight = 1
vim.g.cpp_posix_standard = 1
vim.g.cpp_experimental_simple_template_highlight = 1
vim.g.cpp_concepts_highlight = 1

return M