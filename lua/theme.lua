local gl = vim.g
gl.theme_cache = vim.fn.stdpath("data") .. "/themes/cache/"
gl.nvim_theme = "onedark"

local M = {}

M.load_theme = function()
	require("settings.colorscheme").load_all_highlights()
end

M.switch_theme = function(theme)
	gl.nvim_theme = theme
	require("settings.colorscheme").load_all_highlights()
end

M.setup = function()
	M.load_theme()
end

return M
