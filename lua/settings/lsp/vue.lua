local M = {}
local npm_root = vim.fn.system("npm root -g"):gsub("%s+", "")
local function get_vue_typescript_server_path(root_dir)
	local lsputil = require("lspconfig.util")
	local found_ts = ""
	local function check_dir(path)
		found_ts = npm_root .. "/typescript/lib/"
		if lsputil.path.exists(found_ts) then
			return path
		end
	end
	if lsputil.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return nil
	end
end

function M.on_new_config(new_config, new_root_dir)
	new_config.init_options.typescript.tsdk = get_vue_typescript_server_path(new_root_dir)
end

M.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
M.init_options = {
	vue = {
		hybridMode = false,
	},
}

return M
