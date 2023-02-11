local ok_cmp, cmp = pcall(require, "cmp")
if not ok_cmp then
  return
end

local ok, lspkind = pcall(require, "lspkind")
if not ok then
  return
end

lspkind.init()

local mapping = cmp.mapping.preset.insert({
  ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  ["<C-u>"] = cmp.mapping.scroll_docs(4),
  ["<C-j>"] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_next_item()
    else
      cmp.complete()
    end
  end, { "i", "c" }),
  ["<C-k>"] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_prev_item()
    else
      cmp.complete()
    end
  end, { "i", "c" }),
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-q>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.abort()
    else
      fallback()
    end
  end, { "i", "c" }),
  ["<C-l>"] = cmp.mapping(function()
    if cmp.visible() then
      cmp.confirm({ select = true })
    else
      cmp.complete()
    end
  end, { "i", "c" }),
})

-- Insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup({
  window = {
    completion = {
      border = "rounded",
      scrollbar = "║",
    },
    documentation = cmp.config.window.bordered(),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = mapping,
  sources = cmp.config.sources({
    { name = "nvim_lsp", keyword_length = 2, max_item_count = 10 },
    { name = "nvim_lua", keyword_length = 2, max_item_count = 10 },
    { name = "path" },
    { name = "luasnip", keyword_length = 2, max_item_count = 10 },
    { name = "buffer", keyword_length = 5, max_item_count = 10 },
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
      },
    }),
  },
})

cmp.setup.cmdline(":", {
  mapping = mapping,
  sources = {
    { name = "cmdline", keyword_length = 2 },
    { name = "nvim_lua", keyword_length = 2 },
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = mapping,
  sources = {
    { name = "buffer", keyword_length = 2 },
  },
})

vim.cmd([[
  highlight! default link CmpItemKind CmpItemMenuDefault
]])