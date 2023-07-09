local build = {
  name = "build:go",
  builder = function()
    return {
      cmd = { "go" },
      args = { "build" },
      name = "| go build",
      components = { { "on_result_diagnostics_quickfix", open = true }, "default", },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}

return build
