local set_keybind = function(mode, lhs, rhs, opts)
	local options = { silent = true }

	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	vim.keymap.set(mode, lhs, rhs, options)
end

local buf_set_keybind = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

local function map(bind, command)
	set_keybind("", bind, command)
end

local function smap(bind, command)
	set_keybind("s", bind, command)
end

local function imap(bind, command)
	set_keybind("i", bind, command)
end

local function nmap(bind, command)
	set_keybind("n", bind, command)
end

local function omap(bind, command)
	set_keybind("o", bind, command)
end

local function xmap(bind, command)
	set_keybind("x", bind, command)
end

local function noremap(bind, command)
	set_keybind("", bind, command, { noremap = true })
end

local function inoremap(bind, command)
	set_keybind("i", bind, command, { noremap = true })
end

local function nnoremap(bind, command)
	set_keybind("n", bind, command, { noremap = true })
end

local function vnoremap(bind, command)
	set_keybind("v", bind, command, { noremap = true })
end

local function xnoremap(bind, command)
	set_keybind("x", bind, command, { noremap = true })
end

local function tnoremap(bind, command)
	set_keybind("t", bind, command, { noremap = true })
end

return {
	imap = imap,
	nmap = nmap,
	omap = omap,
	xmap = xmap,
	map = map,
	smap = smap,
	noremap = noremap,
	inoremap = inoremap,
	nnoremap = nnoremap,
	vnoremap = vnoremap,
	xnoremap = xnoremap,
	tnoremap = tnoremap,
	buf_set_keybind = buf_set_keybind,
}
