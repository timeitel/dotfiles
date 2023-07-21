-- TODO: file_browser copy name of file, <leader>yf
local M = {
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.1",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      -- TODO: current selection when browsing current folder or creating filetelesc
      local telescope = require("telescope")
      local action_state = require("telescope.actions.state")
      local actions = require("telescope.actions")
      local actions_layout = require("telescope.actions.layout")
      local fb_actions = telescope.extensions.file_browser.actions
      local copy = require("tmtl.utils").shallow_copy

      local insert_mappings = {
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

      local normal_mappings = copy(insert_mappings)
      normal_mappings["<leader>qf"] = function(bfnr)
        actions.smart_send_to_qflist(bfnr)
        vim.cmd([[copen]])
      end
      normal_mappings["c"] = false
      normal_mappings["q"] = actions.close
      normal_mappings["<C-u>"] = actions.preview_scrolling_up
      normal_mappings["o"] = actions.select_default + actions.center
      normal_mappings["l"] = function(bufnr)
        local picker = action_state.get_current_picker(bufnr)
        local prompt_text = picker.sorter["_discard_state"].prompt
        if prompt_text == '' then
          actions.select_default(bufnr)
          actions.center()
        else
          vim.fn.feedkeys(vim.api.nvim_eval('"\\<Right>"'))
        end
      end
      normal_mappings["<leader>gd"] = function(bfnr)
        actions.close(bfnr)
        vim.cmd([[DiffviewOpen]])
      end
      normal_mappings["<leader>gh"] = function(bfnr)
        actions.close(bfnr)
        vim.cmd([[DiffviewFileHistory]])
      end

      local file_browser_normal_mappings = {
        ["n"] = fb_actions.create,
        ["cd"] = fb_actions.change_cwd,
        ["gf"] = function()
          local entry = action_state.get_selected_entry()
          local filename = entry.Path.filename
          require("telescope.builtin").live_grep({ search_dirs = { filename }, results_title = filename,
            initial_mode = "insert" })
        end,
        ["gp"] = function()
          local entry = action_state.get_selected_entry()
          local filename = entry.Path.filename
          require("telescope.builtin").find_files({ search_dirs = { filename }, results_title = filename,
            initial_mode = "insert" })
        end,
        ["h"] = fb_actions.goto_parent_dir,
        ["H"] = fb_actions.goto_cwd,
        ["o"] = fb_actions.open,
        ["<C-x>"] = fb_actions.remove,
        ["<C-o>"] = function()
          vim.fn.feedkeys(vim.api.nvim_eval('"\\<Esc>"'))
          vim.fn.feedkeys(vim.api.nvim_eval('"\\<C-o>"'))
        end,
      }

      telescope.setup({
        defaults = {
          initial_mode = "normal",
          file_ignore_patterns = { "%.DS_Store", "%.git/", "node_modules/" },
          multi_icon = "<>",
          sorting_strategy = "ascending",
          path_display = function(_, path)
            local tail = require("telescope.utils").path_tail(path)
            local path_from_project_root = string.gsub(path, vim.fn.getcwd() .. "/", "")
            -- TODO: add highlight groups to tail / path
            return string.format("%s  (%s)", tail, path_from_project_root), { { { 1, #tail }, "Constant" } }
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
            i = insert_mappings,
            n = normal_mappings,
          },
        },

        pickers = {
          buffers = {
            mappings = {
              n = {
                ["<C-x>"] = actions.delete_buffer,
              },
            },
          },

          git_branches = {
            previewer = false,
            mappings = {
              n = {
                ["<C-x>"] = function(prompt_bufnr)
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

          lsp_references = {
            layout_strategy = "vertical",
            layout_config = {
              width = 0.9,
              height = 0.9,
              preview_cutoff = 1,
            },
          },
        },

        extensions = {
          file_browser = {
            hijack_netrw = true,
            grouped = true,
            hidden = true,
            respect_gitignore = false,
            display_stat = { date = true, size = true, },
            path_display = { truncate = 2 },
            mappings = {
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
      require("telescope").load_extension("undo")
      require("telescope").load_extension("git_worktree")
    end,
  },
}

return M
