local enableHotkeyOutsideTerminal = function(windowFilter, hotkey)
  windowFilter:subscribe(hs.window.filter.windowFocused, function()
    hotkey:enable()
  end)

  windowFilter:subscribe(hs.window.filter.windowUnfocused, function()
    hotkey:disable()
  end)
end

local wf = hs.window.filter.new():setFilters({ kitty = false, Terminal = false, Obsidian = false })

-- Up & down, mostly used for navigating browser suggestions and accepting
enableHotkeyOutsideTerminal(
  wf,
  hs.hotkey.new({ "ctrl" }, "k", function()
    hs.eventtap.keyStroke({}, "up", 0)
  end)
)

enableHotkeyOutsideTerminal(
  wf,
  hs.hotkey.new({ "ctrl" }, "j", function()
    hs.eventtap.keyStroke({}, "down", 0)
  end)
)

enableHotkeyOutsideTerminal(
  wf,
  hs.hotkey.new({ "ctrl" }, "l", function()
    hs.eventtap.keyStroke({}, "return", 0)
  end)
)

enableHotkeyOutsideTerminal(
  wf,
  hs.hotkey.new({ "ctrl" }, "w", function()
    hs.eventtap.keyStroke({ "alt" }, "delete", 0)
  end)
)

enableHotkeyOutsideTerminal(
  wf,
  hs.hotkey.new({ "ctrl" }, "u", function()
    hs.eventtap.keyStroke({ "cmd" }, "right", 0)
    hs.eventtap.keyStroke({ "cmd" }, "delete", 0)
  end)
)
