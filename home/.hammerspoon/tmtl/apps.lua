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

local prev_track = hs.hotkey.new('shift', 'H', function()
  hs.spotify.previous()
end)

local next_track = hs.hotkey.new('shift', 'L', function()
  hs.spotify.next()
end)

hs.window.filter.new('Spotify')
    :subscribe(hs.window.filter.windowUnfocused, function()
      prev_track:disable()
      next_track:disable()
    end)

local modifiers = { "ctrl", "cmd" }
hs.hotkey.bind(modifiers, "h", open_app("Brave Browser"))
hs.hotkey.bind(modifiers, "j", function()
  prev_track:enable()
  next_track:enable()
  open_app("Spotify")()
end)
hs.hotkey.bind(modifiers, "k", open_app("Obsidian"))
hs.hotkey.bind(modifiers, "l", open_app("kitty"))
hs.hotkey.bind(modifiers, "n", open_app("Slack"))
hs.hotkey.bind(modifiers, ";", open_app("Messenger"))
hs.hotkey.bind(modifiers, "y", open_app("TickTick"))
-- TODO: change cmd shift a to cmd-k to change tabs, and cmd shift HL for changing tabs
