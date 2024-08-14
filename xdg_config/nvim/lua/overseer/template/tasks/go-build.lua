local build = {
  name = "build:go",
  builder = function()
    return {
      cmd = { "go", "build", "-o", "./cmd/web/main", "./cmd/web" },
      name = "| go build",
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

return build
