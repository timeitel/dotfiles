local test = {
  name = "test:go",
  builder = function()
    return {
      cmd = { "go" },
      args = { "test" },
      name = "| go test",
      components = { { "on_result_diagnostics_quickfix", open = true }, "default", },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}

return test
