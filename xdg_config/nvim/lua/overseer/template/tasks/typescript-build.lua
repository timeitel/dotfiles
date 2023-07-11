local build = {
  name = "build:ts",
  builder = function()
    local path = vim.fs.find("tsconfig.json", { upward = true, type = "file", path = vim.fn.expand("%:h") })[1]
    local dir = vim.fs.dirname(path)

    local components
    -- TODO: passing cwd not working for qf items when in subproject
    if dir == "." then
      components = {
        { "on_output_parse", problem_matcher = "$tsc" },
        { "on_result_diagnostics_quickfix", open = true },
        "default"
      }
    else
      components = {
        { "on_output_parse", problem_matcher = "$tsc" },
        { "on_output_quickfix", open = true },
        "default"
      }
    end

    return {
      cmd = { "tsc" },
      name = "| tsc",
      cwd = dir,
      components = components
    }
  end,
  condition = {
    filetype = { "typescript", "typescriptreact", "json" },
  },
}

return build
