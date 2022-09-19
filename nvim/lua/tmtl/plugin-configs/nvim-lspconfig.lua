local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lspconfig").sumneko_lua.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

local servers = { "rust_analyzer", "tsserver", "sumneko_lua" }
for _, ls in pairs(servers) do
    require("lspconfig")[ls].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end
