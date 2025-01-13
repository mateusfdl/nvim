local lsp_clients = {}

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local buf_name = vim.api.nvim_buf_get_name(buf)

        -- Skip [No Name] buffers and buffers already initialized
        if buf_name == "" or lsp_clients[buf] then
            return
        end

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local lsp_configs = {
            ts_ls = require("settings.lsp.tsserver"),
            solargraph = require("settings.lsp.solargraph"),
            gopls = require("settings.lsp.golang"),
            hls = require("settings.lsp.haskell"),
            lua_ls = require("settings.lsp.lua"),
            clangd = require("settings.lsp.clangd"),
            elixirls = require("settings.lsp.elixir"),
            jsonls = require("settings.lsp.json"),
            tailwindcss = require("settings.lsp.tailwind"),
            sourcekit = require("settings.lsp.sourcekit"),
        }

        for lsp, config in pairs(lsp_configs) do
            vim.schedule(function()
                require("lspconfig")[lsp].setup({
                    capabilities = capabilities,
                    on_attach = config.on_attach,
                    cmd = config.cmd,
                    settings = config.settings,
                    filetypes = config.filetypes,
                    init_options = config.init_options,
                })
            end)
        end

        -- Mark the buffer as initialized
        lsp_clients[buf] = true
    end,
})
