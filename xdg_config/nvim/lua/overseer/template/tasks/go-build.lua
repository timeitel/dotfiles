local build = {
  name = "build:go",
  builder = function()
    return {
      cmd = { "go", "build" },
      name = "| go build",
      components = { { "on_output_quickfix", open = true }, "default", },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}

return build
