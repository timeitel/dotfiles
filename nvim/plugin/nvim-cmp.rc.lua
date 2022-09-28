local ok_cmp, cmp = pcall(require, "cmp")
if not ok_cmp then
    return
end

local ok, lspkind = pcall(require, "lspkind")
if not ok then
    return
end

lspkind.init()

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-h>"] = cmp.mapping.close(),
        ["<C-l>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip", keyword_length = 3, max_item_count = 10 },
        { name = "buffer", keyword_length = 3, max_item_count = 10 },
    }),
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
                gh_issues = "[issues]",
                tn = "[TabNine]",
            },
        }),
    },
})

vim.cmd([[
  highlight! default link CmpItemKind CmpItemMenuDefault
]])
