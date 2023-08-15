local test = {
  name = "test:rust",
  builder = function()
    return {
      cmd = { "cargo", "test" },
      name = "| cargo test",
      metadata = {
        on_failure = function(task)
          vim.cmd([[wincmd o]])
          vim.cmd([[vs]])
          require("overseer").run_action(task, "open")
        end,
      },
    }
  end,
  condition = {
    filetype = { "rust" },
  },
}

return test
