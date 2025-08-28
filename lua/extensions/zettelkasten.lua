local Zettelkasten = {}

Zettelkasten.config = { notes_path = "~/org/Personal/Staging/" }

function Zettelkasten.setup(opts)
	Zettelkasten.config = vim.tbl_extend("force", Zettelkasten.config, opts or {})

	vim.api.nvim_create_user_command("NZ", function(opts)
		local note_name = opts.args
		Zettelkasten.create_note(note_name)
	end, {
		nargs = "*",
		complete = function()
			return {}
		end,
	})
end

function Zettelkasten.create_note(note_name)
	if not note_name or note_name == "" then
		print("Note name cannot be empty")
		return
	end

	local normalized_name = note_name:gsub("%s+", "-"):lower()

	local timestamp = os.date("%Y%m%d%H%M")

	local filename = timestamp .. "-" .. normalized_name .. ".md"

	local notes_path = vim.fn.expand(Zettelkasten.config.notes_path)

	vim.fn.mkdir(notes_path, "p")

	local full_path = notes_path .. "/" .. filename

	local content = {
		"---",
		"id: " .. filename,
		"date: " .. os.date("%Y-%m-%d"),
		'hubs: "[[]]"',
		"tags:",
		"refs:",
		"---",
		"",
		"# " .. Zettelkasten.capitalize(note_name),
		"\n",
	}

	local file = io.open(full_path, "w")
	if file then
		for _, line in ipairs(content) do
			file:write(line .. "\n")
		end
		file:close()

		vim.cmd("edit " .. full_path)
		local last_line = vim.api.nvim_buf_line_count(0)
		vim.api.nvim_win_set_cursor(0, { last_line, 0 })
	else
		print("Error: Could not create file " .. full_path)
	end
end

function Zettelkasten.capitalize(str)
	return (str:gsub("^%l", string.upper))
end

return Zettelkasten
