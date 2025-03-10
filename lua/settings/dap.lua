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
		icons = {
			disconnect = "■",
			pause = "",
			play = "▶",
			run_last = "≪",
			step_back = "←",
			step_into = "↓",
			step_out = "↑",
			step_over = "→",
			terminate = "✗",
		},
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
				"repl",
			},
			size = 0.3,
			position = "bottom",
		},
		{
			elements = {
				"breakpoints",
				"stacks",
			},
			size = 0.1,
			position = "left",
		},
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
	render = {
		max_type_length = nil,
	},
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
