local dap = require("dap")

dap.adapters.ocamlearlybird = {
	type = "executable",
	command = "ocamlearlybird",
	args = { "debug" },
}

dap.configurations.ocaml = {
	{
		name = "Debug bytecode",
		type = "ocamlearlybird",
		request = "launch",
		program = function()
			return vim.fn.input("Path to bytecode: ", vim.fn.getcwd() .. "/_build/default/", "file")
		end,
		stopOnEntry = false,
	},
}
