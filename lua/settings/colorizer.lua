require("colorizer").setup({
	filetypes = {
		"html",
		"css",
		"javascript",
		"typescript",
		"typescriptreact",
		"javascriptreact",
		"lua",
	},
	options = {
		parsers = {
			css = true,
			tailwind = { enable = false },
		},
		display = {
			mode = "background",
		},
	},
})
