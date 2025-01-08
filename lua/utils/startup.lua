M = {}

M.lazy_load = function(mod_name)
	local group = vim.api.nvim_create_augroup("Lazy" .. mod_name, {})
	vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPre" }, {
		group = group,
		callback = function()
			local buf_name = vim.api.nvim_buf_get_name(0)
			-- Load only if the buffer is not [No Name]
			if buf_name ~= "" then
				require("lazy").load({ plugins = { mod_name } })
				vim.api.nvim_del_augroup_by_name("Lazy" .. mod_name)
			end
		end,
	})
end

return M
