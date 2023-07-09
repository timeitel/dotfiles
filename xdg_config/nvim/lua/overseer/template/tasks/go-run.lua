local run = {
  name = "run:go",
  builder = function()
    return {
      cmd = { "go" },
      args = { "run", "." },
      name = "| go run .",
      components = { { "on_result_diagnostics_quickfix", open = true }, "default", },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}

return run
