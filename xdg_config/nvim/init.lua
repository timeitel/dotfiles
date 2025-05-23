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
require("tmtl.lsp")
require("tmtl.maps")
require("tmtl.maps.movement")
require("tmtl.options")
require("tmtl.autocmds")
require("tmtl.snippets")
