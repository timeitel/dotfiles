local build = {
  name = "build:ts",
  builder = function()
    return {
      cmd = { "tsc" },
      name = "| tsc",
      components = {
        { "on_output_parse", problem_matcher = "$tsc" },
        "on_result_diagnostics",
        { "on_result_diagnostics_quickfix", open = true },
      }
    }
  end,
  condition = {
    filetype = { "typescript", "typescriptreact" },
  },
}

return build
