local uv = vim.loop
local M = {}
vim.g.theme_cache = vim.fn.stdpath("cache") .. "/themes/cache/"
local switch_theme_mode = vim.fn.expand("~/scripts/switch-theme-mode")

M.switch_theme = function(theme)
	vim.g.nvim_theme = theme
	M.reload_theme()
end

M.switch_global_theme = function()
	local cmd = "sh " .. switch_theme_mode

	vim.fn.system(cmd)
	M.reload_global_theme()
end

M.reload_theme = function()
	require("settings.colorscheme").load_all_highlights()
end

M.reload_global_theme = function()
	local result = vim.fn.systemlist({ "sh", switch_theme_mode, "--current-theme" })
	local theme = result[1]

	if vim.v.shell_error == 0 and theme and theme ~= "" then
		M.switch_theme(theme)
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
