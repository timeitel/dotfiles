local function hard_refresh()
  local win = hs.window.focusedWindow()
  local browser = hs.application.find("Brave Browser")
  browser:activate() -- looks like app has to be active for reload menu item, so toggle focus
  browser:selectMenuItem({ "View", "Force Reload This Page" })
  win:focus()
end

function applicationWatcher(appName, eventType, appObject)
  if eventType == hs.application.watcher.activated then
    if appName == "YourAppNameHere" then
      hs.eventtap.event.newScrollEvent({ 0, vertical }, {}):post()
    end
  end
end

-- local appWatcher = hs.application.watcher.new(applicationWatcher)
-- appWatcher:start()

local modifiers = { "ctrl", "alt" }
hs.hotkey.bind(modifiers, "j", hard_refresh)

-- TODO: filter for browser
-- hs.hotkey.bind("ctrl", "d", scroll(-10))
-- hs.hotkey.bind("ctrl", "u", scroll(10))
