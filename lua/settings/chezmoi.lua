local M = {}

M.setup = function()
	require("chezmoi").setup({
		edit = {
			watch = true,
			force = true,
			ignore_patterns = {},
		},
		events = {
			on_open = {
				notification = {
					enable = true,
					msg = "Opened a chezmoi-managed file",
					opts = {},
				},
			},
			on_watch = {
				notification = {
					enable = true,
					msg = "This file will be automatically applied",
					opts = {},
				},
			},
			on_apply = {
				notification = {
					enable = true,
					msg = "Successfully applied",
					opts = {},
				},
			},
		},
		telescope = { select = { "<CR>" } },
	})

	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
		callback = function(ev)
			local bufnr = ev.buf
			local edit_watch = function()
				require("chezmoi.commands.__edit").watch(bufnr)
			end
			vim.schedule(edit_watch)
		end,
	})
end

return M
