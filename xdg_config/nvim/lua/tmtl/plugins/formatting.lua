local M = {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd", "rustywind" },
      javascriptreact = { "prettierd", "rustywind" },
      typescript = { "prettierd", "rustywind" },
      typescriptreact = { "prettierd", "rustywind" },

      lua = { "stylua" },
      rust = { "rustfmt" },
      go = { "goimports", "gofmt" },
      html = { "djlint", "rustywind" },
      yaml = { "yamlfix" },
      sql = { "pg_format" },
    },

    format_after_save = function()
      -- TODO: fix? not working on first load, have to turn off and on
      if vim.g.disable_autoformat then
        return
      end
      return { lsp_format = "fallback" }
    end,
  },
  keys = {
    {
      "<leader>lf",
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
      end,
      desc = "[L]SP [F]ormat on save - toggle",
    },
  },
}

return M
