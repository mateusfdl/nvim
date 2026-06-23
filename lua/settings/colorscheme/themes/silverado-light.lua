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
local blue = M.base_30.blue
local ice = M.base_30.nord_blue
local cyan = M.base_30.cyan
local teal = M.base_30.teal
local coral = M.base_16.base08
local number = M.base_16.base09
local type_hl = M.base_16.base0A
local string_hl = M.base_16.base0B
local tag = M.base_30.orange
local special = M.base_16.base0F
local punct = M.base_30.light_grey
local quote = M.base_30.grey_fg

M.polish_hl = {
	DiffAdd = { fg = M.base_30.green },
	NvimTreeFolderName = { fg = "#5a5448" },
	NvimTreeWinSeparator = { fg = M.base_30.yellow },
	TbLineThemeToggleBtn = { bg = M.base_30.one_bg },
	Pmenu = { bg = M.base_30.black2 },

	["@variable.builtin"] = { fg = teal, italic = true },
	["@constant"] = { fg = number },
	["@constant.builtin"] = { fg = number },
	["@character"] = { fg = string_hl },
	["@function.builtin"] = { fg = teal },
	["@type.builtin"] = { fg = teal },
	["@constructor"] = { fg = blue },
	["@field"] = { fg = cyan },
	["@field.key"] = { fg = cyan },
	["@property"] = { fg = cyan },
	["@parameter"] = { fg = ice },
	["@namespace"] = { fg = type_hl },
	["@tag"] = { fg = tag },
	["@tag.delimiter"] = { fg = punct },
	["@tag.attribute"] = { fg = cyan },
	["@include"] = { fg = coral },
	["@attribute"] = { fg = special },
	["@annotation"] = { fg = special },
	["@function.macro"] = { fg = special },
	["@constant.macro"] = { fg = special },
	["@text.literal"] = { fg = string_hl },
	["@text.uri"] = { fg = blue, underline = true },
	["@punctuation.bracket"] = { fg = punct },
	["@punctuation.delimiter"] = { fg = punct },
}

M.add_hl = {
	["@variable.parameter"] = { fg = ice },
	["@variable.parameter.builtin"] = { fg = ice, italic = true },
	["@variable.member"] = { fg = cyan },
	["@module"] = { fg = type_hl },
	["@module.builtin"] = { fg = teal },
	["@keyword.import"] = { fg = coral },
	["@function.method"] = { fg = blue },
	["@function.method.call"] = { fg = blue },
	["@markup.heading"] = { fg = blue, bold = true },
	["@markup.strong"] = { bold = true },
	["@markup.italic"] = { italic = true },
	["@markup.strikethrough"] = { strikethrough = true },
	["@markup.raw"] = { fg = string_hl },
	["@markup.link"] = { fg = blue },
	["@markup.link.url"] = { fg = blue, underline = true },
	["@markup.link.label"] = { fg = cyan },
	["@markup.list"] = { fg = tag },
	["@markup.quote"] = { fg = quote, italic = true },
	["@markup.math"] = { fg = cyan },
	["@diff.plus"] = { fg = string_hl },
	["@diff.minus"] = { fg = coral },
	["@diff.delta"] = { fg = blue },
}

M.type = "light"
return M
