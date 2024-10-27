local function filename_first(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)
  if parent == "." then
    return tail
  end
  return string.format("%s\t\t%s", tail, parent)
end

local M = {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    keys = {
      { "<leader><leader>gs", "<CMD>Telescope git_stash<CR>", desc = "[G]it [S]tash" },
      {
        "<leader>gb",
        "<CMD>Telescope git_branches<CR>",
        desc = "[G]it [B]ranches",
      },
      {
        "<C-p>",
        function()
          require("telescope").extensions.smart_open.smart_open({
            initial_mode = "insert",
            cwd_only = true,
          })
        end,
        desc = "Find - files",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep({ initial_mode = "insert" })
        end,
        desc = "[F]ind - live [G]rep",
      },
      {
        "<leader>fg",
        function()
          local text = require("tmtl.utils").get_visual_selection()
          require("telescope.builtin").grep_string({ search = text })
        end,
        desc = "[F]ind - live [G]rep selection",
        mode = "v",
      },
    },
    config = function()
      local telescope = require("telescope")
      local action_state = require("telescope.actions.state")
      local actions = require("telescope.actions")
      local fb_actions = telescope.extensions.file_browser.actions
      local copy = require("tmtl.utils").shallow_copy
      local state = require("telescope.state")

      local slow_scroll = function(prompt_bufnr, direction)
        local previewer = action_state.get_current_picker(prompt_bufnr).previewer
        local status = state.get_status(prompt_bufnr)
        -- Check if we actually have a previewer and a preview window
        if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
          return
        end
        previewer:scroll_fn(1 * direction)
      end

      local function close_and_harpoon(map)
        return function()
          vim.fn.feedkeys("q")
          vim.fn.feedkeys(vim.keycode(map))
        end
      end

      local insert_mappings = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-e>"] = function(bufnr)
          slow_scroll(bufnr, 1)
        end,
        ["<C-y>"] = function(bufnr)
          slow_scroll(bufnr, -1)
        end,
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
        ["<M-n>"] = actions.cycle_history_next,
        ["<M-p>"] = actions.cycle_history_prev,
      }

      local normal_mappings = copy(insert_mappings)
      normal_mappings["<M-h>"] = close_and_harpoon("<M-h>")
      normal_mappings["<M-j>"] = close_and_harpoon("<M-j>")
      normal_mappings["<M-k>"] = close_and_harpoon("<M-k>")
      normal_mappings["<M-l>"] = close_and_harpoon("<M-l>")

      normal_mappings["<leader>qf"] = function(bfnr)
        actions.smart_send_to_qflist(bfnr)
        vim.cmd([[copen]])
      end
      normal_mappings["g"] = false
      normal_mappings["c"] = false
      normal_mappings["q"] = actions.close
      normal_mappings["<C-u>"] = actions.preview_scrolling_up
      normal_mappings["m"] = actions.select_default + actions.center
      normal_mappings["<leader>gd"] = function(bfnr)
        actions.close(bfnr)
        vim.cmd([[DiffviewOpen]])
      end
      normal_mappings["<leader>gh"] = function(bfnr)
        actions.close(bfnr)
        vim.cmd([[DiffviewFileHistory]])
      end
      normal_mappings["<leader>yp"] = function()
        local entry = action_state.get_selected_entry()
        local filename = entry.Path.filename
        local copy_cmd = string.format(':let @+="%s"', filename)
        vim.cmd(copy_cmd)
        require("notify")("Copied file path to clipboard")
      end

      local file_browser_normal_mappings = {
        ["n"] = fb_actions.create,
        ["cd"] = fb_actions.change_cwd,
        ["gf"] = function()
          local entry = action_state.get_selected_entry()
          local filename = entry.Path.filename
          require("telescope.builtin").live_grep({
            search_dirs = { filename },
            results_title = filename,
            initial_mode = "insert",
          })
        end,
        ["gp"] = function()
          local entry = action_state.get_selected_entry()
          local filename = entry.Path.filename
          require("telescope.builtin").find_files({
            search_dirs = { filename },
            results_title = filename,
            initial_mode = "insert",
          })
        end,
        ["<C-h>"] = fb_actions.goto_parent_dir,
        ["H"] = fb_actions.goto_cwd,
        ["o"] = fb_actions.open,
        ["<C-x>"] = fb_actions.remove,
        ["<C-o>"] = function()
          vim.api.nvim_input("<Esc>")
          vim.api.nvim_input("<C-o>")
        end,
      }

      telescope.setup({
        defaults = {
          initial_mode = "normal",
          file_ignore_patterns = { "%.DS_Store", "%.git/" },
          multi_icon = "<>",
          sorting_strategy = "ascending",
          path_display = filename_first,
          layout_strategy = "vertical",
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
            grouped = true,
            hidden = true,
            respect_gitignore = false,
            display_stat = { date = true, size = true },
            path_display = { truncate = 2 },
            mappings = {
              n = file_browser_normal_mappings,
            },
          },
          ["ui-select"] = {
            require("telescope.themes").get_cursor({}),
          },
          smart_open = {
            match_algorithm = "fzy",
          },
        },
      })

      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("notify")
      require("telescope").load_extension("undo")
    end,
  },
}

return M
