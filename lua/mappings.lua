require("utils.mappings")

local M = {}

function M.system()
	nnoremap("<c-j>", ":m .+1<CR>==")
	inoremap("<c-j>", "<Esc>:m .+1<CR>==gi")
	vnoremap("<c-j>", ":m '>+1<CR>gv=gv")
	nnoremap("<c-k>", ":m .-2<CR>==")
	inoremap("<c-k>", "<Esc>:m .-2<CR>==gi")
	vnoremap("<c-k>", ":m '<-2<CR>gv=gv")
	inoremap("ii", "<esc>")
end

function M.buffers()
	nnoremap("<Leader>cab", ":lua require('utils.buffers').clean_around_buffers()<CR>")
	nnoremap("<Leader>cb", ":lua require('utils.buffers').close_buffer()<CR>")
	nnoremap("<Leader>bn", ":lua require('utils.buffers').next_tab_buffer()<CR>")
	nnoremap("<Leader>bp", ":lua require('utils.buffers').prev_tab_buffer()<CR>")
end

function M.telescope()
	nnoremap(";", ":lua require('telescope.builtin').find_files()<cr>")
	nnoremap("<leader>;", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
	nnoremap("<leader>,b", "<cmd>lua require('extensions.telescope').buffer_searcher()<cr>")
	vnoremap("<leader>,g", "<cmd>lua require('telescope.builtin').grep_string()<cr>")
	nnoremap("<leader>,h", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
	nnoremap("<leader>,c", "<cmd>lua require('telescope.builtin').git_status()<cr>")
	nnoremap("<leader>,s", "<cmd>lua require('telescope.builtin').git_stash()<cr>")
	nnoremap("<leader>,f", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>")
end

function M.lsp()
	nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
	nnoremap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
	nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
	nnoremap("gf", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
	nnoremap("gF", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
	nnoremap("gG", "<cmd>lua require('conform').format({ lsp_fallback = true, timeout = 500, async = true})<CR>")
	nnoremap("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
	nnoremap("gR", "<cmd>lua vim.lsp.buf.rename()<CR>")
	nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	nnoremap("gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
	nnoremap("gT", "<cmd>lua vim.lsp.buf.code_action()<CR>")
	nnoremap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	nnoremap(
		"gs",
		"<cmd>lua vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })<CR>"
	)
end

function M.float_term()
	nnoremap("<C-d>g", ":FloatermNew --height=50 --width=230 --title=-  lazygit<CR>")
	nnoremap("<C-d>d", ":FloatermNew --height=50 --width=340 --title=-  lazydocker<CR>")
end

function M.delve()
	nnoremap("<Leader>da", ":DlvAddBreakpoint<CR>")
	nnoremap("<Leader>dt", ":DlvAddTracepoint<CR>")
	nnoremap("<Leader>dc", ":DlvClearAll<CR>")
	nnoremap("<Leader>rn", ":DlvTest<CR>")
end

function M.tmux()
	nnoremap("<leader>va", ":VtrAttachToPane<cr>")
	nnoremap("<leader>ror", ":VtrReorientRunner<cr>")
	nnoremap("<leader>sc", ":VtrSendCommandToRunner<cr>")
	nnoremap("<leader>sf", ":VtrSendFile<cr>")
	nnoremap("<leader>sl", ":VtrSendLinesToRunner<cr>")
	vnoremap("<leader>sl", ":VtrSendLinesToRunner<cr>")
	nnoremap("<leader>or", ":VtrOpenRunner<cr>")
	nnoremap("<leader>kr", ":VtrKillRunner<cr>")
	nnoremap("<leader>fr", ":VtrFocusRunner<cr>")
	nnoremap("<leader>dr", ":VtrDetachRunner<cr>")
	nnoremap("<leader>cr", ":VtrClearRunner<cr>")
	nnoremap("<leader>fc", ":VtrFlushCommand<cr>d")
end

function M.lsp_diagnostic()
	nnoremap("<leader>q", ":lua vim.diagnostic.setloclist()<CR>")
	nnoremap("<C-n>", ":lua vim.diagnostic.goto_next()<CR>")
	nnoremap("<C-p>", ":lua vim.diagnostic.goto_prev()<CR>")
	noremap("<leader>Dc", ":CopyDiagnosticToClipboard<CR>")
	nnoremap("<leader>Dt", ":ToggleDiagnostics<CR>")
end

function M.gitsigns()
	nnoremap("<leader>tb", ":lua require('gitsigns').blame_line{full=true}<CR>")
end

function M.setup()
	M.system()
	M.telescope()
	M.lsp()
	M.float_term()
	M.delve()
	M.buffers()
	M.tmux()
	M.gitsigns()
	M.lsp_diagnostic()
end

return M
