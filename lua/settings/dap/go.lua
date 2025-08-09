local dap = require("dap")
local dap_go = require("dap-go")

dap.adapters.delve = {
	type = "server",
	port = "${port}",
	executable = {
		command = "delve",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

dap_go.setup()

dap.configurations.go = {
	{
		type = "go",
		name = "Debug Single File",
		request = "launch",
		program = "${file}",
	},
	{
		type = "go",
		name = "Debug Current Project",
		request = "launch",
		program = "./${relativeFileDirname}",
	},
	{
		type = "go",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	{
		type = "go",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
	{
		type = "go",
		name = "Debug Current CMD/main.go",
		request = "launch",
		program = "./cmd/app/main.go",
	},
  {
		type = "go",
		name = "Attach to Running Delve",
		request = "attach",
		mode = "remote",
		port = 40000, -- Change this to match the port used by your running dlv instance
		host = "127.0.0.1",
	},
}
