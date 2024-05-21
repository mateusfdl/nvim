local M = {}
local g = vim.g

M.get_theme_tb = function(type)
	local default_path = "settings.colorscheme.themes." .. g.nvim_theme
	local present1, default_theme = pcall(require, default_path)

	if present1 then
		return default_theme[type]
	else
		error("No such theme!")
	end
end

M.merge_tb = function(...)
	return vim.tbl_deep_extend("force", ...)
end

M.saveStr_to_cache = function(filename, tb)
	local bg_opt = "vim.opt.bg='" .. M.get_theme_tb("type") .. "'"
	local defaults_cond = filename == "defaults" and bg_opt or ""

	local lines = "return string.dump(function()" .. defaults_cond .. M.table_to_str(tb) .. "end, true)"
	local file = io.open(vim.g.theme_cache .. filename, "wb")

	if file then
		file:write(loadstring(lines)())
		file:close()
	end
end

M.load_highlight = function(group)
	group = require("settings.colorscheme.integrations." .. group)
	M.extend_default_hl(group)
	return group
end

M.compile = function()
	if not vim.loop.fs_stat(vim.g.theme_cache) then
		vim.fn.mkdir(vim.g.theme_cache, "p")
	end

	local hl_files = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h") .. "/integrations"

	for _, file in ipairs(vim.fn.readdir(hl_files)) do
		-- skip caching some files
		if file ~= "statusline" or file ~= "treesitter" then
			local filename = vim.fn.fnamemodify(file, ":r")
			M.saveStr_to_cache(filename, M.load_highlight(filename))
		end
	end
end

M.load_all_highlights = function()
	require("plenary.reload").reload_module("settings.colorscheme")
	M.compile()

	for _, file in ipairs(vim.fn.readdir(vim.g.theme_cache)) do
		dofile(vim.g.theme_cache .. file)
	end
end

M.extend_default_hl = function(highlights)
	local polish_hl = M.get_theme_tb("polish_hl")
	local add_hl = M.get_theme_tb("add_hl")

	-- polish themes
	if polish_hl then
		for key, value in pairs(polish_hl) do
			if highlights[key] then
				highlights[key] = M.merge_tb(highlights[key], value)
			end
		end
	end

	-- add new hl
	if add_hl then
		for key, value in pairs(add_hl) do
			if not highlights[key] and type(value) == "table" then
				highlights[key] = value
			end
		end
	end
end

M.table_to_str = function(tb)
	local result = ""

	for hlgroupName, hlgroup_vals in pairs(tb) do
		local hlname = "'" .. hlgroupName .. "',"
		local opts = ""

		for optName, optVal in pairs(hlgroup_vals) do
			local valueInStr = ((type(optVal)) == "boolean" or type(optVal) == "number") and tostring(optVal)
				or '"' .. optVal .. '"'
			opts = opts .. optName .. "=" .. valueInStr .. ","
		end

		result = result .. "vim.api.nvim_set_hl(0," .. hlname .. "{" .. opts .. "})"
	end

	return result
end

local change_hex_lightness = require("settings.colorscheme.utils").change_hex_lightness

M.turn_str_to_color = function(tb)
	local colors = M.get_theme_tb("base_30")
	local copy = vim.deepcopy(tb)

	for _, hlgroups in pairs(copy) do
		for opt, val in pairs(hlgroups) do
			if opt == "fg" or opt == "bg" or opt == "sp" then
				if not (type(val) == "string" and val:sub(1, 1) == "#" or val == "none" or val == "NONE") then
					hlgroups[opt] = type(val) == "table" and change_hex_lightness(colors[val[1]], val[2]) or colors[val]
				end
			end
		end
	end

	return copy
end

M.override_theme = function(default_theme, theme_name)
	return M.merge_tb(default_theme)
end

return M
