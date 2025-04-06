local M = {}

M.get_visual_selection = function()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

M.shallow_copy = function(t)
  local t2 = {}
  for k, v in pairs(t) do
    t2[k] = v
  end
  return t2
end

M.request_confirm = function(options)
  local opts = options or {}
  local on_confirm = opts.on_confirm
  local on_reject = opts.on_reject
  local prompt = "Are you sure you'd like to " .. opts.prompt .. "? (&Yes\n&No)"

  if vim.fn.confirm("", prompt, 1) == 1 then
    on_confirm()
  elseif on_reject ~= nil then
    on_reject()
  end
end

M.on_attach_lsp = function()
  local function map(m, k, v, d)
    vim.keymap.set(m, k, v, { noremap = true, silent = true, buffer = 0, desc = d })
  end

  map("n", "]e", function()
    vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
  end, "Next [E]rror")

  map("n", "[e", function()
    vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
  end, "Previous [E]rror")

  map("n", "<C-n>", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, "[N]ext diagnostic")

  map("n", "<leader>la", function()
    vim.lsp.buf.code_action()
  end, "[L]SP code [A]ctions")

  map("n", "<leader>lh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
  end, "[L]SP [H]ints toggle")

  map("n", "<leader>lr", function()
    vim.lsp.buf.rename()
  end, "[L]SP [R]ename")

  map("n", "<leader><leader>lr", function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    for _, client in ipairs(clients) do
      local id = client.id
      vim.lsp.stop_client(id)
      vim.lsp.start_client(client.config)
      print("Restarted lsp client: " .. client.name)
    end
  end, "[L]SP [R]estart")

  map("n", "<leader><leader>li", function()
    vim.cmd([[ checkhealth lsp ]])
  end, "[L]SP [I]nfo")

  map({ "i", "n" }, "<C-k>", function()
    vim.lsp.buf.signature_help()
  end, "Lsp signature")

  map("n", "gd", function()
    vim.lsp.buf.definition()
    vim.schedule(function()
      vim.fn.feedkeys("zz")
    end)
  end, "Lsp [G]o to [D]efinition")

  map("n", "gI", function()
    vim.lsp.buf.implementation()
    vim.schedule(function()
      vim.fn.feedkeys("zz")
    end)
  end, "Lsp [G]o to [I]mplementation")

  map("n", "gov", function()
    vim.cmd([[only]])
    vim.cmd([[vs]])
    vim.lsp.buf.definition()

    vim.schedule(function()
      vim.fn.feedkeys("zz")
    end)
  end, "Lsp [G]o to [D]efinition in vertical split")

  map("n", "R", function()
    require("telescope.builtin").lsp_references({ show_line = false, include_declaration = false })
  end, "Lsp [R]eferences")
end

return M
