local M = {
  "mikesmithgh/git-prompt-string-lualine.nvim",
  {
    "sindrets/diffview.nvim",
    keys = {
      {
        "<leader><leader>gd",
        "<CMD>DiffviewOpen HEAD..origin/main<CR>",
        desc = "[G]it [D]iff - HEAD against origin/main",
      },
    },
    config = function()
      local actions = require("diffview.actions")
      local request_confirm = require("tmtl.utils").request_confirm
      local function request_restore_entry()
        request_confirm({
          prompt = "discard changes",
          on_confirm = function()
            actions.restore_entry()
            vim.cmd([[checktime]])
          end,
        })
      end
      local spread_table = require("tmtl.utils").spread_table

      local common_maps = {
        ["L"] = false,
        ["l"] = false,
        ["h"] = false,
        ["q"] = function()
          vim.cmd("DiffviewClose")
        end,
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
        ["gf"] = actions.goto_file_edit,
        ["M"] = actions.focus_entry,
        ["m"] = actions.select_entry,
        ["<C-x>"] = request_restore_entry,
        ["C"] = function()
          require("neogit").open({ "commit" })
        end,
      }

      local file_panel_maps = spread_table({}, common_maps, panel_maps)
      file_panel_maps["s"] = actions.toggle_stage_entry

      local merge_tool_maps = spread_table({}, common_maps, panel_maps)
      merge_tool_maps["<C-j>"] = actions.next_conflict
      merge_tool_maps["<C-k>"] = actions.prev_conflict

      require("diffview").setup({
        view = {
          merge_tool = {
            layout = "diff3_mixed",
          },
        },
        file_panel = {
          listing_style = "tree",
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
    },
  },
  {
    "NeogitOrg/neogit",
    config = function()
      require("neogit").setup({
        console_timeout = 5000,
        commit_editor = {
          kind = "split",
          show_staged_diff = false,
        },
        disable_hint = true,
        graph_style = "kitty",
        integrations = {
          diffview = true,
        },
        sections = {
          recent = {
            folded = false,
            hidden = false,
          },
        },
      })
    end,
    keys = {
      { "<leader>gs", "<CMD>Neogit<CR>", desc = "[G]it [S]tatus" },
    },
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim" },
  },
}

return M
