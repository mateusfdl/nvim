require("utils.mappings")

local M = {}

_G.organize_imports = function()
	vim.lsp.buf.execute_command({
		command = "_typescript.organizeImports",
		arguments = {
			vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
		},
	})
end

_G.rename_file = function()
	local source_file, target_file

	vim.ui.input({
		prompt = "Source : ",
		completion = "file",
		default = vim.api.nvim_buf_get_name(0),
	}, function(input)
		source_file = input
	end)

	vim.ui.input({
		prompt = "Target : ",
		completion = "file",
		default = source_file,
	}, function(input)
		target_file = input
	end)

	local params = {
		command = "_typescript.applyRenameFile",
		arguments = {
			{
				sourceUri = source_file,
				targetUri = target_file,
			},
		},
		title = "",
	}

	vim.lsp.util.rename(source_file, target_file)
	vim.lsp.buf.execute_command(params)
end

function M.on_attach(_, bufnr)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":lua organize_imports()<CR>", { silent = true, noremap = true })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>Rn", ":lua rename_file()<CR>", { silent = true, noremap = true })
end

M.filetypes = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx"
}

return M
