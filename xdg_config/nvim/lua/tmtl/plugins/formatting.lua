local M = {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd", "rustywind" },
      javascriptreact = { "prettierd", "rustywind" },
      typescript = { "prettierd", "rustywind" },
      typescriptreact = { "prettierd", "rustywind" },
      json = { "prettierd" },

      lua = { "stylua" },
      rust = { "rustfmt" },
      go = { "goimports", "gofmt" },
      html = { "djlint", "rustywind" },
      yaml = { "yamlfmt" },
      sql = { "pg_format" },
    },

    format_after_save = function()
      if vim.b.disable_autoformat then
        return
      end
      return { lsp_format = "fallback" }
    end,
  },
  lazy = false,
  keys = {
    {
      "<leader>lf",
      function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
      end,
      desc = "[L]SP [F]ormat on save - toggle",
    },
  },
}

return M
