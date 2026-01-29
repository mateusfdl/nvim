local base16 = require("settings.colorscheme").get_theme_tb("base_16")
local colors = require("settings.colorscheme").get_theme_tb("base_30")

local highlights = {
	BlinkCmpMenu = { bg = colors.black },
	BlinkCmpMenuBorder = { fg = colors.grey_fg },
	BlinkCmpMenuSelection = { link = "PmenuSel", bold = true },
	BlinkCmpDoc = { bg = colors.darker_black },
	BlinkCmpDocBorder = { fg = colors.darker_black, bg = colors.darker_black },
	BlinkCmpLabel = { fg = colors.white },
	BlinkCmpLabelMatch = { fg = colors.blue, bold = true },
	BlinkCmpSource = { fg = colors.light_grey },

	-- Kind highlights
	BlinkCmpKindConstant = { fg = base16.base09 },
	BlinkCmpKindFunction = { fg = base16.base0D },
	BlinkCmpKindField = { fg = base16.base08 },
	BlinkCmpKindVariable = { fg = base16.base0E },
	BlinkCmpKindSnippet = { fg = colors.red },
	BlinkCmpKindText = { fg = base16.base0B },
	BlinkCmpKindKeyword = { fg = base16.base07 },
	BlinkCmpKindMethod = { fg = base16.base0D },
	BlinkCmpKindConstructor = { fg = colors.blue },
	BlinkCmpKindModule = { fg = base16.base0A },
	BlinkCmpKindProperty = { fg = base16.base08 },
	BlinkCmpKindEnum = { fg = colors.blue },
	BlinkCmpKindClass = { fg = colors.teal },
	BlinkCmpKindInterface = { fg = colors.green },
	BlinkCmpKindStruct = { fg = base16.base0E },
	BlinkCmpKindEvent = { fg = colors.yellow },
	BlinkCmpKindOperator = { fg = base16.base05 },
	BlinkCmpKindTypeParameter = { fg = base16.base08 },
}

return highlights
