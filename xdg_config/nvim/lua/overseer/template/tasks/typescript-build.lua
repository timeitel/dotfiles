local build = {
  name = "build:ts",
  builder = function()
    local path = vim.fs.find("tsconfig.json", { upward = true, type = "file", path = vim.fn.expand("%:h") })[1]
    local dir = vim.fs.dirname(path)

    local components
    if dir == "." then
      components = {
        { "on_output_parse", problem_matcher = "$tsc" },
        { "on_result_diagnostics_quickfix", open = true },
        "default",
      }
    else
      components = {
        {
          "on_output_parse",
          problem_matcher = {
            owner = "typescript",
            fileLocation = { "relative", "${cwd}" .. "/" .. dir },
            pattern = {
              regexp = "^([^\\s].*)[\\(:](\\d+)[,:](\\d+)(?:\\):\\s+|\\s+-\\s+)(error|warning|info)\\s+TS(\\d+)\\s*:\\s*(.*)$",
              vim_regexp = "\\v^([^[:space:]].*)[\\(:](\\d+)[,:](\\d+)(\\):\\s+|\\s+-\\s+)(error|warning|info)\\s+TS(\\d+)\\s*:\\s*(.*)$",
              lua_pat = "^([^%s].*)[\\(:](%d+)[,:](%d+)[^%a]*(%a+)%s+TS(%d+)%s*:%s*(.*)$",
              file = 1,
              line = 2,
              column = 3,
              severity = 5,
              code = 6,
              message = 7,
            },
          },
        },
        { "on_result_diagnostics_quickfix", open = true },
        "default",
      }
    end

    return {
      cmd = { "tsc" },
      name = "| tsc",
      cwd = dir,
      components = components,
    }
  end,
  condition = {
    filetype = { "typescript", "typescriptreact", "json" },
  },
}

return build
