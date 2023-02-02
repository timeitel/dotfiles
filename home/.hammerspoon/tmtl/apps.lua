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

local modifiers = { "ctrl", "cmd" }
hs.hotkey.bind(modifiers, "h", open_app("Brave Browser"))
hs.hotkey.bind(modifiers, "j", open_app("Spotify"))
hs.hotkey.bind(modifiers, "k", open_app("Obsidian"))
hs.hotkey.bind(modifiers, "l", open_app("kitty"))
hs.hotkey.bind(modifiers, "n", open_app("Slack"))
hs.hotkey.bind(modifiers, ";", open_app("Messenger"))
