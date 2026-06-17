local dap = require("dap")

local function earlybird_adapter(callback)
	local command = vim.fn.exepath("ocamlearlybird")
	if command == "" then
		vim.notify("ocamlearlybird is not installed or not in PATH", vim.log.levels.ERROR)
		return
	end

	callback({
		type = "executable",
		command = command,
		args = { "debug" },
	})
end

local function prompt_bytecode()
	local bytecode = vim.fn.input("Path to bytecode: ", vim.fn.getcwd() .. "/_build/default/", "file")
	if bytecode == "" then error("Bytecode path is required") end
	return bytecode
end

local function build_and_prompt_bytecode()
	local result = vim.fn.system({ "dune", "build" })
	if vim.v.shell_error ~= 0 then error("dune build failed:\n" .. result) end
	return prompt_bytecode()
end

dap.adapters.ocamlearlybird = earlybird_adapter

dap.configurations.ocaml = {
	{
		name = "Debug bytecode",
		type = "ocamlearlybird",
		request = "launch",
		program = prompt_bytecode,
		stopOnEntry = false,
	},
	{
		name = "Build and debug bytecode",
		type = "ocamlearlybird",
		request = "launch",
		program = build_and_prompt_bytecode,
		stopOnEntry = false,
	},
}
