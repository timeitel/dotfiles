local function hard_refresh()
  local win = hs.window.focusedWindow()
  local browser = hs.application.find("Brave Browser")
  browser:activate() -- looks like app has to be active for reload menu item, so toggle focus
  browser:selectMenuItem({ "View", "Force Reload This Page" })
  win:focus()
end

local modifiers = { "ctrl", "alt" }
hs.hotkey.bind(modifiers, "h", hard_refresh)
