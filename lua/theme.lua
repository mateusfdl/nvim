local uv = vim.loop
local M = {}
vim.g.theme_cache = vim.fn.stdpath("cache") .. "/themes/cache/"

M.switch_theme = function(theme)
	vim.g.nvim_theme = theme
	M.reload_theme()
end

M.switch_global_theme = function()
	local cmd = "sh " .. "~/scripts/switch-theme-mode"

	vim.fn.system(cmd)
	M.reload_global_theme()
end

M.reload_theme = function()
	require("settings.colorscheme").load_all_highlights()
end

M.reload_global_theme = function()
	local mode_file = uv.os_homedir() .. "/.cache/theme-mode"

	if not uv.fs_stat(mode_file) then
		M.switch_theme(vim.env.DARK_THEME)
		return
	end

	local fd = uv.fs_open(mode_file, "r", 438)
	if not fd then
		return
	end

	local stat = uv.fs_stat(mode_file)
	local mode = uv.fs_read(fd, stat.size, 0)
	uv.fs_close(fd)

	if mode:match("light") then
		M.switch_theme(vim.env.LIGHT_THEME)
	else
		M.switch_theme(vim.env.DARK_THEME)
	end
end

local function reapply_cache()
	local cache_dir = vim.g.theme_cache
	if not cache_dir or not uv.fs_stat(cache_dir) then
		return
	end
	for _, file in ipairs(vim.fn.readdir(cache_dir)) do
		pcall(dofile, cache_dir .. file)
	end
end

M.setup = function()
	local sigusr1 = uv.new_signal()
	sigusr1:start(uv.constants.SIGUSR1, function()
		vim.schedule(function()
			M.reload_global_theme()
		end)
	end)

	M.reload_global_theme()

	vim.api.nvim_create_autocmd("User", {
		pattern = "LazyLoad",
		callback = reapply_cache,
	})
end

return M
