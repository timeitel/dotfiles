local M = {
  {
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup()
    end
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      local worktree = require("git-worktree")

      worktree.on_tree_change(function(op, metadata)
        if op == worktree.Operations.Switch then
          print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
        end
      end)
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      local neogit = require("neogit")
      local actions = require("diffview.actions")
      local spread_table = require("tmtl.utils").spread_table
      local request_confirm = require("tmtl.utils").request_confirm
      local map = require("tmtl.utils").map

      local common_maps = {
        ["L"] = false,
        ["q"] = function()
          vim.cmd("DiffviewClose")

          vim.keymap.set("n", "<Tab>",
            function() Goto_Diagnostic({ float = true, severity = { min = vim.diagnostic.severity.HINT } }) end,
            { noremap = true, silent = true, buffer = 0 })

          vim.keymap.set("n", "<S-Tab>",
            function() Goto_Diagnostic({ prev = true, float = true, severity = { min = vim.diagnostic.severity.HINT } }) end
            , { noremap = true, silent = true, buffer = 0, })
        end,
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
          vim.cmd([[Neogit commit]])
          vim.fn.feedkeys("c")
        end,
        ["<leader>gs"] = function()
          vim.cmd([[DiffviewClose]])
          neogit.open({})
        end,
      }

      local panel_maps = {
        ["o"] = actions.focus_entry,
        ["<C-x>"] = function()
          request_confirm({
            prompt = "discard changes",
            on_confirm = function()
              actions.restore_entry()
              vim.cmd([[checktime]])
            end,
          })
        end,
        ["C"] = function()
          vim.cmd([[Neogit commit]])
          vim.fn.feedkeys("c")
        end,
      }

      local file_panel_maps = spread_table({}, common_maps, panel_maps)
      file_panel_maps["s"] = actions.toggle_stage_entry
      file_panel_maps["<C-f>"] = actions.toggle_files

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
        hooks = {
          view_closed = function()
            local function reassign_tab()
              map("n", "<Tab>", function()
                Goto_Diagnostic({ float = true, severity = { min = vim.diagnostic.severity.HINT } })
              end, "[D]iagnostics next diagnostic")

              map("n", "<S-Tab>", function()
                Goto_Diagnostic({ prev = true, float = true, severity = { min = vim.diagnostic.severity.HINT } })
              end, "[D]iagnostics previous diagnostic")
            end

            pcall(reassign_tab)
          end
        }
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
  },
  {
    "NeogitOrg/neogit",
    opts = {
      disable_hint = true,
      disable_commit_confirmation = true,
      disable_insert_on_commit = "auto",
      integrations = {
        diffview = true,
      },
      mappings = {
        status = {
          ["b"] = false,
          ["v"] = false,
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
    },
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
  },
}

return M
