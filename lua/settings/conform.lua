require("conform").setup({
	formatters_by_ft = {
		typescript = function(bufnr)
			local path = vim.fn.getcwd()

			if vim.fs.find("biome.json", { upward = true, path = path })[1] then
				return { "biomejs" }
			else
				return { "prettier" }
			end
		end,
		javascript = {},
		ruby = { "rubocop" },
		lua = { "stylua" },
		vue = { "prettier" },
		swift = { "swiftformat" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
