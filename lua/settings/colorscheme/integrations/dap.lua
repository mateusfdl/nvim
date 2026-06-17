local colors = require("settings.colorscheme").get_theme_tb("base_30")

local highlights = {
	DapBreakpointText = {
		fg = colors.red,
	},
	DapBreakpointConditionText = {
		fg = colors.orange,
	},
	DapBreakpointRejectedText = {
		fg = colors.grey,
	},
	DapLogPointText = {
		fg = colors.blue,
	},
	DapStoppedText = {
		fg = colors.yellow,
	},
	DapStoppedLine = {
		bg = colors.one_bg,
	},
}

return highlights
