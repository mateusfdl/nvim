local M = {}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cmake",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()

		vim.bo[bufnr].tabstop = 2
		vim.bo[bufnr].shiftwidth = 2
		vim.bo[bufnr].expandtab = true

		vim.keymap.set("n", "<leader>cb", function()
			local build_dir = vim.fn.input("Build directory: ", "build")
			vim.cmd("!" .. string.format("mkdir -p %s && cd %s && cmake .. && make", build_dir, build_dir))
		end, { buffer = bufnr, desc = "CMake build project" })

		vim.keymap.set("n", "<leader>cg", function()
			local build_dir = vim.fn.input("Build directory: ", "build")
			vim.cmd("!" .. string.format("mkdir -p %s && cd %s && cmake ..", build_dir, build_dir))
		end, { buffer = bufnr, desc = "Generate CMake files" })

		vim.keymap.set("n", "<leader>cr", function()
			local build_dir = vim.fn.input("Build directory: ", "build")
			vim.cmd("!" .. string.format("cd %s && make", build_dir))
		end, { buffer = bufnr, desc = "Run make" })
	end,
})

return M
