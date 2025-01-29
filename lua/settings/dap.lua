local dap = require("dap")
local dapui = require("dapui")

require("dap-go").setup()
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

vim.fn.sign_define("DapBreakpoint", { text = "•" })

require("dapui.config.highlights").setup()

dap.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "Run this file",
		start_neovim = {},
	},
	{
		type = "nlua",
		request = "attach",
		name = "Attach to running Neovim instance (port = 8086)",
		port = 8086,
	},
}

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

-- Adapters
dap.adapters.nlua = function(callback, config)
	local adapter = {
		type = "server",
		host = config.host or "127.0.0.1",
		port = config.port or 8086,
	}
	if config.start_neovim then
		local dap_run = dap.run
		dap.run = function(c)
			adapter.port = c.port
			adapter.host = c.host
		end
		require("osv").run_this()
		dap.run = dap_run
	end
	callback(adapter)
end
