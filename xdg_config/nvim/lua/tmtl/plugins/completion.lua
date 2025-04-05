local M = {
  {
    "saghen/blink.cmp",
    dependencies = { "L3MON4D3/LuaSnip" },
    version = "1.*",
    opts = {

      completion = { ghost_text = { enabled = true } },

      keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-c>"] = { "cancel", "fallback" },
        ["<C-l>"] = { "select_and_accept" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-j>"] = { "select_next", "fallback_to_mappings" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<C-n>"] = { "snippet_forward", "fallback" },
        ["<C-p>"] = { "snippet_backward", "fallback" },

        ["<C-y>"] = { "show_signature", "hide_signature", "fallback" },
      },

      cmdline = {
        keymap = {
          ["<C-space>"] = { "show" },
          ["<C-c>"] = { "cancel", "fallback" },
          ["<C-l>"] = { "select_and_accept" },

          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
          ["<C-j>"] = { "select_next", "fallback_to_mappings" },
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    opts_extend = { "sources.default" },
  },
}

return M
