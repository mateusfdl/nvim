vim.opt_local.conceallevel = 2
local note_id_func = function(title)
	local suffix = ""
	if title ~= nil then
		suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
	else
		for _ = 1, 4 do
			suffix = suffix .. string.char(math.random(65, 90))
		end
	end
	local time = os.date("*t")
	return tostring(
		string.format("%04d%02d%02d%02d%02d", time.year, time.month, time.day, time.hour, time.min) .. "-" .. suffix
	)
end

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	pattern = vim.env.HOME .. "/org/**/*.md",
	callback = function()
		vim.opt_local.conceallevel = 2
	end,
})
require("obsidian").setup({
	workspaces = {
		{ name = "personal", path = "~/org/Personal" },
	},
	log_level = vim.log.levels.INFO,
	new_notes_location = "notes_subdir",
	note_id_func = note_id_func,
	disable_frontmatter = true,
	completion = {
		nvim_cmp = true,
		min_chars = 2,
	},
	attachments = {
		img_folder = "Attachments",
	},
	templates = {
		folder = "Templates",
		subdir = "Templates",
	},
})
