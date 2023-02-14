local ok, possession = pcall(require, "possession")
if not ok then
  return
end

possession.setup({
  commands = {
    save = "SSave",
    load = "SLoad",
    delete = "SDelete",
    list = "SList",
  },
})
