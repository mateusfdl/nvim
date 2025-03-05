local colors = require("settings.colorscheme").get_theme_tb("base_30")

local highlights = {
	DapBreakpointText = {
		fg = colors.red,
	},
	DapStoppedText = {
		fg = colors.yellow,
	},
	DapStoppedLine = {
		bg = colors.black2,
	},
}

return highlights
