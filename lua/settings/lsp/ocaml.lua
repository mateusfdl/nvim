local M = {}

M.cmd = { "ocamllsp" }

M.settings = {
	ocamllsp = {
		extendedHover = { enable = true },
		inlayHints = { enable = true },
		codelens = { enable = true },
	},
}

return M
