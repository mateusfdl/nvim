local M = {}

M.cmd = { vim.fn.stdpath("data") .. "/mason/bin/nil" }

M.settings = {
	["nil"] = {
		formatting = {
			command = { "nixfmt" },
		},
		nix = {
			flake = {
				autoArchive = true,
				autoEvalInputs = true,
			},
		},
	},
}

return M
