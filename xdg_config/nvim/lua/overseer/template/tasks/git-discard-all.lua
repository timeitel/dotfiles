local git = {
  name = "git:discard_all",
  builder = function()
    return {
      cmd = "git restore . && git clean -fd",
      name = "| git restore . && git clean -fd",
    }
  end,
}

return git
