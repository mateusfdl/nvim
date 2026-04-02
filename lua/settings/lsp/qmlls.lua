local M = {}

local bin = vim.fn.exepath("qmlls")
M.cmd = { bin }
M.filetypes = { "qml", "qmljs" }

M.init_options = {
	lint = true,
}

M.settings = {
	qml = {
		lint = {
			["missing-property"] = "ignore",
		},
	},
}

M.on_attach = function() end

return M
