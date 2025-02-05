require("obsidian.nvim").setup({
	workspaces = {
		{ name = "personal", path = "~/org/Personal" },
	},
	log_level = vim.log.levels.INFO,
  disable_frontmatter = true,
	daily_notes = {
		date_format = "%Y-%m-%d",
		alias_format = "%B %-d, %Y",
		default_tags = { "daily" },
		template = nil,
	},
	completion = {
		nvim_cmp = true,
		min_chars = 2,
	},
	attachments = {
		img_folder = "Attachments",
	},
})
