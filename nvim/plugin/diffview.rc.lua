local actions = require("diffview.actions")

local shared_maps = {
  ["L"] = false,
  ["q"] = "<cmd>DiffviewClose<cr>",
  ["<C-h>"] = "<cmd>DiffviewClose<cr>",
  ["f"] = "<cmd>DiffviewToggleFiles<cr>",
  ["<leader>f"] = "<cmd>DiffviewFocusFiles<cr>", -- TODO: add for filehistory panel to toggle history panel
  ["O"] = actions.focus_entry,
  ["<C-e>"] = actions.scroll_view(1),
  ["<C-y>"] = actions.scroll_view(-1),
  ["<C-d>"] = actions.scroll_view(10),
  ["<C-u>"] = actions.scroll_view(-10),
  ["gf"] = actions.goto_file_tab,
  ["<C-j>"] = actions.next_conflict,
  ["<C-k>"] = actions.prev_conflict,
  ["<leader>U"] = actions.unstage_all,
  ["<leader>S"] = actions.stage_all,
  ["<leader>s"] = actions.toggle_stage_entry,
  ["<leader>x"] = function()
    if vim.fn.confirm("", "Are you sure you'd like to discard changes? (&Yes\n&No)", 1) == 1 then
      actions.restore_entry()
    end
  end,
}

require("diffview").setup({
  view = {
    merge_tool = {
      layout = "diff3_mixed",
    },
  },
  file_panel = {
    listing_style = "list",
  },
  keymaps = {
    view = shared_maps,
    file_panel = shared_maps,
    file_history_panel = shared_maps,
  },
})
