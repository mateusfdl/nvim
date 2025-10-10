local dap = require("dap")
local dap_utils = require("dap.utils")

for _, adapterType in ipairs({ "node", "chrome", "msedge", "node-terminal", "extensionHost" }) do
	local pwaType = "pwa-" .. adapterType

	dap.adapters[pwaType] = {
		type = "server",
		host = "localhost",
		port = "${port}",
		executable = {
			command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
			args = {
				"${port}",
			},
		},
	}

	dap.adapters[adapterType] = function(cb, config)
		local nativeAdapter = dap.adapters[pwaType]

		config.type = pwaType

		if type(nativeAdapter) == "function" then
			nativeAdapter(cb, config)
		else
			cb(nativeAdapter)
		end
	end
end

for _, ext in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" }) do
	dap.configurations[ext] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Node - Launch Program",
			cwd = vim.fn.getcwd(),
			args = { "${file}" },
			sourceMaps = true,
			protocol = "inspector",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "TS-Node - Launch Current File",
			cwd = vim.fn.getcwd(),
			runtimeExecutable = "node",
			runtimeArgs = { "--nolazy", "-r", "ts-node/register", "-r", "tsconfig-paths/register" },
			args = { "${file}" },
			sourceMaps = true,
			skipFiles = { "<node_internals>/**", "node_modules/**" },
			resolveSourceMapLocations = { "${workspaceFolder}/**", "${workspaceFolder}/node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Denon - Run file",
			cwd = vim.fn.getcwd(),
			runtimeExecutable = "deno",
			runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
			attachSimplePort = 9229,
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Jest - Run test",
			cwd = vim.fn.getcwd(),
			runtimeExecutable = "node",
			args = {
				"--inspect",
				"${workspaceFolder}/node_modules/jest/bin/jest.js",
				"--runInBand",
				"--no-coverage",
				"${file}",
			},
			sourceMaps = true,
			skipFiles = { "<node_internals>/**", "node_modules/**" },
			protocol = "inspector",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Vitest - Run test",
			cwd = vim.fn.getcwd(),
			program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
			args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
			autoAttachChildProcesses = true,
			smartStep = true,
			console = "integratedTerminal",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Deno - Run test",
			cwd = vim.fn.getcwd(),
			runtimeExecutable = "deno",
			runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
			smartStep = true,
			console = "integratedTerminal",
			attachSimplePort = 9229,
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "JAPA - Run test",
			cwd = vim.fn.getcwd(),
			program = "${workspaceFolder}/node_modules/.bin/ts-node",
			args = { "${workspaceFolder}/japa/test.ts", "--files=${file}" },
			autoAttachChildProcesses = true,
			smartStep = true,
			sourceMaps = true,
			console = "integratedTerminal",
			skipFiles = {
				"<node_internals>/**",
				"node_modules/**",
				"**/node_modules/ts-node/**",
			},
		},
		{
			type = "pwa-chrome",
			request = "attach",
			name = "Chrome - Attach",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			port = function()
				return vim.fn.input("Select port: ", 9222)
			end,
			webRoot = "${workspaceFolder}",
			urlFilter = "*",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Node - PID Attach",
			cwd = vim.fn.getcwd(),
			processId = dap_utils.pick_process,
			skipFiles = { "<node_internals>/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Nest Application",
			args = { "/src/main.ts" },
			runtimeArgs = { "--nolazy", "-r", "ts-node/register", "-r", "tsconfig-paths/register" },
			console = "integratedTerminal",
			cwd = vim.fn.getcwd(),
			protocol = "inspector",
			restart = true,
			sourceMaps = true,
			outFiles = { "${workspaceRoot}/dist/**/*.js" },
		},
	}
end
