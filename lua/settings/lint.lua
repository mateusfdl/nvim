local language_linters = {
	javascript = { "eslint" },
	typescript = { "eslint" },
	json = { "eslint" },
	yaml = { "eslint" },
	lua = { "luacheck" },
	go = { "golangcilint" },
	gomod = { "golangcilint" },
	gowork = { "golangcilint" },
	ruby = { "rubocop" },
	c = { "clangtidy" },
	cpp = { "clangtidy" },
	cmake = { "cmaketidy" },
	make = { "cmaketidy" },
	dockerfile = { "dockerlint" },
	bash = { "shellcheck" },
	swift = { "swiftlint" },
}

local file_types = function()
	local ft = {}

	for k, _ in pairs(language_linters) do
		table.insert(ft, k)
	end

	return ft
end

require("lint").linters_by_ft = language_linters

return {
	file_types = file_types,
}
