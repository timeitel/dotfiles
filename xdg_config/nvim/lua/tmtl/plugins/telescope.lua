local M = {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      return require("fzf-lua").setup({
        winopts = {
          preview = { default = "bat" },
        },
        defaults = {
          formatter = "path.filename_first",
          actions = {
            ["ctrl-l"] = require("fzf-lua.actions").file_edit_or_qf,
          },
          keymap = {
            fzf = {
              ["alt-u"] = "half-page-up",
              ["alt-d"] = "half-page-down",
              ["alt-e"] = "preview-page-down",
              ["alt-y"] = "preview-page-up",
            },
          },
        },
      })
    end,
    keys = {
      { "<leader>fz", "<cmd>FzfLua<cr>", desc = "[F]ind - picker options" },
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "[F]ind - [F]iles" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "[F]ind - [G]rep" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "[F]ind - [G]rep", mode = "v" },
      { "<leader>ft", "<cmd>FzfLua grep search=TODO<cr>", desc = "[F]ind - [G]rep [T]ODOs" },
      { "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "[F]ind - [G]rep [W]ord" },
      { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "[F]ind - [S]ymbols" },
      { "<leader>fd", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "[F]ind - [W]orkspace diagnostics" },
      { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "[F]ind - [R]esume last picker" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    keys = {
      {
        "<C-p>",
        function()
          require("telescope").extensions.smart_open.smart_open({
            cwd_only = true,
          })
        end,
        desc = "Find - files",
      },
      {
        "<leader>fk",
        function()
          require("telescope.builtin").keymaps()
          vim.fn.feedkeys("<Space>")
        end,
        desc = "[F]ind [K]eymaps",
      },
      {
        "<leader>fn",
        function()
          require("telescope").extensions.notify.notify(require("telescope.themes").get_dropdown({}))
        end,
        desc = "[F]ind [N]otifications",
      },
      {
        "<leader>fd",
        function()
          require("telescope.builtin").diagnostics(
            require("telescope.themes").get_dropdown({ path_display = "hidden" })
          )
        end,
        desc = "[F]ind [D]iagnostics for workspace",
      },
      {
        "<leader>fu",
        function()
          require("telescope").extensions.undo.undo()
        end,
        desc = "[F]ind [U]ndo history",
      },
    },
    lazy = false,
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      local insert_mappings = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
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
      }

      local normal_mappings = vim.tbl_extend("force", insert_mappings, {
        ["g"] = false,
        ["c"] = false,
        ["q"] = actions.close,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["m"] = actions.select_default + actions.center,
      })

      telescope.setup({
        defaults = {
          initial_mode = "insert",
          file_ignore_patterns = { "%.DS_Store", "%.git/" },
          multi_icon = "<>",
          sorting_strategy = "ascending",
          path_display = function(_, path)
            local tail = vim.fn.basename(path)
            local parent = vim.fn.dirname(path)
            if parent == "," then
              return tail
            end
            return string.format("%s\t\t%s", tail, parent)
          end,
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
          lsp_references = {
            initial_mode = "normal",
            layout_strategy = "vertical",
            layout_config = {
              width = 0.9,
              height = 0.9,
              preview_cutoff = 1,
            },
          },
        },

        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_cursor({}),
          },
          smart_open = {
            match_algorithm = "fzf",
          },
          fzf = {},
        },
      })

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("notify")
      require("telescope").load_extension("undo")
    end,
  },
}

return M
