local test = {
  name = "test:rust",
  builder = function()
    return {
      cmd = { "cargo" },
      args = { "test" },
      name = "| cargo test",
      components = { { "on_result_diagnostics_quickfix", open = true }, "default", },
    }
  end,
  condition = {
    filetype = { "rust" },
  },
}

return test
