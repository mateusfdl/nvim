local signs = { Error = " ", Warn = " ", Hint = "󰋼 ", Info = "󱉘 " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	virtual_text = {
		source = "always",
		prefix = "-> ",
	},
	underline = false,
	signs = true,
	severity_sort = true,
	float = {
		source = "always",
		header = "",
		prefix = "",
		focusable = false,
	},
})

function PrintDiagnostics(opts, bufnr, line_nr, client_id)
	bufnr = bufnr or 0
	line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
	opts = opts or { ["lnum"] = line_nr }

	local line_diagnostics = vim.diagnostic.get(bufnr, opts)
	if vim.tbl_isempty(line_diagnostics) then
		return
	end

	local diagnostic_message = ""
	for i, diagnostic in ipairs(line_diagnostics) do
		diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
		print(diagnostic_message)
		if i ~= #line_diagnostics then
			diagnostic_message = diagnostic_message .. "\n"
		end
	end
	vim.api.nvim_echo({ { diagnostic_message, "Normal" } }, false, {})
end

function ToggleDiagnostics()
	local bufnr = vim.api.nvim_get_current_buf()
	local diagnostics = vim.diagnostic.get(bufnr)
	if vim.tbl_isempty(diagnostics) then
		vim.diagnostic.open(0)
	else
		vim.diagnostic.close(0)
	end
end

function CopyDiagnosticToClipboard()
	local bufnr = vim.api.nvim_get_current_buf()

	local diagnostics = vim.diagnostic.get(bufnr)

	if vim.tbl_isempty(diagnostics) then
		return
	end

	for _, diagnostic in ipairs(diagnostics) do
		if diagnostic.lnum + 1 == vim.api.nvim_win_get_cursor(0)[1] then
			vim.fn.system("tmux set-buffer '" .. vim.fn.escape(diagnostic.message, "'") .. "'")
			vim.fn.system("tmux save-buffer - | tmux load-buffer -")
			return
		end
	end
end

vim.cmd([[ command! CopyDiagnosticToClipboard lua CopyDiagnosticToClipboard() ]])
vim.cmd([[ command! ToggleDiagnostics lua ToggleDiagnostics() ]])

vim.cmd([[ autocmd! CursorHold * lua PrintDiagnostics() ]])
