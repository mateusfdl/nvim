local uv = vim.loop
local M = {}
vim.g.theme_cache = vim.fn.stdpath("cache") .. "/themes/cache/"

M.switch_theme = function(theme)
	vim.g.nvim_theme = theme
	require("settings.colorscheme").load_all_highlights()
end

M.switch_global_theme = function()
	local cmd = "sh " .. "~/scripts/switch-theme-mode"

	vim.fn.system(cmd)
	M.reload_theme()
end

M.reload_theme = function()
	local mode_file = "/tmp/theme-mode"

	if not uv.fs_stat(mode_file) then
		M.switch_theme(vim.env.DARK_THEME)
		return
	end

	local fd = uv.fs_open(mode_file, "r", 438)
	local mode = uv.fs_read(fd, uv.fs_stat(mode_file).size, 0)
	uv.fs_close(fd)

	if mode:match("light") then
		M.switch_theme(vim.env.LIGHT_THEME)
	else
		M.switch_theme(vim.env.DARK_THEME)
	end
end

M.setup = function()
	vim.api.nvim_create_autocmd("VimResized", {
		callback = function()
			M.reload_theme()
		end,
	})

	M.reload_theme()
end

return M
