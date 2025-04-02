local M = {
  "mikesmithgh/git-prompt-string-lualine.nvim",
  {
    "isakbm/gitgraph.nvim",
    opts = {
      symbols = {
        merge_commit = "M",
        commit = "*",
      },
      format = {
        timestamp = "%H:%M:%S %d-%m-%Y",
        fields = { "hash", "timestamp", "author", "branch_name", "tag" },
      },
      hooks = {
        on_select_commit = function(commit)
          print("selected commit:", commit.hash)
        end,
        on_select_range_commit = function(from, to)
          print("selected range:", from.hash, to.hash)
        end,
      },
    },
    keys = {
      {
        "<leader>gl",
        function()
          require("gitgraph").draw({}, { all = true, max_count = 5000 })
        end,
        desc = "[G]it [L]og graph",
      },
    },
  },
  {
    "tpope/vim-fugitive",
    config = function()
      local map = vim.keymap.set

      map("n", "<leader>cs", "<CMD>Git commit --quiet<bar> wincmd J<CR>", { desc = "[C]ommit [S]taged" })
      map("n", "<leader>ca", "<CMD>Git commit --amend<bar> wincmd J<CR>", { desc = "[C]ommit [A]mend" })
      map("n", "<leader>gs", "<CMD>G<CR>", { desc = "[G]it [S]tatus" })
      map("n", "<leader>gp", "<CMD>Git push<CR>", { desc = "[G]it [P]ush" })
    end,
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<CMD>DiffviewOpen<CR>", desc = "[G]it [D]iff" },
      {
        "<leader><leader>gd",
        ":DiffviewOpen HEAD..origin/main",
        desc = "[G]it [D]iff - HEAD against origin/main",
      },
      { "<leader>gh", "<CMD>DiffviewFileHistory<CR>", desc = "[G]it [H]istory" },
      { "<leader>gfh", "<CMD>DiffviewFileHistory %<CR>", desc = "[G]it [F]ile [H]istory" },
      { "<leader><leader>gs", "<CMD>DiffviewFileHistory -g --range=stash<CR>", desc = "[G]it [S]tashes" },
    },
    config = function()
      local actions = require("diffview.actions")
      local spread_table = require("tmtl.utils").spread_table

      local common_maps = {
        ["L"] = false,
        ["l"] = false,
        ["h"] = false,
        ["q"] = "<CMD>DiffviewClose<CR>",
        ["<C-c>"] = "<CMD>DiffviewClose<CR>",
        ["[f"] = actions.focus_files,
        ["gf"] = actions.goto_file_edit,
        ["gl"] = actions.listing_style,
        ["<C-f>"] = actions.toggle_files,
        ["<C-e>"] = actions.scroll_view(1),
        ["<C-y>"] = actions.scroll_view(-1),
        ["<C-d>"] = actions.scroll_view(10),
        ["<C-u>"] = actions.scroll_view(-10),
      }

      local panel_maps = {
        ["<C-f>"] = actions.toggle_files,
        ["<C-x>"] = actions.restore_entry,
        ["gf"] = actions.goto_file_edit,
        ["M"] = actions.focus_entry,
        ["m"] = actions.select_entry,
        ["C"] = "<CMD>Git commit --quiet<bar> wincmd J<CR>",
      }

      local file_panel_maps = spread_table({}, common_maps, panel_maps)
      file_panel_maps["s"] = actions.toggle_stage_entry

      local merge_tool_maps = spread_table({}, common_maps, panel_maps)
      merge_tool_maps["]c"] = actions.next_conflict
      merge_tool_maps["[c"] = actions.prev_conflict

      require("diffview").setup({
        view = {
          merge_tool = {
            layout = "diff3_mixed",
          },
        },
        file_panel = {
          listing_style = "tree",
        },
        show_help_hints = false,
        default_args = {
          DiffviewOpen = { "--imply-local" },
        },
        keymaps = {
          view = common_maps,
          file_history_panel = file_panel_maps,
          file_panel = file_panel_maps,
          diff_view = common_maps,
          merge_tool = merge_tool_maps,
        },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
    lazy = false,
    keys = {
      { "<leader><leader>gb", "<CMD>Gitsigns blame<CR>", desc = "[G]it [B]lame" },
      {
        "<leader>gfx",
        function()
          vim.cmd([[Gitsigns reset_buffer]])
          require("notify")("Discarded changes of current file", vim.log.levels.WARN)
        end,
        desc = "[G]it [F]ile - discard changes",
      },
      { "<C-]>", "<CMD>Gitsigns next_hunk<CR>", desc = "Next git hunk" },
      { "<C-[>", "<CMD>Gitsigns prev_hunk<CR>", desc = "Previous git hunk" },
      { "<leader>hp", "<CMD>Gitsigns preview_hunk<CR>", desc = "Git [H]unk [P]review" },
      { "<leader>hs", "<CMD>Gitsigns stage_hunk<CR>", desc = "Git [H]unk [S]tage", mode = { "n", "v" } },
      {
        "<leader>hx",
        function()
          vim.cmd([[Gitsigns reset_hunk]])
          require("notify")("Discarded hunk", vim.log.levels.WARN)
        end,
        desc = "Git [H]unk - discard",
      },
    },
  },
}

return M
