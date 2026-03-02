local flutter = require("flutter-tools")

flutter.setup({
	ui = {
		border = "none",
	},
	decorations = {
		statusline = {
			app_version = true,
			device = true,
			project_config = true,
		},
	},
	widget_guides = {
		enabled = true,
	},
	closing_tags = {
		enabled = true,
		prefix = "// ",
	},
	dev_log = {
		enabled = true,
		open_cmd = "tabedit",
	},
	lsp = {
		on = false,
		color = {
			enabled = true,
			background = true,
			virtual_text = false,
		},
	},
	debugger = {
		enabled = true,
		evaluate_to_string_in_debug_views = true,
		exception_breakpoints = {},
		register_configurations = function(paths)
			local dap = require("dap")
			local configs = dap.configurations.dart or {}
			local flavors = {
				{ name = "development", target = "lib/main_development.dart" },
				{ name = "production", target = "lib/main_production.dart" },
			}
			for _, flavor in ipairs(flavors) do
				table.insert(configs, {
					type = "dart",
					request = "launch",
					name = "Launch " .. flavor.name,
					dartSdkPath = paths.dart_sdk,
					flutterSdkPath = paths.flutter_sdk,
					program = flavor.target,
					args = { "--flavor", flavor.name },
				})
			end
			dap.configurations.dart = configs
		end,
	},
})

flutter.setup_project({
	{
		name = "development",
		flavor = "development",
		target = "lib/main_development.dart",
	},
	{
		name = "production",
		flavor = "production",
		target = "lib/main_production.dart",
	},
})

local map = require("utils.mappings")

map.nnoremap("<leader>fr", ":FlutterRun<CR>")
map.nnoremap("<leader>fq", ":FlutterQuit<CR>")
map.nnoremap("<leader>fR", ":FlutterRestart<CR>")
map.nnoremap("<leader>fd", ":FlutterDevices<CR>")
map.nnoremap("<leader>fD", ":FlutterDebug<CR>")
map.nnoremap("<leader>fe", ":FlutterEmulators<CR>")
map.nnoremap("<leader>fo", ":FlutterOutlineToggle<CR>")
map.nnoremap("<leader>fl", ":FlutterDevLog<CR>")
map.nnoremap("<leader>fi", ":FlutterInspectWidget<CR>")
map.nnoremap("<leader>fv", ":FlutterVisualDebug<CR>")
map.nnoremap("<leader>fp", ":FlutterPubGet<CR>")
