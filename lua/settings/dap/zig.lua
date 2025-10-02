local dap = require("dap")

dap.adapters.lldb = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
	name = "lldb",
}

local function build_and_get_binary()
	local cwd = vim.fn.getcwd()
	local result = vim.fn.system("zig build")
	if vim.v.shell_error ~= 0 then
		error("Build failed:\n" .. result)
	end
	local program_name = vim.fn.fnamemodify(cwd, ":t")
	return cwd .. "/zig-out/bin/" .. program_name
end

dap.configurations.zig = {
	{
		name = "Launch file",
		type = "lldb",
		request = "launch",
		program = build_and_get_binary,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
	{
		name = "Launch with arguments",
		type = "lldb",
		request = "launch",
		program = build_and_get_binary,
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
	{
		name = "Run tests (build.zig)",
		type = "lldb",
		request = "launch",
		program = function()
			local cwd = vim.fn.getcwd()
			local result = vim.fn.system("zig build test")
			if vim.v.shell_error ~= 0 then
				error("Tests build failed:\n" .. result)
			end
			local program_name = vim.fn.fnamemodify(cwd, ":t")
			return cwd .. "/zig-out/bin/" .. program_name .. "_test"
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
	{
		name = "Debug test (current file)",
		type = "lldb",
		request = "launch",
		program = function()
			local file = vim.fn.expand("%:p")
			local outfile = vim.fn.tempname()
			local result = vim.fn.system("zig test " .. file .. " -femit-bin=" .. outfile)
			if vim.v.shell_error ~= 0 then
				error("Test compilation failed:\n" .. result)
			end
			return outfile
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
}
