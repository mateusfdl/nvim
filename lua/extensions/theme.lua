local M = {}

local themes_path = vim.fn.stdpath("config") .. "/lua/settings/colorscheme/themes"
local switch_theme_mode = vim.fn.expand("~/scripts/switch-theme-mode")

local function get_themes()
	local themes = {}

	for _, file in ipairs(vim.fn.readdir(themes_path)) do
		local theme = file:match("^(.*)%.lua$")
		if theme then
			table.insert(themes, theme)
		end
	end

	table.sort(themes)
	return themes
end

local function apply_theme(theme)
	require("theme").switch_theme(theme)

	vim.fn.jobstart({ switch_theme_mode, "--set-theme=" .. theme }, {
		detach = true,
	})
end

function M.switcher()
	vim.ui.select(get_themes(), {
		prompt = "Themes",
	}, function(theme)
		if not theme then return end
		apply_theme(theme)
	end)
end

return M
