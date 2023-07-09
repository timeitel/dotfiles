local run = {
  name = "run:go",
  builder = function()
    return {
      cmd = { "go", "run", "." },
      name = "| go run .",
      components = { { "on_output_quickfix", open = true }, "default", },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}

return run
