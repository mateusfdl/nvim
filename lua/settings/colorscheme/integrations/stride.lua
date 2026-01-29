local base16 = require("settings.colorscheme").get_theme_tb("base_16")
local colors = require("settings.colorscheme").get_theme_tb("base_30")

local highlights = {
	-- Ghost text for inline suggestions (Comment-like but distinct)
	StrideGhost = { fg = colors.grey_fg, italic = true },

	-- Replace action: strikethrough original text
	StrideReplace = { fg = colors.red, strikethrough = true },

	-- Remote suggestion: replacement/insertion preview
	StrideRemoteSuggestion = { fg = colors.green, italic = true },

	-- Insert action: highlight anchor text
	StrideInsert = { fg = colors.green, italic = true },

	-- Gutter sign for active suggestions
	StrideSign = { fg = colors.green },

	-- Notification styling
	StrideNotify = { bg = colors.darker_black, fg = colors.white },
	StrideNotifyBorder = { fg = colors.grey_fg, bg = colors.darker_black },
}

return highlights
