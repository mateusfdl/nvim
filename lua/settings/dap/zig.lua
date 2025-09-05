local dap = require("dap")

dap.adapters.lldb = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
	name = "lldb",
}

dap.configurations.zig = {
	{
		name = "Launch file",
		type = "lldb",
		request = "launch",
		program = function()
			local cwd = vim.fn.getcwd()
			vim.fn.system("zig build")
			local program_name = vim.fn.fnamemodify(cwd, ":t")
			return cwd .. "/zig-out/bin/" .. program_name
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
	{
		name = "Launch with arguments",
		type = "lldb",
		request = "launch",
		program = function()
			local cwd = vim.fn.getcwd()
			vim.fn.system("zig build")
			local program_name = vim.fn.fnamemodify(cwd, ":t")
			return cwd .. "/zig-out/bin/" .. program_name
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = function()
			local args_string = vim.fn.input("Program arguments: ")
			return vim.split(args_string, " ")
		end,
		runInTerminal = false,
	},
	{
		name = "Attach to process",
		type = "lldb",
		request = "attach",
		pid = function()
			return require("dap.utils").pick_process()
		end,
		args = {},
	},
}