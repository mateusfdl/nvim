local colors = require("settings.colorscheme").get_theme_tb("base_30")

local M = {
	NvimTreeWinSeparator = {
		fg = colors.one_bg2,
		bg = "NONE",
	},

	FFFSelectedActive = {
		fg = colors.blue,
		bg = "NONE",
	},
}

local hl_groups = {
	"NormalFloat",
	"Normal",
	"Folded",
	"NvimTreeNormal",
	"NvimTreeNormalNC",
	"NvimTreeCursorLine",
	"CursorLine",
	"Pmenu",
	"CmpPmenu",
}

for _, groups in ipairs(hl_groups) do
	M[groups] = {
		bg = "NONE",
	}
end

M.FloatBorder = {
	fg = colors.grey,
	bg = "NONE",
}

M.CmpDocBorder = {
	bg = "none",
	fg = colors.grey,
}

return M
