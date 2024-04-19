local grid = require("hs.grid")
local total_height = 20
local total_width = 20

hs.window.animationDuration = 0.2
grid.MARGINX = 0
grid.MARGINY = 0
grid.GRIDHEIGHT = total_height
grid.GRIDWIDTH = total_width

local function move_to_screen_maximized(screen_number)
  return function()
    local win = hs.window.focusedWindow()
    local screen = hs.screen.allScreens()[screen_number]
    if screen ~= nil then
      hs.grid.set(win, { x = 0, y = 0, w = total_width, h = total_height }, screen)
      return
    end
    print("Screen not found")
  end
end

local modifiers = { "ctrl", "shift" }

-- Left / right halves are moved to Rectangle app for better support of different work stations
hs.hotkey.bind(modifiers, "Right", grid.resizeWindowWider)
hs.hotkey.bind(modifiers, "Left", grid.resizeWindowThinner)
hs.hotkey.bind(modifiers, "[", move_to_screen_maximized(1))
hs.hotkey.bind(modifiers, "]", move_to_screen_maximized(2))
hs.hotkey.bind(modifiers, "1", move_to_screen_maximized(1))
hs.hotkey.bind(modifiers, "2", move_to_screen_maximized(2))
hs.hotkey.bind(modifiers, "3", move_to_screen_maximized(3))
