local dap = require("dap")
local dap_go = require("dap-go")

dap.adapters.delve = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
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
		name = "Debug test",
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
		name = "Debug test (go.mod) with flags",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
		buildFlags = dap_go.get_build_flags,
	},
	{
		type = "go",
		name = "Debug test with flags",
		request = "launch",
		mode = "test",
		program = "${file}",
		buildFlags = dap_go.get_build_flags,
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
		port = 40000,
		host = "127.0.0.1",
	},
}
