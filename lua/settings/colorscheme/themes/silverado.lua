-- Silverado
-- A cool, silvery dark theme built around a single vibrant signature green.
-- Influences: OneDark (structure/balance), Tokyo Night (blue-slate neutrals,
-- pastel-vibrant accents), Kanagawa (semantic hue discipline, carp pink).
-- Anchor color: #50fa7b — the most saturated color in the palette, on purpose.
-- Everything else sits in a softer pastel band (~70-78% lightness) so the
-- green reads as the theme's identity instead of competing with 15 neons.

local M = {}

M.base_30 = {
	white = "#c9d1e3", -- silvery blue-white fg (the "silver" in Silverado)
	darker_black = "#161924",
	black = "#1b1e2a", -- nvim bg: cool blue-slate, deeper than onedark
	black2 = "#212431",
	one_bg = "#252937",
	one_bg2 = "#2e3343",
	one_bg3 = "#373c4e",
	grey = "#454c61", -- blue-tinted greys keep the UI cohesive
	grey_fg = "#5a6178", -- comments: lifted slightly for readability
	grey_fg2 = "#666e87",
	light_grey = "#737b96",
	red = "#f7768e", -- pastel rose with punch (errors, deletes)
	baby_pink = "#f8a8bd",
	pink = "#ff8fb3",
	line = "#282c3a", -- vertsplit / indent guides: visible but quiet
	green = "#50fa7b", -- ★ the signature: strings, success, git add
	vibrant_green = "#9ff2b6", -- pastel mint companion to the anchor
	nord_blue = "#8cb6f5",
	blue = "#82aaff", -- periwinkle: functions, links
	blue_light = "#7dcfff",
	yellow = "#ffd882", -- warm pastel gold (warnings, types)
	sun = "#ffe6a7",
	purple = "#c7a4ff", -- lavender: keywords
	dark_purple = "#a98ae8",
	teal = "#4fd6be", -- minty teal: builtins, hints
	orange = "#ffb38a", -- peach: numbers, constants
	cyan = "#86e1fc", -- ice cyan: properties, escapes
	statusline_bg = "#1f2230",
	lightbg = "#2a2e3c",
	pmenu_bg = "#82aaff",
	folder_bg = "#82aaff",
}

M.base_16 = {
	base00 = "#1b1e2a", -- default bg
	base01 = "#252937", -- lighter bg (status bars)
	base02 = "#2e3343", -- selection bg
	base03 = "#454c61", -- comments / invisibles
	base04 = "#666e87", -- dark fg (line numbers)
	base05 = "#c9d1e3", -- default fg
	base06 = "#d7dde9", -- light fg
	base07 = "#e6eaf2", -- lightest fg
	base08 = "#f7768e", -- variables, tags, deleted
	base09 = "#ffb38a", -- numbers, constants, booleans
	base0A = "#ffd882", -- classes, types, search bg
	base0B = "#50fa7b", -- ★ strings, inherited class, git add
	base0C = "#86e1fc", -- support, regex, escapes
	base0D = "#82aaff", -- functions, methods, headings
	base0E = "#c7a4ff", -- keywords, storage, selectors
	base0F = "#d27e99", -- deprecated, embedded tags (kanagawa carp pink)
}

local blue = M.base_30.blue
local ice = M.base_30.blue_light
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

M.type = "dark"

return M
