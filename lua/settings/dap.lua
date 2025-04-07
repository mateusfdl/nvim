local dap = require("dap")
local dapui = require("dapui")
require("dapui.config.highlights").setup()
require("settings.dap.go")
require("settings.dap.node")
require("settings.dap.lua")

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
	layouts = {
		{
			elements = {
				"scopes",
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 80,
			position = "left",
		},
		{
			elements = { "repl" },
			size = 0.25,
			position = "bottom",
		},
	},
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
