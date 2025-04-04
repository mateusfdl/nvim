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

function M.setup()
	local ok_nvim_tree, nvim_tree_api = pcall(require, "nvim-tree.api")
	if ok_nvim_tree then
		local nvim_tree_event = nvim_tree_api.events.Event
		local events = {
			nvim_tree_event.NodeRenamed,
		}

		for _, event in ipairs(events) do
			nvim_tree_api.events.subscribe(event, function(args)
				M.sync_on_rename(args)
			end)
		end
	end
end

function M.sync_on_rename(args)
	local changes = {
		files = { {
			oldUri = vim.uri_from_fname(args.old_name),
			newUri = vim.uri_from_fname(args.new_name),
		} },
	}

	local clients = (vim.lsp.get_clients)()
	for _, client in ipairs(clients) do
		if client.supports_method("workspace/willRenameFiles") then
			local resp = client.request_sync("workspace/willRenameFiles", changes, 1000, 0)
			if resp then
				if resp.result ~= nil then
					vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
				elseif resp.err ~= nil then
					args.cwd = vim.fn.getcwd()
					if fallback_map[client.name] ~= nil then
						fallback_map[client.name](args)
					end
				end
			end
		end
	end

	for _, client in ipairs(clients) do
		if client.supports_method("workspace/didRenameFiles") then
			client.notify("workspace/didRenameFiles", changes)
		end
	end
end

return M
