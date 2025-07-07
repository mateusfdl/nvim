local M = {}

function M.attacher(client)
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false
end

M.cmd = { vim.fn.stdpath("data") .. "/mason/bin/elixir-ls" }

return M
