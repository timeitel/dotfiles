local function color()
  vim.defer_fn(function()
    vim.cmd("set winhighlight=Normal:MyNormal,NormalNC:MyNormalNC")
  end, 20)
end

color()
