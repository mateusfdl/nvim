local bit = require("bit")

local M = {}

local NAMESPACE = vim.api.nvim_create_namespace("lsp_documentColor")
local HIGHLIGHT_CACHE = {}

local HIGHLIGHT_MODE_NAMES = {
	background = "mb",
	foreground = "mf",
}

local function lsp_color_to_hex(color)
	local function to256(c)
		return math.floor(c * color.alpha * 255)
	end
	return string.format(
		"%06x",
		bit.bor(bit.lshift(to256(color.red), 16), bit.lshift(to256(color.green), 8), to256(color.blue))
	)
end

local function color_is_bright(r, g, b)
	local luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255
	return luminance > 0.5
end

local function create_highlight(rgb_hex, options)
	local mode = options.mode or "background"
	local cache_key = HIGHLIGHT_MODE_NAMES[mode] .. "_" .. rgb_hex

	if HIGHLIGHT_CACHE[cache_key] then
		return HIGHLIGHT_CACHE[cache_key]
	end

	local highlight_name = "lsp_documentColor_" .. cache_key
	local r, g, b = tonumber(rgb_hex:sub(1, 2), 16), tonumber(rgb_hex:sub(3, 4), 16), tonumber(rgb_hex:sub(5, 6), 16)

	if mode == "foreground" then
		vim.api.nvim_command(string.format("highlight %s guifg=#%s", highlight_name, rgb_hex))
	else
		local fg_color = color_is_bright(r, g, b) and "Black" or "White"
		vim.api.nvim_command(string.format("highlight %s guifg=%s guibg=#%s", highlight_name, fg_color, rgb_hex))
	end

	HIGHLIGHT_CACHE[cache_key] = highlight_name
	return highlight_name
end

local function buf_set_highlights(bufnr, colors, options)
	vim.api.nvim_buf_clear_namespace(bufnr, NAMESPACE, 0, -1)
	for _, color_info in ipairs(colors) do
		local rgb_hex = lsp_color_to_hex(color_info.color)
		local highlight_name = create_highlight(rgb_hex, options)

		local range = color_info.range
		vim.api.nvim_buf_add_highlight(
			bufnr,
			NAMESPACE,
			highlight_name,
			range.start.line,
			range.start.character,
			options.single_column and range.start.character + 1 or range["end"].character
		)
	end
end

local function update_highlight(bufnr, options)
	local params = { textDocument = vim.lsp.util.make_text_document_params() }
	vim.lsp.buf_request(bufnr, "textDocument/documentColor", params, function(err, result)
		if not err and result then
			buf_set_highlights(bufnr, result, options)
		end
	end)
end

local function debounce_trailing(fn, ms)
	local timer = vim.loop.new_timer()
	return function(...)
		local argv = { ... }
		timer:stop()
		timer:start(ms, 0, function()
			pcall(vim.schedule_wrap(fn), unpack(argv))
		end)
	end
end

function M.buf_attach(bufnr, options)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	options = options or {}

	if not M.attached_buffers then
		M.attached_buffers = {}
	end

	if M.attached_buffers[bufnr] then
		return
	end

	M.attached_buffers[bufnr] = true

	local debounced_update = debounce_trailing(function()
		update_highlight(bufnr, options)
	end, options.debounce or 200)

	vim.api.nvim_buf_attach(bufnr, false, {
		on_lines = function()
			if M.attached_buffers[bufnr] then
				debounced_update()
			end
		end,
		on_detach = function()
			M.attached_buffers[bufnr] = nil
		end,
	})

	debounced_update()
end

function M.buf_detach(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_clear_namespace(bufnr, NAMESPACE, 0, -1)
	if M.attached_buffers then
		M.attached_buffers[bufnr] = nil
	end
end

return M
