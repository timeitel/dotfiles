local build = {
  name = "build:rust",
  builder = function()
    return {
      cmd = { "cargo" },
      args = { "build" },
      name = "| cargo build",
    }
  end,
  condition = {
    filetype = { "rust" },
  },
}

return build
