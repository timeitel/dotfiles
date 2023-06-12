local M = {
  "bobrown101/git-blame.nvim",
  { 'ThePrimeagen/git-worktree.nvim', config = function()
    local worktree = require("git-worktree")

    worktree.on_tree_change(function(op, metadata)
      if op == worktree.Operations.Switch then
        print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)

        -- local term = require("toggleterm.terminal").Terminal:new {
        --   dir = vim.fn.expand('%:p:h'),
        --   cmd = "pwd",
        --   direction = "float",
        --   count = 1
        -- }
      end
    end)
  end },
  {
    "sindrets/diffview.nvim",
    commit = "6bebefbc4c90e6d2b8c65e65b055d284475d89f8",
    config = function()
      local actions = require("diffview.actions")
      local request_confirm = require("tmtl.utils").request_confirm

      local file_panel_maps = {
        ["L"] = false,
        ["q"] = "<cmd>DiffviewClose<cr>",
        ["s"] = function()
          vim.cmd([[DiffviewClose]])
          require("neogit").open()
        end,
        ["<leader>f"] = "<cmd>DiffviewFocusFiles<cr>",
        ["<C-f>"] = "<cmd>DiffviewToggleFiles<cr>",
        ["<C-l>"] = actions.listing_style,
        ["o"] = actions.focus_entry,
        ["<C-e>"] = actions.scroll_view(1),
        ["<C-y>"] = actions.scroll_view(-1),
        ["<C-d>"] = actions.scroll_view(10),
        ["<C-u>"] = actions.scroll_view(-10),
        ["gf"] = actions.goto_file_edit,
        ["x"] = function()
          request_confirm({ prompt = "discard changes", on_confirm = function()
            actions.restore_entry()
            vim.cmd([[checktime]])
          end })
        end,
        ["<leader>sr"] = actions.unstage_all, -- stage reset
        ["<leader>sf"] = actions.toggle_stage_entry,
        ["<leader>sa"] = actions.stage_all,
        ["<leader>cs"] = function()
          actions.focus_files()
          Open_Git_Commit()
        end,
        ["<C-Space>"] = actions.listing_style,
      }

      local shared_maps = {
        ["L"] = false,
        ["q"] = "<cmd>DiffviewClose<cr>",
        ["s"] = function()
          vim.cmd([[DiffviewClose]])
          require("neogit").open()
        end,
        ["<leader>f"] = "<cmd>DiffviewFocusFiles<cr>",
        ["<C-f>"] = "<cmd>DiffviewToggleFiles<cr>",
        ["<C-l>"] = actions.listing_style,
        ["o"] = actions.focus_entry,
        ["<C-e>"] = actions.scroll_view(1),
        ["<C-y>"] = actions.scroll_view(-1),
        ["<C-d>"] = actions.scroll_view(10),
        ["<C-u>"] = actions.scroll_view(-10),
        ["gf"] = actions.goto_file_edit,
        ["<leader>sr"] = actions.unstage_all, -- stage reset
        ["<leader>sf"] = actions.toggle_stage_entry,
        ["<leader>sa"] = actions.stage_all,
        ["<leader>cs"] = function()
          actions.focus_files()
          Open_Git_Commit()
        end,
      }

      -- Not using shallow copy util as mappings seem to leak into other diffview contexts
      local merge_tool_maps = {
        ["L"] = false,
        ["q"] = "<cmd>DiffviewClose<cr>",
        ["s"] = function()
          vim.cmd([[DiffviewClose]])
          require("neogit").open()
        end,
        ["f"] = "<cmd>DiffviewToggleFiles<cr>",
        ["<leader>f"] = "<cmd>DiffviewFocusFiles<cr>",
        ["o"] = actions.focus_entry,
        ["<C-e>"] = actions.scroll_view(1),
        ["<C-y>"] = actions.scroll_view(-1),
        ["<C-d>"] = actions.scroll_view(10),
        ["<C-u>"] = actions.scroll_view(-10),
        ["gf"] = actions.goto_file_edit,
        ["x"] = function()
          request_confirm({ prompt = "discard changes", on_confirm = function()
            actions.restore_entry()
            vim.cmd([[checktime]])
          end })
        end,
        ["<leader>sr"] = actions.unstage_all, -- stage reset
        ["<leader>sf"] = actions.toggle_stage_entry,
        ["<leader>sa"] = actions.stage_all,
        ["<leader>cs"] = function()
          actions.focus_files()
          Open_Git_Commit()
        end,
      }
      merge_tool_maps["<C-j>"] = actions.next_conflict
      merge_tool_maps["<C-k>"] = actions.prev_conflict

      require("diffview").setup({
        view = {
          merge_tool = {
            layout = "diff3_mixed",
          },
        },
        file_panel = {
          listing_style = "list",
        },
        keymaps = {
          view = shared_maps,
          file_history_panel = shared_maps,
          file_panel = file_panel_maps,
          diff_view = shared_maps,
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
            ["d"] = function() -- open diff anywhere in status window and in an actual diffview tab, not a neogit wrapper
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
