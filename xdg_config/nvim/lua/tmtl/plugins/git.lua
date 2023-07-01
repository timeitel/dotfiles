local M = {
  "bobrown101/git-blame.nvim",
  { 'ThePrimeagen/git-worktree.nvim', config = function()
    local worktree = require("git-worktree")

    worktree.on_tree_change(function(op, metadata)
      if op == worktree.Operations.Switch then
        print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
      end
    end)
  end },
  {
    "sindrets/diffview.nvim",
    config = function()
      local neogit = require("neogit")
      local actions = require("diffview.actions")
      local spread_table = require("tmtl.utils").spread_table
      local request_confirm = require("tmtl.utils").request_confirm

      local common_maps = {
        ["L"] = false,
        ["q"] = "<cmd>DiffviewClose<cr>",
        ["[f"] = actions.focus_files,
        ["]f"] = actions.focus_files,
        ["gf"] = actions.goto_file_edit,
        ["<C-f>"] = actions.toggle_files,
        ["<C-l>"] = actions.listing_style,
        ["<C-e>"] = actions.scroll_view(1),
        ["<C-y>"] = actions.scroll_view(-1),
        ["<C-d>"] = actions.scroll_view(10),
        ["<C-u>"] = actions.scroll_view(-10),
        ["<leader>sf"] = actions.toggle_stage_entry,
        ["<leader>cs"] = function()
          actions.focus_files()
          Open_Git_Commit()
        end,
        ["<leader>gs"] = function()
          vim.cmd([[DiffviewClose]])
          neogit.open()
        end,
      }

      local panel_maps = {
        ["o"] = actions.focus_entry,
        ["x"] = function()
          request_confirm({ prompt = "discard changes", on_confirm = function()
            actions.restore_entry()
            vim.cmd([[checktime]])
          end })
        end,
        ["C"] = function()
          vim.cmd([[DiffviewClose]])
          neogit.open()
          neogit.open({ "commit" })
          vim.fn.feedkeys("c")
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
    config = function()
      require("gitsigns").setup({
        preview_config = {
          border = "rounded",
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
      })
    end,
  },
  {
    "TimUntersberger/neogit",
    config = function()
      require("neogit").setup({
        disable_commit_confirmation = true,
        disable_insert_on_commit = false,
        integrations = {
          diffview = true,
        },
        mappings = {
          status = {
            ["b"] = false,
            ["d"] = function()
              vim.cmd([[ DiffviewOpen ]])
            end,
          },
        },
        sections = {
          stashes = false,
          unpulled = {
            folded = true,
          },
          unmerged = {
            folded = false,
          },
          recent = {
            folded = false,
          },
        },
      })
    end,
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
  },
}

return M
