local dap = require("dap")

dap.adapters["lua-debug-adapter"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "lua-debug-adapter",
		args = { "${port}" },
	},
}
dap.configurations.lua = {
	{
		type = "lua-debug-adapter",
		request = "launch",
		name = "Launch Lua script",
		program = "${file}",
	},
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
