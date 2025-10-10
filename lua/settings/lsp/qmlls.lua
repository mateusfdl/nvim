local M = {}

M.cmd = { vim.fn.stdpath("data") .. "/mason/bin/qmlls" }
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
