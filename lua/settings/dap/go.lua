local dap = require("dap")
local dap_go = require("dap-go")

dap_go.setup()

local function prompt_remote_host()
	local host = vim.fn.input("Delve host: ", "127.0.0.1")
	if host == "" then error("Delve host is required") end
	return host
end

local function prompt_remote_port()
	local port = tonumber(vim.fn.input("Delve port: ", "40000"))
	if port == nil then error("Delve port must be a number") end
	return port
end

dap.configurations.go = {
	{
		type = "go",
		name = "Debug file",
		request = "launch",
		program = "${file}",
	},
	{
		type = "go",
		name = "Debug package",
		request = "launch",
		program = "./${relativeFileDirname}",
	},
	{
		type = "go",
		name = "Debug package test",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
	{
		type = "go",
		name = "Debug file test",
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	{
		type = "go",
		name = "Debug package test with flags",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
		buildFlags = dap_go.get_build_flags,
	},
	{
		type = "go",
		name = "Attach to remote Delve",
		request = "attach",
		mode = "remote",
		host = prompt_remote_host,
		port = prompt_remote_port,
	},
}
