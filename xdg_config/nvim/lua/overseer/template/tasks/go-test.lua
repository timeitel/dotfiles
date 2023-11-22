local test = {
  name = "test:go",
  builder = function()
    return {
      cmd = { "go", "test" },
      name = "| go test",
      metadata = {
        on_failure = function(task)
          vim.cmd.wincmd("o")
          vim.cmd("vs")
          require("overseer").run_action(task, "open")
        end,
      },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}

return test
