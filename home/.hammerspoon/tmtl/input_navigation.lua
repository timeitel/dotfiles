local enableHotkeyOutsideTerminal = function(windowFilter, hotkey)
  windowFilter:subscribe(hs.window.filter.windowFocused, function()
    hotkey:enable()
  end)

  windowFilter:subscribe(hs.window.filter.windowUnfocused, function()
    hotkey:disable()
  end)
end

local wf = hs.window.filter.new():setFilters({ kitty = false, Terminal = false })
local wfIncludingObsidian = hs.window.filter.new():setFilters({ kitty = false, Terminal = false, Obsidian = false })

-- <C-w> to delete previous word
enableHotkeyOutsideTerminal(
  wf,
  hs.hotkey.new({ "ctrl" }, "w", function()
    hs.eventtap.keyStroke({ "alt" }, "delete", 0)
  end)
)

-- <C-h> to delete previous letter
enableHotkeyOutsideTerminal(
  wf,
  hs.hotkey.new({ "ctrl" }, "h", function()
    hs.eventtap.keyStroke({}, "delete", 0)
  end)
)

-- <C-d> to delete next word
enableHotkeyOutsideTerminal(
  wfIncludingObsidian,
  hs.hotkey.new({ "ctrl" }, "d", function()
    hs.eventtap.keyStroke({ "alt" }, "forwarddelete", 0)
  end)
)

-- <C-u> to delete line
enableHotkeyOutsideTerminal(
  wfIncludingObsidian,
  hs.hotkey.new({ "ctrl" }, "u", function()
    hs.eventtap.keyStroke({ "cmd" }, "right", 0)
    hs.eventtap.keyStroke({ "cmd" }, "delete", 0)
  end)
)

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
  hs.hotkey.new({ "ctrl" }, "e", function()
    hs.eventtap.keyStroke({}, "pagedown", 0)
  end)
)
-- TODO: only scroll half page
enableHotkeyOutsideTerminal(
  wf,
  hs.hotkey.new({ "ctrl" }, "y", function()
    hs.eventtap.keyStroke({}, "pageup", 0)
  end)
)
