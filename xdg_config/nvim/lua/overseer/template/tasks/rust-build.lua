local build = {
  name = "build:rust",
  builder = function()
    return {
      cmd = { "cargo", "build" },
      name = "| cargo build",
      metadata = {
        on_failure = function(task)
          vim.cmd([[wincmd o]])
          vim.cmd([[vs]])
          require('overseer').run_action(task, 'open')
        end,
      },
    }
  end,
  condition = {
    filetype = { "rust" },
  },
}

return build
