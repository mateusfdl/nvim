local M = {}

M.cmd = { vim.fn.stdpath("data") .. "/mason/bin/solargraph", "stdio" }

function M.attacher(client, bufnr)
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false
end

return M
