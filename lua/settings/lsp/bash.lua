local M = {}

M.cmd = { vim.fn.stdpath("data") .. "/mason/bin/bash-language-server", "start" }
M.filetypes = { "bash", "sh" }

return M