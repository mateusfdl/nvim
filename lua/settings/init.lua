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
  options.scrolloff = 3
  options.shiftwidth = 2
  options.backspace = "2"
  options.softtabstop = 2
  options.tabstop = 8
  options.expandtab = true
  options.wrap = true
  options.swapfile = false
  options.shortmess:append "sI"
end

function M.setup()
  M.vim_auto_cmds()
  M.lua_auto_cmds()
end

gl.theme_cache = vim.fn.stdpath "data" .. "/themes/cache/"
gl.nvim_theme = "onedark"
require("settings.colorscheme").load_all_highlights()
return M
