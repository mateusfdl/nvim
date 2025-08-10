local M = {}

local options = vim.opt
local gl = vim.g
local cmd = vim.cmd

function M.vim_auto_cmds()
	cmd("filetype plugin indent on")
	cmd("highlight ColorColumn ctermbg=red")
	cmd("syntax on")
	cmd("syntax enable")
end

function M.lua_auto_cmds()
	options.mouse = "a"
	options.colorcolumn = "80"
	options.encoding = "utf-8"
	options.number = true
	options.relativenumber = false
	options.autoindent = true
	options.autoread = true
	options.ruler = true
	options.showcmd = true
	options.smartcase = true
	options.termguicolors = true
	options.cursorline = true
	options.autoread = true
	options.guicursor = "v-c-sm:block,n-i-ci-ve:block25,r-cr-o:block20"
	options.ruler = true
	options.laststatus = 2
	options.scrolloff = 999
	options.shiftwidth = 2
	options.softtabstop = 2
	options.tabstop = 2
	options.expandtab = true
	options.wrap = true
	options.swapfile = false
	options.listchars = { tab = "->", trail = "·", space = "·", lead = "·" }
	options.fillchars = {
		vert = "|",
		horiz = "━",
	}
	options.list = false
	options.shortmess:append("sI")
	options.clipboard:append("unnamedplus")
end

function M.snippets()
	gl.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/lua/snippets/"
end

function M.setup()
	M.snippets()
	M.vim_auto_cmds()
	M.lua_auto_cmds()
end

return M
