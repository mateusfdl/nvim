local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values

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

M.switcher = function(opts)
	opts = opts or {}

	pickers
		.new(opts, {
			prompt_title = "Themes",
			finder = finders.new_table({
				results = get_themes(),
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(_)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					if not selection then
						return
					end

					apply_theme(selection.value)
				end)

				return true
			end,
		})
		:find()
end

return M
