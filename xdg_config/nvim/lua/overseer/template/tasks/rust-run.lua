local run = {
  name = "run:rust",
  builder = function()
    return {
      cmd = { "cargo" },
      args = { "run" },
      name = "| cargo run",
    }
  end,
  condition = {
    filetype = { "rust" },
  },
}

return run
