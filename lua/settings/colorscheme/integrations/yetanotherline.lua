local colors = require("settings.colorscheme").get_theme_tb("base_30")

local YALColorscheme = {
	YetAnotherLineBackground = { fg = colors.light_grey, bg = colors.statusline_bg },
	YASNorMode = { bg = colors.statusline_bg, fg = colors.red },
	YASInsertMode = { bg = colors.statusline_bg, fg = colors.vibrant_green },
	YASVisualMode = { bg = colors.statusline_bg, fg = colors.blue },
	YASReplaceMode = { bg = colors.statusline_bg, fg = colors.purple },
	YASCmdMode = { bg = colors.statusline_bg, fg = colors.yellow },
	YASOtherMode = { bg = colors.statusline_bg, fg = colors.vibrant_green },
	YASGitAdded = { bg = colors.statusline_bg, fg = colors.green },
	YASGitChanged = { bg = colors.statusline_bg, fg = colors.orange },
	YASGitRemoved = { bg = colors.statusline_bg, fg = colors.red },
	YASGitBranch = { bg = colors.statusline_bg, fg = colors.cyan },
	YASLspStatus = { bg = colors.statusline_bg, fg = colors.red },
	YASLspError = { bg = colors.statusline_bg, fg = colors.red },
	YASLspWarnings = { bg = colors.statusline_bg, fg = colors.yellow },
	YASLspHints = { bg = colors.statusline_bg, fg = colors.purple },
	YASLspInfo = { bg = colors.statusline_bg, fg = colors.green },
}

return YALColorscheme
