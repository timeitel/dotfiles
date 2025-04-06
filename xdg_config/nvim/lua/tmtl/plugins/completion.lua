local base_keymap = {
  preset = "none",
  ["<C-space>"] = { "show_documentation", "hide_documentation" },
  ["<C-c>"] = { "cancel", "fallback" },
  ["<C-l>"] = { "select_and_accept", "fallback_to_mappings" },
  ["<Up>"] = { "select_prev", "fallback" },
  ["<Down>"] = { "select_next", "fallback" },
  ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
  ["<C-j>"] = {
    function(cmp)
      if cmp.is_active() then
        return cmp.select_next()
      else
        return cmp.show()
      end
    end,
    "show",
    "fallback_to_mappings",
  },
}

local M = {
  {
    "saghen/blink.cmp",
    dependencies = { "L3MON4D3/LuaSnip" },
    version = "1.*",
    opts = {

      completion = {
        ghost_text = { enabled = true },
        menu = { auto_show = false },
      },

      keymap = vim.tbl_extend("error", base_keymap, {
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-n>"] = { "snippet_forward", "fallback_to_mappings" },
        ["<C-p>"] = { "snippet_backward", "fallback_to_mappings" },
      }),

      cmdline = {
        keymap = vim.tbl_extend("error", base_keymap, {
          ["<M-l>"] = { "select_accept_and_enter", "fallback_to_mappings" },
        }),
      },
    },
  },
}

return M
