local function filename_first(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)
  if parent == "." then
    return tail
  end
  return string.format("%s\t\t%s", tail, parent)
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local pieces = vim.split(prompt, "  ")
      local args = { "rg" }
      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, "-g")
        table.insert(args, pieces[2])
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten({
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
      })
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "Live Grep with File Filter",
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sort = require("telescope.sorters").empty(),
    })
    :find()
end

local M = {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    keys = {
      {
        "<leader>gb",
        "<CMD>Telescope git_branches<CR>",
        desc = "[G]it [B]ranches",
      },
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
        "<leader>fg",
        function(opts)
          live_multigrep(opts)
        end,
        desc = "[F]ind - live [G]rep",
      },
      {
        "<leader>fg",
        function()
          local text = require("tmtl.utils").get_visual_selection()
          require("telescope.builtin").grep_string({ search = text, additional_args = { "--hidden" } })
        end,
        desc = "[F]ind - live [G]rep selection",
        mode = "v",
      },
      {
        "<leader>ft",
        function()
          require("telescope.builtin").grep_string({ search = "TODO" })
        end,
        desc = "[F]ind [T]ODOs",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
        end,
        desc = "[F]ind [B]uffers",
      },
      {
        "<leader>fs",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "[F]ind [S]ymbols",
      },
      {
        "<leader>fw",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols()
        end,
        desc = "[F]ind [W]orkspace symbols",
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
        "<leader>fr",
        function()
          require("telescope.builtin").resume({ initial_mode = "normal" })
        end,
        desc = "[F]ind [R]esume: last picker",
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
      {
        "<leader>fc",
        function()
          require("telescope.builtin").commands()
        end,
        desc = "[F]ind [C]ommands",
      },
      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "[F]ind [H]elp - docs",
      },
      {
        "<leader>f;",
        "<CMD>TermSelect<CR>",
        desc = "[F]ind terminals",
      },
    },
    config = function()
      local telescope = require("telescope")
      local action_state = require("telescope.actions.state")
      local actions = require("telescope.actions")
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

      telescope.setup({
        defaults = {
          initial_mode = "insert",
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

          find_files = {},

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
