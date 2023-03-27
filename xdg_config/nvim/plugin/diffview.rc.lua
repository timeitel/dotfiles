local ok, actions = pcall(require, "diffview.actions")
if not ok then
  return
end

local shared_maps = {
  ["L"] = false,
  ["q"] = "<cmd>DiffviewClose<cr>",
  ["s"] = function()
    vim.cmd([[DiffviewClose]])
    require("neogit").open()
  end,
  ["f"] = "<cmd>DiffviewToggleFiles<cr>",
  ["<leader>f"] = "<cmd>DiffviewFocusFiles<cr>",
  ["O"] = actions.focus_entry,
  ["<C-e>"] = actions.scroll_view(1),
  ["<C-y>"] = actions.scroll_view(-1),
  ["<C-d>"] = actions.scroll_view(10),
  ["<C-u>"] = actions.scroll_view(-10),
  ["gf"] = actions.goto_file_edit,
  ["x"] = function()
    if vim.fn.confirm("", "Are you sure you'd like to discard changes? (&Yes\n&No)", 1) == 1 then
      actions.restore_entry()
      vim.cmd([[checktime]])
    end
  end,
  ["<leader>sr"] = actions.unstage_all, -- stage reset
  ["<leader>sf"] = actions.toggle_stage_entry,
  ["<leader>sa"] = actions.stage_all,
  -- Commit staged files
  ["<leader>cs"] = function()
    actions.focus_files()
    Open_Git_Commit()
  end,
}

-- Not using shallow copy util as mappings seem to leak into other diffview contexts
local merge_tool_maps = {
  ["L"] = false,
  ["q"] = "<cmd>DiffviewClose<cr>",
  ["s"] = function()
    vim.cmd([[DiffviewClose]])
    require("neogit").open()
  end,
  ["f"] = "<cmd>DiffviewToggleFiles<cr>",
  ["<leader>f"] = "<cmd>DiffviewFocusFiles<cr>",
  ["O"] = actions.focus_entry,
  ["<C-e>"] = actions.scroll_view(1),
  ["<C-y>"] = actions.scroll_view(-1),
  ["<C-d>"] = actions.scroll_view(10),
  ["<C-u>"] = actions.scroll_view(-10),
  ["gf"] = actions.goto_file_edit,
  ["x"] = function()
    if vim.fn.confirm("", "Are you sure you'd like to discard changes? (&Yes\n&No)", 1) == 1 then
      actions.restore_entry()
      vim.cmd([[checktime]])
    end
  end,
  ["<leader>sr"] = actions.unstage_all, -- stage reset
  ["<leader>sf"] = actions.toggle_stage_entry,
  ["<leader>sa"] = actions.stage_all,
  -- Commit staged files
  ["<leader>cs"] = function()
    actions.focus_files()
    Open_Git_Commit()
  end,
}
merge_tool_maps["<C-j>"] = actions.next_conflict
merge_tool_maps["<C-k>"] = actions.prev_conflict

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
    file_history_panel = shared_maps,
    file_panel = shared_maps,
    diff_view = shared_maps,
    merge_tool = merge_tool_maps,
  },
})

-- vim.api.nvim_set_hl(0, "DiffviewStatusAdded", { guibg = "#282c34" })
-- vim.api.nvim_set_hl(0, "DiffviewStatusDeleted", { guibg = "#282c34" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#323a5a" })
-- TODO: unable to jump to next diff when file is staged
