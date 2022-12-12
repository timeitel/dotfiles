local function hard_refresh()
  local win = hs.window.focusedWindow()
  local browser = hs.application.find("Brave Browser")
  browser:activate() -- looks like app has to be active for reload menu item, so toggle focus
  browser:selectMenuItem({ "View", "Force Reload This Page" })
  win:focus()
end

local function scroll(vertical)
  return function()
    hs.eventtap.event.newScrollEvent({ 0, vertical }, {}):post()
  end
end

local modifiers = { "ctrl", "alt" }
hs.hotkey.bind(modifiers, "j", hard_refresh)

-- TODO: filter for browser
-- hs.hotkey.bind("ctrl", "d", scroll(-10))
-- hs.hotkey.bind("ctrl", "u", scroll(10))
