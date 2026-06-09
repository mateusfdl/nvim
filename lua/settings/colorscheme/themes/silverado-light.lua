local M = {}
M.base_30 = {
	white = "#15140f", -- ink (primary foreground)
	darker_black = "#f0ead6",
	black = "#f7f1de", --  nvim bg (bone)
	black2 = "#ece4cf", -- paper-warm
	one_bg = "#e6dec8",
	one_bg2 = "#ddd2b6", -- paper-dark
	one_bg3 = "#d2c8ab",
	grey = "#b9b3a1",
	grey_fg = "#a9a392",
	grey_fg2 = "#999382",
	light_grey = "#8b8676", -- ink-faint
	red = "#c85552",
	baby_pink = "#f0a094",
	pink = "#f08e7c", -- coral-soft
	line = "#e4ddc8", -- for lines like vertsplit
	green = "#6e7448", -- olive
	vibrant_green = "#87a05f",
	nord_blue = "#647e8c",
	blue = "#4f7e94",
	yellow = "#e9b94a", -- mustard
	sun = "#d1b171",
	purple = "#9c6f88",
	dark_purple = "#855d74",
	teal = "#6e9b8f",
	orange = "#df8a3c",
	cyan = "#7fa8b0",
	statusline_bg = "#f0ead6",
	lightbg = "#ddd2b6",
	pmenu_bg = "#6e7448", -- olive
	folder_bg = "#8a6f80",
}
M.base_16 = {
	base00 = "#f7f1de",
	base01 = "#f0ead6",
	base02 = "#ece4cf",
	base03 = "#e4ddc8",
	base04 = "#ddd2b6",
	base05 = "#2a2620",
	base06 = "#1f1c15",
	base07 = "#15140f",
	base08 = "#ed6f5c", -- coral
	base09 = "#df8a3c",
	base0A = "#e9b94a",
	base0B = "#6e7448",
	base0C = "#6e9b8f",
	base0D = "#4f7e94",
	base0E = "#9c6f88",
	base0F = "#c85552",
}
M.polish_hl = {
	git = {
		DiffAdd = { fg = M.base_30.green },
	},
	nvimtree = {
		NvimTreeFolderName = { fg = "#5a5448" },
		NvimTreeWinSeparator = { fg = M.base_30.yellow },
	},
	tbline = {
		TbLineThemeToggleBtn = { bg = M.base_30.one_bg },
	},
	defaults = {
		Pmenu = { bg = M.base_30.black2 },
	},
	treesitter = {
		["@tag"] = { fg = M.base_30.orange },
		["@variable.member"] = { fg = M.base_16.base05 },
		["@keyword.import"] = { fg = M.base_16.base08 },
		["@constructor"] = { fg = M.base_30.blue },
	},
}
M.type = "light"
return M
