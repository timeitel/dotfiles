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
hs.hotkey.bind(modifiers, "j", open_app("YT Music"))
hs.hotkey.bind(modifiers, "k", open_app("Obsidian"))
hs.hotkey.bind(modifiers, "l", open_app("kitty"))
hs.hotkey.bind(modifiers, "n", open_app("Slack"))
hs.hotkey.bind(modifiers, ";", open_app("Messenger"))
hs.hotkey.bind(modifiers, "y", open_app("TickTick"))
hs.hotkey.bind(modifiers, "m", open_app("Postman"))
-- TODO: change cmd shift a to cmd-k to change tabs, and cmd shift HL for changing tabs
