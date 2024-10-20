local git = {
  name = "git:push",
  builder = function()
    return {
      cmd = "git push",
      name = "| git push",
    }
  end,
}

return git
