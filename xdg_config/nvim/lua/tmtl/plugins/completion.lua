local M = {
  "L3MON4D3/LuaSnip",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-document-symbol",
  "hrsh7th/cmp-cmdline",
  "saadparwaiz1/cmp_luasnip",
  "onsails/lspkind-nvim",
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
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
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end, { "i" }),
        ["<C-l>"] = cmp.mapping({
          i = function()
            if cmp.visible() then
              cmp.confirm({ select = true })
            else
              cmp.complete()
            end
          end,
          c = function()
            if cmp.visible() then
              cmp.confirm({ select = true })
            else
              vim.api.nvim_input("<cr>")
            end
          end,
        }),
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local ts_utils = require("nvim-treesitter.ts_utils")
      cmp.event:on("confirm_done", function(evt)
        local node = ts_utils.get_node_at_cursor()
        if node == nil then
          cmp_autopairs.on_confirm_done()(evt)
          return
        end

        if node:type() ~= "named_imports" then
          cmp_autopairs.on_confirm_done()(evt)
        end
      end)

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered({
            winhighlight = "Normal:transparentBG,FloatBorder:transparentBG,Search:None",
          }),
          documentation = cmp.config.window.bordered(),
        },

        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        mapping = mapping,

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "path" },
          { name = "luasnip" },
          { name = "buffer", keyword_length = 5 },
        }),

        sorting = {
          comparators = {
            cmp.config.compare.sort_text,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,

            function(entry1, entry2)
              local _, entry1_under = entry1.completion_item.label:find("^_+")
              local _, entry2_under = entry2.completion_item.label:find("^_+")
              entry1_under = entry1_under or 0
              entry2_under = entry2_under or 0
              if entry1_under > entry2_under then
                return false
              elseif entry1_under < entry2_under then
                return true
              end
            end,

            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },

        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            menu = {
              buffer = "[BUF]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[API]",
              path = "[PATH]",
              luasnip = "[SNIP]",
            },
          }),
        },
      })

      cmp.setup.cmdline(":", {
        mapping = mapping,
        sources = {
          { name = "cmdline", keyword_length = 2, max_item_count = 10 },
          { name = "nvim_lua", keyword_length = 2, max_item_count = 10 },
        },
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = mapping,
        sources = {
          { name = "buffer", keyword_length = 3 },
        },
      })

      vim.cmd([[ highlight! default link CmpItemKind CmpItemMenuDefault ]])
    end,
  },
}

return M
