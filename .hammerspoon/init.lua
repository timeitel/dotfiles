require("window-management")
require("app-management")

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "l", function()
  hs.alert.show("love you")
end)

local function open_app(name)
  return function()
    hs.application.launchOrFocus(name)
    if name == "Finder" then
      hs.appfinder.appFromName(name):activate()
    end
  end
end

local open_app_modifiers = { "ctrl", "cmd" }
hs.hotkey.bind(open_app_modifiers, "h", open_app("Brave Browser"))
hs.hotkey.bind(open_app_modifiers, "j", open_app("Spotify"))
hs.hotkey.bind(open_app_modifiers, "k", open_app("Rider"))
hs.hotkey.bind(open_app_modifiers, "l", open_app("kitty"))
hs.hotkey.bind(open_app_modifiers, "n", open_app("Slack"))
hs.hotkey.bind(open_app_modifiers, "y", open_app("Obsidian"))
hs.hotkey.bind(open_app_modifiers, ";", open_app("Messenger"))
-- TODO: window scrolling and browser forward back H, L
-- TODO: refresh browser without switching focus
