local function test()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  -- print(screen.toWest())
  print(screen:spacesUUID())
end

local function change_screen()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end

local function move_window_left()
  hs.window.focusedWindow():moveOneScreenWest()
end

local function maximize_window()
  hs.window.focusedWindow():maximize()
end

local function center_window()
  local toScreen = nil
  local inBounds = true
  hs.window.focusedWindow():centerOnScreen(toScreen, inBounds)
end

local modifiers = { "ctrl", "shift" }

hs.hotkey.bind(modifiers, "h", move_window_left)
hs.hotkey.bind(modifiers, "t", test)

hs.hotkey.bind(modifiers, "return", maximize_window)
hs.hotkey.bind(modifiers, "c", center_window)
