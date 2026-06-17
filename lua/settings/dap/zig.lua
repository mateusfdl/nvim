local dap = require("dap")
local dap_utils = require("dap.utils")

local function run_command(command)
	local result = vim.fn.system(command)
	if vim.v.shell_error ~= 0 then
		error(table.concat(command, " ") .. " failed:\n" .. result)
	end
	return result
end

local function prompt_executable(default_path)
	local executable = vim.fn.input("Path to executable: ", default_path, "file")
	if executable == "" then error("Executable path is required") end
	return executable
end

local function build_and_prompt_binary()
	run_command({ "zig", "build" })
	local default_path = vim.fn.getcwd() .. "/zig-out/bin/"
	return prompt_executable(default_path)
end

local function build_current_test_binary()
	local file = vim.fn.expand("%:p")
	local outfile = vim.fn.tempname()
	run_command({ "zig", "test", file, "-femit-bin=" .. outfile })
	return outfile
end

dap.configurations.zig = {
	{
		name = "Launch executable",
		type = "codelldb",
		request = "launch",
		program = function()
			return prompt_executable(vim.fn.getcwd() .. "/")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
	{
		name = "Build and launch executable",
		type = "codelldb",
		request = "launch",
		program = build_and_prompt_binary,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
	{
		name = "Launch executable with arguments",
		type = "codelldb",
		request = "launch",
		program = function()
			return prompt_executable(vim.fn.getcwd() .. "/")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = function()
			local args_string = vim.fn.input("Program arguments: ")
			if args_string == "" then return {} end
			return vim.split(args_string, " ", { trimempty = true })
		end,
		runInTerminal = false,
	},
	{
		name = "Attach to process",
		type = "codelldb",
		request = "attach",
		pid = dap_utils.pick_process,
		args = {},
	},
	{
		name = "Debug current file test",
		type = "codelldb",
		request = "launch",
		program = build_current_test_binary,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
}
