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
	pattern = vim.fn.getenv("NOTES_VAULT") .. "/**/*.md",
	callback = function()
		vim.opt_local.conceallevel = 2
	end,
})

require("obsidian").setup({
	ui = { enable = false },
	legacy_commands = false,
	workspaces = {
		{ name = "personal", path = vim.fn.getenv("NOTES_VAULT") },
	},
	log_level = vim.log.levels.INFO,
	new_notes_location = "notes_subdir/Staging",
	note_id_func = note_id_func,
	frontmatter = { enabled = false },
	completion = {
		min_chars = 2,
	},
	attachments = {
		folder = "Attachments",
	},
	templates = {
		folder = "Templates",
	},
	daily_notes = {
		folder = "Journal",
		template = "dayli.md",
	},
})
