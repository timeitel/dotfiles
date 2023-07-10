local git = {
  name = "git:undo_last_commit",
  builder = function()
    return {
      cmd = "git reset --soft HEAD~1",
      name = "| git reset --soft HEAD~1",
    }
  end,
}

return git
