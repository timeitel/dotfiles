local function hard_refresh()
  local win = hs.window.focusedWindow()
  local browser = hs.application.find("Brave Browser")
  browser:activate() -- looks like app has to be active for reload menu item, so toggle focus
  browser:selectMenuItem({ "View", "Force Reload This Page" })
  win:focus()
end

local global_modifiers = { "ctrl", "alt" }
-- local modifiers = { "cmd", "shift" }

hs.hotkey.bind(global_modifiers, "h", hard_refresh)
