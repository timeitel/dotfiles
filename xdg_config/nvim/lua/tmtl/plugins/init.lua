local M = {
  {
    "inkarkat/vim-ReplaceWithRegister",
    config = function()
      vim.keymap.del("n", "gri") -- replace plugin conflicting with default map
      vim.keymap.del("n", "gra")
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    commit = "e76cb03",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
        },
      })

      harpoon:extend({
        UI_CREATE = function(cx)
          vim.keymap.set("n", "<C-v>", function()
            harpoon.ui:select_menu_item({ vsplit = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set("n", "<C-x>", function()
            harpoon.ui:select_menu_item({ split = true })
          end, { buffer = cx.bufnr })
        end,
      })
    end,
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon"):list():add()
        end,
        desc = "[E]dit List - [A]dd",
      },
      {
        "<leader>e",
        function()
          require("harpoon").ui:toggle_quick_menu(require("harpoon"):list(), { border = "rounded" })
        end,
        desc = "[E]dit [L]ist - toggle",
      },
      {
        "]f",
        function()
          require("harpoon"):list():next()
        end,
        desc = "[E]dit List - next [F]ile",
      },
      {
        "[f",
        function()
          require("harpoon"):list():prev()
        end,
        desc = "[E]dit List - previous [F]ile",
      },
      {
        "<A-h>",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "[E]dit List - file 1",
      },
      {
        "<A-j>",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "[E]dit List - file 2",
      },
      {
        "<A-k>",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "[E]dit List - file 3",
      },
      {
        "<A-l>",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "[E]dit List - file 4",
      },
      {
        "<A-;>",
        function()
          require("harpoon"):list():select(5)
        end,
        desc = "[E]dit List - file 5",
      },
    },
  },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        keymaps = {
          ["-"] = "actions.open_cwd",
          ["<CR>"] = "actions.select",
          ["m"] = "actions.select",
          ["<C-l>"] = "actions.select",
          ["<C-h>"] = "actions.parent",
          ["<C-j>"] = "<down>",
          ["<C-k>"] = "<up>",
          ["<M-p>"] = "actions.preview",
          ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
          ["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
          ["q"] = "actions.close",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["gh"] = "actions.toggle_hidden",
          ["gd"] = "actions.cd",
        },
        use_default_keymaps = false,
        view_options = {
          show_hidden = false,
          is_hidden_file = function(name, _)
            return vim.endswith(name, "_templ.go")
              or vim.endswith(name, "_templ.txt")
              or vim.endswith(name, ".git")
              or vim.endswith(name, "tmp")
              or vim.endswith(name, "node_modules")
          end,
          is_always_hidden = function(name)
            return vim.startswith(name, ".DS_Store")
          end,
        },
        skip_confirm_for_simple_edits = true,
        prompt_save_on_select_new_entry = false,
      })

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open directory" })
      vim.keymap.set("n", "<leader>-f", function()
        vim.cmd("Oil --float")
        vim.defer_fn(function()
          require("oil.actions").preview.callback()
        end, 100)
      end, { desc = "Open directory in [F]loat" })
      vim.keymap.set("n", "<leader>-v", function()
        vim.cmd.wincmd("v")
        vim.cmd("Oil")
      end, { desc = "Open directory in [V]ertical" })
      vim.keymap.set("n", "<leader>-s", function()
        vim.cmd.wincmd("s")
        vim.cmd("Oil")
      end, { desc = "Open directory in horizontal" })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "danielfalk/smart-open.nvim",
    branch = "0.1.x",
    config = function()
      require("telescope").load_extension("smart_open")
    end,
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      plugins = {
        presets = false,
      },
    },
  },
  {
    "sQVe/sort.nvim",
    config = function()
      local map = vim.keymap.set
      map("v", "gos", "<Esc><Cmd>Sort<CR>", { desc = "[S]ort visual selection" })
      map("n", "gos", "vi{<Esc><Cmd>Sort<CR>", { desc = "[S]ort inside curly brace" })
      map("n", "go[", "vi[<Esc><Cmd>Sort<CR>", { desc = "[S]ort inside bracket `[`" })
      map("n", 'go"', 'vi"<Esc><Cmd>Sort<CR>', { desc = '[S]ort inside quotes `"`' })
      map("n", "go'", "vi'<Esc><Cmd>Sort<CR>", { desc = "[S]ort inside single quotes `'`" })

      require("sort").setup({
        delimiters = {
          ",",
          "|",
          ";",
          -- ':', -- used for tailwind psuedo classes
          "s", -- Space
          "t", -- Tab
        },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    opts = {
      disable_filetype = { "TelescopePrompt", "vim" },
    },
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {
      aliases = {
        ["b"] = ")",
        ["c"] = "}",
        ["C"] = "}",
        ["r"] = "]",
        ["q"] = '"',
        ["l"] = "`",
        ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
      },
    },
  },
  {
    "bloznelis/before.nvim",
    config = function()
      local before = require("before")

      before.setup()
      vim.keymap.set("n", "[c", before.jump_to_last_edit, { desc = "Jump to last [C]hange" })
      vim.keymap.set("n", "]c", before.jump_to_next_edit, { desc = "Jump to next [C]hange" })
    end,
  },
}

return M
