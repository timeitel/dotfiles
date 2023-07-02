local M = {
  'stevearc/overseer.nvim',
  opts = {},
  config = function()
    require("overseer").setup({
      task_list = {
        bindings = {
          q = "<CMD>close<CR>",
        },
      },
    })
  end
}

return M
