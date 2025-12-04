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

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	performance = {
		debounce = 60,
		throttle = 30,
		fetching_timeout = 500,
		confirm_resolve_timeout = 80,
		async_budget = 1,
		max_view_entries = 200,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function()
			local suggestion = require("supermaven-nvim.completion_preview")

			if suggestion.has_suggestion() then
				suggestion.on_accept_suggestion()
			elseif cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp", priority = 1000, max_item_count = 30 },
		{ name = "vsnip", priority = 750, max_item_count = 10 },
		{ name = "nvim_lua", priority = 600, max_item_count = 15 },
		{ name = "path", option = { trailing_slash = true }, priority = 500, max_item_count = 10 },
		{ name = "nvim_lsp_signature_help", priority = 450, max_item_count = 5 },
		{ name = "npm", keyword_length = 2, priority = 400, max_item_count = 10 },
	}, {
		{ name = "buffer", priority = 300, max_item_count = 5 },
	}),
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				vsnip = "[Snippet]",
				nvim_lsp_signature_help = "[LSP]",
				path = "[Path]",
				buffer = "[Buffer]",
				nvim_lua = "[Lua]",
				npm = "[NPM]",
				latex_symbols = "[LaTeX]",
			})[entry.source.name]
			return vim_item
		end,
	},
})
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
