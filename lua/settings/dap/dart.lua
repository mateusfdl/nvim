local dap = require("dap")

if not dap.adapters.dart then
	dap.adapters.dart = {
		type = "executable",
		command = "dart",
		args = { "debug_adapter" },
	}
end

dap.configurations.dart = dap.configurations.dart or {}

local has_config = false
for _, cfg in ipairs(dap.configurations.dart) do
	if cfg.name == "Launch Dart" then
		has_config = true
		break
	end
end

if not has_config then
	table.insert(dap.configurations.dart, {
		type = "dart",
		request = "launch",
		name = "Launch Dart",
		program = "${file}",
	})
	table.insert(dap.configurations.dart, {
		type = "dart",
		request = "launch",
		name = "Launch Dart (bin)",
		program = function()
			local root_dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
			return "bin/" .. root_dir_name .. ".dart"
		end,
	})
end
