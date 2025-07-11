local dap = require("dap")
local dapui = require("dapui")
require("dapui.config.highlights").setup()
require("settings.dap.go")
require("settings.dap.node")
require("settings.dap.lua")

local function get_dap_layout()
	local screen_width = vim.o.columns
	local screen_height = vim.o.lines
	local left_size = math.max(40, math.min(120, math.floor(screen_width * 0.28)))
	local bottom_size = math.max(10, math.min(30, math.floor(screen_height * 0.23)))

	return {
		{
			elements = {
				"scopes",
				"breakpoints",
				"stacks",
				"watches",
			},
			size = left_size,
			position = "left",
		},
		{
			elements = { "repl" },
			size = bottom_size,
			position = "bottom",
		},
	}
end

dapui.setup({
	controls = {
		element = "repl",
		enabled = true,
	},
	expand_lines = false,
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	layouts = get_dap_layout(),
	render = {
		max_value_lines = 3,
		max_type_length = nil,
		sort_variables = function(a, b)
			return a.name < b.name
		end,
	},
	floating = {
		max_height = nil,
		max_width = nil,
		border = "single",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
})

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_disconnect.dapui_config = function()
	dapui.close()
end

local function resize_dap_panels()
	if dapui then
		local dap_open = false
		for _, win in pairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			local buf_name = vim.api.nvim_buf_get_name(buf)
			if buf_name:match("DAP") then
				dap_open = true
				break
			end
		end

		if dap_open then
			dapui.close()
			vim.defer_fn(function()
				dapui.setup({
					controls = {
						element = "repl",
						enabled = true,
					},
					expand_lines = false,
					icons = { expanded = "▾", collapsed = "▸" },
					mappings = {
						open = "o",
						remove = "d",
						edit = "e",
						repl = "r",
						toggle = "t",
					},
					layouts = get_dap_layout(),
					render = {
						max_value_lines = 3,
						max_type_length = nil,
						sort_variables = function(a, b)
							return a.name < b.name
						end,
					},
					floating = {
						max_height = nil,
						max_width = nil,
						border = "single",
						mappings = {
							close = { "q", "<Esc>" },
						},
					},
					windows = { indent = 1 },
				})
				dapui.open()
			end, 100)
		end
	end
end

vim.api.nvim_create_user_command("DapResize", resize_dap_panels, { desc = "Resize DAP panels to fit screen" })
vim.fn.sign_define("DapBreakpoint", { text = "•", texthl = "DapBreakpointText", linehl = "" })
vim.fn.sign_define("DapStopped", { text = "|>", texthl = "DapStoppedText", linehl = "DapStoppedLine" })
