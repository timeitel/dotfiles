local M = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      separator = "-",
      max_lines = 3,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          disable = {},
        },
        indent = {
          enable = true,
          disable = {},
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            scope_incremental = "<CR>",
            node_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
          },
        },
        ensure_installed = {
          "css",
          "gitcommit",
          "go",
          "html",
          "javascript",
          "json",
          "lua",
          "luadoc",
          "markdown",
          "rust",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        autotag = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = false,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "Select function outer" },
              ["if"] = { query = "@function.inner", desc = "Select function inner" },
              ["aa"] = { query = "@parameter.outer", desc = "Select parameter outer" },
              ["ia"] = { query = "@parameter.inner", desc = "Select parameter inner" },
            },
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "v",
            },
            include_surrounding_whitespace = true,
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>sn"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>sp"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]a"] = "@parameter.inner",
            },
            goto_previous_start = {
              ["[a"] = "@parameter.inner",
            },
          },
          lsp_interop = {
            enable = false,
          },
        },
      })

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

      vim.filetype.add({
        extension = {
          mdx = "jsx",
        },
      })
    end,
  },
  {
    "kiyoon/treesitter-indent-object.nvim",
    config = function()
      local map = vim.keymap.set

      map({ "x", "o" }, "aI", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>")
      -- ensure selecting entire line (or just use Vai)
      map({ "x", "o" }, "ai", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>")
      -- select inner block (only if block, only else block, etc.)
      map({ "x", "o" }, "ii", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>")
      -- select entire inner range (including if, else, etc.)
      map({ "x", "o" }, "iI", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>")
    end,
  },
}

return M
