local test = {
  name = "test:go",
  builder = function()
    return {
      cmd = { "go", "test" },
      name = "| go test",
      components = { { "on_output_quickfix", open = true }, "default", },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}

return test
