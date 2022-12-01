--- start love you
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "l", function()
  hs.alert.show("love you")
end)
--- end love you

--- start quick open applications
local function open_app(name)
  return function()
    hs.application.launchOrFocus(name)
    if name == "Finder" then
      hs.appfinder.appFromName(name):activate()
    end
  end
end

hs.hotkey.bind({ "ctrl", "cmd" }, "C", open_app("Visual Studio Code"))
hs.hotkey.bind({ "ctrl", "cmd" }, "G", open_app("Google Chrome"))
hs.hotkey.bind({ "ctrl", "cmd" }, "T", open_app("iTerm"))
hs.hotkey.bind({ "ctrl", "cmd" }, "S", open_app("Slack"))
--- end quick open applications
