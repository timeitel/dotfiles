local M = {
  "nvim-telescope/telescope-file-browser.nvim",
  "nvim-telescope/telescope-ui-select.nvim",
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      config = function()
        -- TODO: C-O and C-I to go forward and back in file browser
        local telescope = require("telescope")
        local action_state = require("telescope.actions.state")
        local actions = require("telescope.actions")
        local actions_layout = require("telescope.actions.layout")
        local notify = require("notify")
        local fb_actions = telescope.extensions.file_browser.actions
        local copy = require("tmtl.utils").shallow_copy

        -- Telescope defaults
        local default_insert_mappings = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.close,
          ["<C-l>"] = actions.select_default + actions.center,
          ["<C-h>"] = function()
            vim.api.nvim_input("<BS>")
          end,
          ["<C-w>"] = function()
            vim.api.nvim_input("<c-s-w>")
          end,
          ["<C-u>"] = function()
            vim.api.nvim_input("<Esc>cc")
          end,
          ["<C-s>"] = actions.select_horizontal,
          ["<M-p>"] = actions_layout.toggle_preview,
        }

        local default_normal_mappings = copy(default_insert_mappings)
        default_normal_mappings["<leader>qf"] = function(bfnr)
          actions.send_to_qflist(bfnr)
          vim.cmd([[copen]])
        end
        default_normal_mappings["c"] = false
        default_normal_mappings["q"] = actions.close
        default_normal_mappings["<C-u>"] = actions.preview_scrolling_up
        default_normal_mappings["o"] = actions.select_default + actions.center
        default_normal_mappings["l"] = actions.select_default

        -- Telescope File-browser
        local file_browser_normal_mappings = {
          ["."] = fb_actions.toggle_hidden,
          ["n"] = fb_actions.create,
          ["t"] = fb_actions.change_cwd,
          ["f"] = function()
            local entry = action_state.get_selected_entry()
            local filename = entry.Path.filename
            require("telescope.builtin").live_grep({ search_dirs = { filename }, results_title = filename,
              initial_mode = "insert" })
          end,
          ["x"] = fb_actions.remove,
          ["h"] = fb_actions.goto_parent_dir,
          ["H"] = fb_actions.goto_cwd,
          ["o"] = fb_actions.open
        }

        telescope.setup({
          defaults = {
            initial_mode = "normal",
            file_ignore_patterns = { ".DS_Store", ".git" },
            multi_icon = "<>",
            sorting_strategy = "ascending",
            path_display = function(_, path)
              local tail = require("telescope.utils").path_tail(path)
              return string.format("%s (%s)", tail, path)
            end,
            layout_config = {
              width = 0.95,
              height = 0.85,
              prompt_position = "top",
              vertical = {
                width = 0.9,
                height = 0.95,
                preview_height = 0.5,
              },
              flex = {
                horizontal = {
                  preview_width = 0.9,
                },
              },
            },

            mappings = {
              i = default_insert_mappings,
              n = default_normal_mappings,
            },
          },

          pickers = {
            buffers = {
              mappings = {
                n = {
                  ["x"] = actions.delete_buffer,
                },
              },
            },
            git_stash = {
              mappings = {
                -- TODO: finish
                n = {
                  ["x"] = function()
                    local request_confirm = require("tmtl.utils").request_confirm
                    request_confirm({ prompt = "delete stashk", on_confirm = function()
                      local pos = vim.api.nvim_win_get_cursor(0)
                      local stash_num = pos[1] - 1
                      local cmd = "'cmd=\"git stash drop " .. stash_num .. "\" " .. "open=0'"
                      vim.fn.feedkeys('q')
                      vim.schedule(function()
                        require('toggleterm').exec_command(cmd)
                        notify("Deleted stash")
                        telescope.resume()
                      end
                      )
                    end })
                  end,
                },
              },
            },
            git_branches = {
              previewer = false,
              mappings = {
                n = {
                  ["x"] = function(prompt_bufnr)
                    actions.git_delete_branch(prompt_bufnr)
                    require("telescope.builtin").git_branches()
                  end,
                },
              },
            },
            find_files = { initial_mode = "insert" },
            registers = {
              mappings = {
                n = {
                  ["<leader>e"] = actions.edit_register,
                },
              },
            },
          },

          extensions = {
            file_browser = {
              display_stat = { date = true, size = true, },
              path_display = { truncate = 2 },
              mappings     = {
                n = file_browser_normal_mappings,
              },
            },
            ["ui-select"] = {
              require("telescope.themes").get_cursor({}),
            },
          },
        })

        require("telescope").load_extension("file_browser")
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("possession")
        require("telescope").load_extension("notify")
      end,
    },
  },
}

return M
