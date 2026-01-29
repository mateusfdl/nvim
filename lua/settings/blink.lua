local kind_icons = {
	Text = "",
	Method = "",
	Function = "󰊕",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "󰚯",
	Value = "󰫧",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "󰌁",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

local function has_stride_suggestion()
	local ok, stride_ui = pcall(require, "stride.ui")
	if ok and stride_ui.current_suggestion then
		return stride_ui.current_suggestion.text and stride_ui.current_suggestion.text ~= ""
	end
	return false
end

require("blink.cmp").setup({
	snippets = { preset = "luasnip" },

	keymap = {
		preset = "default",
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = {
			function()
				if has_stride_suggestion() then
					return true
				end
				return false
			end,
			"select_prev",
			"snippet_backward",
			"fallback",
		},
		["<CR>"] = { "accept", "fallback" },
		["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<C-u>"] = { "scroll_documentation_up", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
	},

	completion = {
		accept = { auto_brackets = { enabled = true } },
		list = {
			max_items = 5,
			selection = { preselect = true, auto_insert = false },
		},
		menu = {
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "source_name" },
				},
				components = {
					kind_icon = {
						text = function(ctx)
							return (kind_icons[ctx.kind] or "") .. " "
						end,
						highlight = function(ctx)
							return "BlinkCmpKind" .. ctx.kind
						end,
					},
					source_name = {
						text = function(ctx)
							local labels = {
								lsp = "[LSP]",
								snippets = "[Snippet]",
								path = "[Path]",
								buffer = "[Buffer]",
							}
							return labels[ctx.source_name] or ("[" .. ctx.source_name .. "]")
						end,
						highlight = "BlinkCmpSource",
					},
				},
			},
		},
		documentation = { auto_show = true, auto_show_delay_ms = 200 },
		ghost_text = { enabled = false },
	},

	signature = { enabled = true },

	sources = {
		default = { "lsp", "snippets", "path", "buffer" },
		per_filetype = {
			lua = { "lsp", "path", "buffer", "snippets" },
		},
		providers = {
			lsp = { name = "LSP", score_offset = 1000, max_items = 30 },
			path = { name = "Path", score_offset = 500, max_items = 10 },
			buffer = { name = "Buffer", score_offset = 250, max_items = 5 },
			snippets = { name = "Snippets", score_offset = 200, max_items = 5 },
		},
	},

	appearance = { nerd_font_variant = "mono" },
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
