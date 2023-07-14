local run = {
  name = "run:go",
  builder = function()
    return {
      cmd = { "go", "run", "." },
      name = "| go run .",
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
    filetype = { "go" },
  },
}

return run
