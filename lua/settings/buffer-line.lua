require("bufferline").setup({
	options = {
		buffer_close_icon = "",
		modified_icon = "",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 14,
		max_prefix_length = 13,
		tab_size = 18,
		enforce_regular_tabs = true,
		view = "multiwindow",
		show_buffer_close_icons = true,
		separator_style = "thin",
		always_show_bufferline = false,
	},

	highlights = {
		background = {
			guifg = "#282c34",
			guibg = "#282c34",
		},
		fill = {
			guifg = "#282c34",
			guibg = "#282c34",
		},
		buffer_selected = {
			guifg = "#3A3E44",
			guibg = "#3A3E44",
			gui = "bold",
		},
		separator_visible = {
			guifg = "#282c34",
			guibg = "#282c34",
		},
		separator_selected = {
			guifg = "#282c34",
			guibg = "#282c34",
		},
		separator = {
			guifg = "#282c34",
			guibg = "#282c34",
		},
		indicator_selected = {
			guifg = "#282c34",
			guibg = "#282c34",
		},
		modified_selected = {
			guifg = "#3A3E44",
			guibg = "#3A3E44",
		},
	},
})
