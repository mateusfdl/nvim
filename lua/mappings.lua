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
	noremap("<esc>", "<esc>:nohl<CR><esc>")
	nnoremap("<leader>cf", '<cmd>let @+ = expand("%")<CR>')
	nnoremap("<leader>cp", '<cmd>let @+ = expand("%:p")<CR>')
end

function M.buffers()
	nnoremap("<Leader>cab", ":BufferLineCloseOthers<CR>")
	nnoremap("<Leader>bn", ":BufferLineCycleNext<CR>")
	nnoremap("<Leader>bp", ":BufferLineCyclePrev<CR>")
	nnoremap("<Leader>bd", ":BufferLinePickClose<CR>")
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
	nnoremap("gd", vim.lsp.buf.definition)
	nnoremap("gD", vim.lsp.buf.declaration)
	nnoremap("K", "<cmd> lua require('settings.lsp').hover()<cr>")
	nnoremap("gf", vim.lsp.buf.document_symbol)
	nnoremap("gF", vim.lsp.buf.workspace_symbol)
	nnoremap("gr", vim.lsp.buf.references)
	nnoremap("gR", vim.lsp.buf.rename)
	nnoremap("gi", vim.lsp.buf.implementation)
	nnoremap("gt", vim.lsp.buf.type_definition)
	nnoremap("gT", vim.lsp.buf.code_action)
	nnoremap("ge", vim.diagnostic.open_float)
	nnoremap("gE", vim.diagnostic.setloclist)
	nnoremap(
		"gs",
		"<cmd>lua vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })<CR>"
	)
	nnoremap("gG", "<cmd>lua require('conform').format({ lsp_fallback = true, timeout = 500, async = true})<CR>")
end

function M.float_term()
	nnoremap("<C-d>g", ":FloatermNew --height=50 --width=230 --title=-  lazygit<CR>")
	nnoremap("<C-d>d", ":FloatermNew --height=50 --width=340 --title=-  lazydocker<CR>")
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

function M.theme()
	nnoremap("<leader>tm", ":lua require('theme').switch_global_theme()<CR>")
end

function M.AI()
	nnoremap("<leader>Ac", ":lua require('schadenfreude').open_chat()<CR>")
	vnoremap("<leader>gH", ":lua require('schadenfreude').send_message({ chat = true})<CR>")
	nnoremap("<leader>gH", ":lua require('schadenfreude').send_message({ chat = true})<CR>")
	vnoremap("<leader>gh", ":<C-u>SendToChat<CR>")
	vnoremap("<leader>gW", ":<C-u>RefactorCode<CR>")
end

function M.dap()
	nnoremap("<space>a", ":DapToggleBreakpoint<cr>")
	nnoremap("<space>gb", ":DapRunToCursor<cr>")
	nnoremap("<space>c", ":DapContinue<cr>")
	nnoremap("<space>n", ":DapStepInto<cr>")
	nnoremap("<space>B", ":DapStepOver<cr>")
	nnoremap("<space><esc>", ":DapStepOut<cr>")
	nnoremap("<space>b", ":DapStepBack<cr>")
	nnoremap("<space>r", ":DapRestart<cr>")
	nnoremap("<space>?", ":lua require('dapui').eval(nil, { enter = true })<cr>")
	nnoremap("<space>l", ":lua require('dapui').toggle()<cr>")
	nnoremap("<space>S", ":DapTerminate<cr>")
	nnoremap("<space>s", ":DapDisconnect<cr>")
end

function M.obsidian()
	nnoremap("<leader>oo", ":ObsidianOpen<CR>")
	nnoremap("<leader>os", ":ObsidianSearch<CR>")
	nnoremap("<leader>on", ":ObsidianNew<CR>")
	nnoremap("<leader>oq", ":ObsidianQuickSwitch<CR>")
	nnoremap("<leader>ot", ":ObsidianTemplate notes<CR>")
	nnoremap("<leader>oj", ":ObsidianToday<CR>")
end

function M.setup()
	M.system()
	M.telescope()
	M.lsp()
	M.float_term()
	M.buffers()
	M.tmux()
	M.gitsigns()
	M.lsp_diagnostic()
	M.theme()
	M.AI()
	M.dap()
	M.obsidian()
end

return M
