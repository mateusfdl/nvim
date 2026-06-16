local async = require("plenary.async")
local M = {}

local function go_fallback(args)
	async.run(function()
		vim.cmd("silent !goimports -w " .. args.cwd)
		vim.cmd("edit")
	end)
end

local fallback_map = {
	gopls = go_fallback,
}

local function changes_for(args)
	return {
		files = { {
			oldUri = vim.uri_from_fname(args.old_name),
			newUri = vim.uri_from_fname(args.new_name),
		} },
	}
end

function M.will_rename(args)
	local changes = changes_for(args)

	for _, client in ipairs(vim.lsp.get_clients()) do
		if client:supports_method("workspace/willRenameFiles") then
			local resp = client:request_sync("workspace/willRenameFiles", changes, 1000, 0)
			if resp and resp.result ~= nil then
				vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
			elseif resp and resp.err ~= nil and fallback_map[client.name] ~= nil then
				args.cwd = vim.fn.getcwd()
				fallback_map[client.name](args)
			end
		end
	end
end

function M.did_rename(args)
	local changes = changes_for(args)

	for _, client in ipairs(vim.lsp.get_clients()) do
		if client:supports_method("workspace/didRenameFiles") then
			client:notify("workspace/didRenameFiles", changes)
		end
	end
end

function M.setup()
	local ok_nvim_tree, nvim_tree_api = pcall(require, "nvim-tree.api")
	if not ok_nvim_tree then
		return
	end

	local event = nvim_tree_api.events.Event
	nvim_tree_api.events.subscribe(event.WillRenameNode, M.will_rename)
	nvim_tree_api.events.subscribe(event.NodeRenamed, M.did_rename)
end

return M
