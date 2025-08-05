local dap = require("dap")
local dapui = require("dapui")
require("dapui.config.highlights").setup()
require("settings.dap.go")
require("settings.dap.node")
require("settings.dap.lua")

local function get_dap_layout()
	local screen_width = vim.o.columns
	local screen_height = vim.o.lines
	local left_size = math.max(20, math.min(20, math.floor(screen_width * 0.28)))
	local bottom_size = math.max(5, math.min(20, math.floor(screen_height * 0.23)))

	return {
		{
			elements = {
				{ id = "breakpoints", size = 0.23 },
				{ id = "watches", size = 0.77 },
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
		enabled = false,
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

vim.fn.sign_define("DapBreakpoint", { text = "•", texthl = "DapBreakpointText", linehl = "" })
vim.fn.sign_define("DapStopped", { text = "|>", texthl = "DapStoppedText", linehl = "DapStoppedLine" })

local ok, nvimtree_events = pcall(require, "nvim-tree.events")
if ok then
	nvimtree_events.subscribe("TreePreOpen", function()
		dapui.close()
	end)
end
