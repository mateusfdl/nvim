require("utils.mappings")

local M = {}

M.cmd = { vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server", "--stdio" }

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
	vim.keymap.set("n", "gs", ":lua organize_imports()<CR>", { buffer = bufnr, silent = true, noremap = true })
	vim.keymap.set("n", "<leader>Rn", ":lua rename_file()<CR>", { buffer = bufnr, silent = true, noremap = true })
end

M.init_options = {
	plugins = {
		{
			name = "@vue/typescript-plugin",
			location = vim.system({ "which", "vue-language-server" }):wait().stdout:gsub("\n", ""),
			languages = { "typescript", "vue" },
		},
	},
}

M.filetypes = {
	"javascript",
	"javascriptreact",
	"javascript.jsx",
	"typescript",
	"typescriptreact",
	"typescript.tsx",
	"vue",
}

return M
