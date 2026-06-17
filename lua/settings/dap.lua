local dap = require("dap")
local dapui = require("dapui")
require("dapui.config.highlights").setup()
require("settings.dap.go")
require("settings.dap.node")
require("settings.dap.lua")
require("settings.dap.cpp")
require("settings.dap.zig")
require("settings.dap.ocaml")

local function bounded(value, minimum, maximum)
	return math.max(minimum, math.min(maximum, value))
end

local function get_dap_layout()
	local screen_width = vim.o.columns
	local screen_height = vim.o.lines
	local left_size = bounded(math.floor(screen_width * 0.28), 35, 60)
	local bottom_size = bounded(math.floor(screen_height * 0.25), 10, 18)

	return {
		{
			elements = {
				{ id = "scopes", size = 0.45 },
				{ id = "stacks", size = 0.25 },
				{ id = "breakpoints", size = 0.15 },
				{ id = "watches", size = 0.15 },
			},
			size = left_size,
			position = "left",
		},
		{
			elements = {
				{ id = "repl", size = 0.5 },
				{ id = "console", size = 0.5 },
			},
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

vim.fn.sign_define("DapBreakpoint", { text = "•", texthl = "DapBreakpointText", linehl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "?", texthl = "DapBreakpointConditionText", linehl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "x", texthl = "DapBreakpointRejectedText", linehl = "" })
vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "DapLogPointText", linehl = "" })
vim.fn.sign_define("DapStopped", { text = "|>", texthl = "DapStoppedText", linehl = "DapStoppedLine" })
