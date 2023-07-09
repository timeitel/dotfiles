local test = {
  name = "test:rust",
  builder = function()
    return {
      cmd = { "cargo", "test" },
      name = "| cargo test",
      components = { { "on_output_quickfix", open = true }, "default", },
    }
  end,
  condition = {
    filetype = { "rust" },
  },
}

return test
