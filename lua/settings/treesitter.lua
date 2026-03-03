local M = {}

M.languages = {
	"cpp",
	"c",
	"cmake",
	"make",
	"bash",
	"lua",
	"rust",
	"json",
	"ruby",
	"go",
	"typescript",
	"javascript",
	"proto",
	"elixir",
	"tsx",
	"yaml",
	"css",
	"html",
	"scss",
	"haskell",
	"toml",
	"vimdoc",
	"luadoc",
	"vim",
	"markdown",
	"scheme",
	"python",
	"java",
	"swift",
	"query",
	"zig",
	"qmljs",
	"dart",
	"nix",
}

vim.schedule(function()
	local ts_config = require("nvim-treesitter.config")
	local installed = ts_config.get_installed()
	local installed_set = {}
	for _, lang in ipairs(installed) do
		installed_set[lang] = true
	end

	local to_install = {}
	for _, lang in ipairs(M.languages) do
		if not installed_set[lang] then
			table.insert(to_install, lang)
		end
	end

	if #to_install > 0 then
		vim.cmd("TSInstall " .. table.concat(to_install, " "))
	end
end)

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local ok = pcall(vim.treesitter.start, args.buf)
		if ok then
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
	},
})

local function get_node_at_cursor()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row, col = cursor[1] - 1, cursor[2]
	return vim.treesitter.get_node({ pos = { row, col } })
end

local current_node = nil

local function init_selection()
	current_node = get_node_at_cursor()
	if current_node then
		local start_row, start_col, end_row, end_col = current_node:range()
		vim.api.nvim_buf_set_mark(0, "<", start_row + 1, start_col, {})
		vim.api.nvim_buf_set_mark(0, ">", end_row + 1, end_col - 1, {})
		vim.cmd("normal! gv")
	end
end

local function node_incremental()
	if current_node then
		local parent = current_node:parent()
		if parent then
			current_node = parent
			local start_row, start_col, end_row, end_col = current_node:range()
			vim.api.nvim_buf_set_mark(0, "<", start_row + 1, start_col, {})
			vim.api.nvim_buf_set_mark(0, ">", end_row + 1, end_col - 1, {})
			vim.cmd("normal! gv")
		end
	end
end

local function node_decremental()
	if current_node then
		local child = current_node:child(0)
		if child then
			current_node = child
			local start_row, start_col, end_row, end_col = current_node:range()
			vim.api.nvim_buf_set_mark(0, "<", start_row + 1, start_col, {})
			vim.api.nvim_buf_set_mark(0, ">", end_row + 1, end_col - 1, {})
			vim.cmd("normal! gv")
		end
	end
end

M.init_selection = init_selection
M.node_incremental = node_incremental
M.node_decremental = node_decremental

return M
