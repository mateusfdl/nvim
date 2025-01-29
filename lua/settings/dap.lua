local dap = require("dap")
local ui = require("dapui")

require("dapui").setup()
require("dap-go").setup()

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
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	ui.close()
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
