local M = {}

local function with_picker_padding(open_picker)
	local winborder = vim.o.winborder
	vim.o.winborder = "single"
	open_picker()
	vim.o.winborder = winborder
end

local function buffer_items()
	local items = {}
	local current_buffer = vim.api.nvim_get_current_buf()

	for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
		if buffer ~= current_buffer and vim.api.nvim_buf_is_loaded(buffer) and vim.bo[buffer].buflisted then
			local name = vim.api.nvim_buf_get_name(buffer)
			if name == "" then
				name = "[No Name]"
			else
				name = vim.fn.fnamemodify(name, ":~:.")
			end

			table.insert(items, {
				buffer = buffer,
				name = name,
			})
		end
	end

	return items
end

function M.find_files()
	with_picker_padding(function()
		require("fff").find_files({ title = "" })
	end)
end

function M.live_grep()
	with_picker_padding(function()
		require("fff").live_grep({ title = "" })
	end)
end

function M.grep_selection()
	local selection = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."))
	with_picker_padding(function()
		require("fff").live_grep({ query = table.concat(selection, "\n"), title = "" })
	end)
end

function M.buffer_searcher()
	vim.ui.select(buffer_items(), {
		prompt = "Buffers",
		format_item = function(item)
			return item.name
		end,
	}, function(item)
		if not item then return end
		vim.api.nvim_set_current_buf(item.buffer)
	end)
end

function M.help_tags()
	vim.ui.select(vim.fn.getcompletion("", "help"), {
		prompt = "Help",
	}, function(item)
		if not item then return end
		vim.cmd.help(item)
	end)
end

function M.git_status()
	local entries = vim.fn.systemlist({ "git", "status", "--short" })
	if vim.v.shell_error ~= 0 then
		vim.notify(table.concat(entries, "\n"), vim.log.levels.ERROR)
		return
	end

	if #entries == 0 then
		vim.notify("No git changes", vim.log.levels.INFO)
		return
	end

	vim.ui.select(entries, {
		prompt = "Git status",
	}, function(item)
		if not item then return end
		local path = item:sub(4):gsub("^.* %-> ", "")
		vim.cmd.edit(vim.fn.fnameescape(path))
	end)
end

function M.git_stash()
	local stashes = vim.fn.systemlist({ "git", "stash", "list" })
	if vim.v.shell_error ~= 0 then
		vim.notify(table.concat(stashes, "\n"), vim.log.levels.ERROR)
		return
	end

	if #stashes == 0 then
		vim.notify("No git stashes", vim.log.levels.INFO)
		return
	end

	vim.ui.select(stashes, {
		prompt = "Git stashes",
	}, function(item)
		if not item then return end
		local stash = item:match("^([^:]+)")
		if not stash then return end
		vim.cmd.tabnew()
		vim.bo.buftype = "nofile"
		vim.bo.bufhidden = "wipe"
		vim.bo.swapfile = false
		vim.api.nvim_buf_set_name(0, "git stash show " .. stash)
		vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist({ "git", "stash", "show", "--stat", "--patch", stash }))
		vim.bo.modified = false
	end)
end

return M
