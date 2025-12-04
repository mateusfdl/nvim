local function is_xcode_project()
	local has_xcodeproj = vim.fn.glob("*.xcodeproj") ~= ""
	local has_xcworkspace = vim.fn.glob("*.xcworkspace") ~= ""
	local has_package_swift = vim.fn.filereadable("Package.swift") == 1
	local has_project_yml = vim.fn.filereadable("Project.yml") == 1
	return has_xcodeproj or has_xcworkspace or has_package_swift or has_project_yml
end

if vim.loop.os_uname().sysname == "Darwin" then
	require("xcodebuild").setup({
		code_coverage = {
			enabled = true,
		},
	})

	if is_xcode_project() then
		local xcodebuild = require("xcodebuild.integrations.dap")
		local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"

		xcodebuild.setup(codelldb_path)

		require("utils.mappings")
		nnoremap("<space>c", xcodebuild.build_and_debug, { desc = "Build & Debug" })
		nnoremap("<space>nc", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
		nnoremap("<space>t", xcodebuild.debug_tests, { desc = "Debug Tests" })
		nnoremap("<space>ct", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
		nnoremap("<space>a", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		nnoremap("<space>A", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
		nnoremap("<space>s", xcodebuild.terminate_session, { desc = "Terminate Debugger" })
	end
end
