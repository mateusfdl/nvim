local M = {}

M.cmd = { vim.fn.stdpath("data") .. "/mason/bin/zls" }

M.settings = {
	zls = {
		enable_snippets = true,
		enable_ast_check_diagnostics = true,
		enable_autofix = true,
		enable_import_embedfile_argument_completions = true,
		enable_semantic_tokens = true,
		enable_inlay_hints = true,
		inlay_hints_show_builtin = true,
		inlay_hints_exclude_single_argument = true,
		inlay_hints_hide_redundant_param_names = false,
		inlay_hints_hide_redundant_param_names_last_token = false,
		warn_style = false,
		highlight_global_var_declarations = false,
	},
}

M.on_attach = function(client, bufnr)
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end

	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>zr", function()
		vim.cmd("!zig run %")
	end, opts)
	vim.keymap.set("n", "<leader>zt", function()
		vim.cmd("!zig test %")
	end, opts)
	vim.keymap.set("n", "<leader>zb", function()
		vim.cmd("!zig build")
	end, opts)
	vim.keymap.set("n", "<leader>zf", function()
		vim.cmd("!zig fmt %")
	end, opts)
end

return M

