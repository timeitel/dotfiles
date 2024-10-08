local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

require("lazy").setup("tmtl.plugins")
require("tmtl.options")
require("tmtl.autocmds")
require("tmtl.keymaps")
require("tmtl.keymaps-telescope")
require("tmtl.keymaps-git")
require("tmtl.keymaps-harpoon")
require("tmtl.keymaps-neoscroll")
require("tmtl.snippets")
require("tmtl.git")
require("tmtl.dap")
require("tmtl.lsp-progress")
