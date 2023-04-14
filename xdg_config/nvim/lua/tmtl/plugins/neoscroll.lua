local M = {
  "karb94/neoscroll.nvim",
  -- keys = {
  --   {
  --     "<C-u>",
  --     { "scroll", { "-vim.wo.scroll", "true", "30" } },
  --   },
  --   {
  --     "<C-d>",
  --     { "scroll", { "vim.wo.scroll", "true", "30" } },
  --   },
  -- },
  config = function()
    local mappings = {}
    mappings["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "30" } }
    mappings["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "30" } }
    require("neoscroll.config").set_mappings(mappings)

    return {
      mappings = { "<C-u>", "<C-d>" },
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true, -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    }
  end,
}

-- local mappings = {}
-- mappings["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "30" } }
-- mappings["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "30" } }
-- require("neoscroll.config").set_mappings(mappings)

return M
