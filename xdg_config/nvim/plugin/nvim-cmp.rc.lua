local ok_cmp, cmp = pcall(require, "cmp")
if not ok_cmp then
  return
end

local ok, lspkind = pcall(require, "lspkind")
if not ok then
  return
end

local compare = require("cmp.config.compare")
local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  cmp_tabnine = "[TN]",
  path = "[Path]",
}

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
    { name = "nvim_lsp", keyword_length = 2, max_item_count = 5 },
    { name = "cmp_tabnine", max_item_count = 5 },
    { name = "nvim_lua", keyword_length = 2, max_item_count = 5 },
    { name = "path" },
    { name = "luasnip", keyword_length = 2, max_item_count = 5 },
    { name = "buffer", keyword_length = 5, max_item_count = 5 },
  }),
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      require("cmp_tabnine.compare"),
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
  formatting = {
    format = function(entry, vim_item)
      -- if you have lspkind installed, you can use it like
      -- in the following line:
      vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
      vim_item.menu = source_mapping[entry.source.name]
      if entry.source.name == "cmp_tabnine" then
        local detail = (entry.completion_item.data or {}).detail
        vim_item.kind = ""
        if detail and detail:find(".*%%.*") then
          vim_item.kind = vim_item.kind .. " " .. detail
        end

        if (entry.completion_item.data or {}).multiline then
          vim_item.kind = vim_item.kind .. " " .. "[ML]"
        end
      end

      local maxwidth = 80
      vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
      return vim_item
    end,
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
