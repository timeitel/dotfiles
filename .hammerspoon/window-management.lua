local grid = require("hs.grid")
local total_height = 20
local total_width = 20
local half_total_width = total_width / 2

hs.window.animationDuration = 0.2
grid.MARGINX = 0
grid.MARGINY = 0
grid.GRIDHEIGHT = total_height
grid.GRIDWIDTH = total_width

local function resize_window(direction)
  return function()
    if direction == "smaller" then
      grid.resizeWindowShorter()
      grid.resizeWindowThinner()
    else
      grid.resizeWindowTaller()
      grid.resizeWindowWider()
    end
  end
end

local function maximize_window()
  hs.window.focusedWindow():maximize()
end

local function is_single_screen()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  return screen:id() == screen:previous():id()
end

local function move_window_half_right()
  local win = hs.window.focusedWindow()
  local win_grid = hs.grid.get(win)
  local is_right_half = win_grid.x == half_total_width and win_grid.y == 0.0 and win_grid.w == half_total_width

  if not is_right_half then
    hs.grid.set(win, { x = half_total_width, y = 0, w = half_total_width, h = total_height }, win:screen())
    return
  end

  if is_single_screen() then
    return
  end

  local next_screen = win:screen():next()
  hs.grid.set(win, { x = 0, y = 0, w = half_total_width, h = total_height }, next_screen)
end

local function move_window_half_left()
  local win = hs.window.focusedWindow()
  local win_grid = hs.grid.get(win)
  local is_left_half = win_grid.x == 0.0 and win_grid.y == 0.0 and win_grid.w == half_total_width

  if not is_left_half then
    hs.grid.set(win, { x = 0, y = 0, w = half_total_width, h = total_height }, win:screen())
    return
  end

  if is_single_screen() then
    return
  end

  local previous_screen = win:screen():previous()
  hs.grid.set(win, { x = half_total_width, y = 0, w = half_total_width, h = total_height }, previous_screen)
end

local function center_window()
  local toScreen = nil
  local inBounds = true
  hs.window.focusedWindow():centerOnScreen(toScreen, inBounds)
end

local modifiers = { "ctrl", "shift" }
hs.hotkey.bind(modifiers, "h", move_window_half_left)
hs.hotkey.bind(modifiers, "l", move_window_half_right)
hs.hotkey.bind(modifiers, "return", maximize_window)
hs.hotkey.bind(modifiers, "c", center_window)
hs.hotkey.bind(modifiers, "-", resize_window("smaller"))
hs.hotkey.bind(modifiers, "=", resize_window("larger"))
hs.hotkey.bind(modifiers, "Right", grid.resizeWindowWider)
hs.hotkey.bind(modifiers, "Left", grid.resizeWindowThinner)
hs.hotkey.bind(modifiers, "Up", grid.resizeWindowTaller)
hs.hotkey.bind(modifiers, "Down", grid.resizeWindowShorter)
