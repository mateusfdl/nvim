local M = {}
require("utils.lua")

vim.g.mapleader = ","

local setup_lazy = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end

function M.setup()
  setup_lazy()

  require("plugins")
  require("settings.init").setup()
  require("mappings").setup()

  vim.defer_fn(function()
    require("plugins")
  end, 0)
end

return M
