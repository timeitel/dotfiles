local run = {
  name = "run:rust",
  builder = function()
    return {
      cmd = { "cargo", "run" },
      name = "| cargo run",
      metadata = {
        on_failure = function(task)
          vim.cmd([[vs]])
          require('overseer').run_action(task, 'open')
        end,
        on_success = function()
          require('overseer').open()
        end
      },
    }
  end,
  condition = {
    filetype = { "rust" },
  },
}

return run
