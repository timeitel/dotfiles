local build = {
  name = "build:ts",
  builder = function()
    local spread_table = require("tmtl.utils").spread_table
    local path = vim.fs.find("tsconfig.json", { upward = true, type = "file", path = vim.fn.expand("%:h") })[1]
    local dir = vim.fs.dirname(path)

    local components = { "default", { "on_output_parse", problem_matcher = "$tsc" } }
    -- TODO: passing cwd not working for qf items when in subproject
    if dir == "." then
      spread_table(components, { { "on_result_diagnostics_quickfix", open = true } })
    else
      spread_table(components, { { "on_output_quickfix", open = true } })
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
