local prev_track = hs.hotkey.new('shift', 'H', function()
  hs.spotify.previous()
end)

local next_track = hs.hotkey.new('shift', 'L', function()
  hs.spotify.next()
end)


hs.window.filter.new('Spotify')
    :subscribe(hs.window.filter.windowFocused, function()
      prev_track:enable()
      next_track:enable()
    end)
    :subscribe(hs.window.filter.windowUnfocused, function()
      prev_track:disable()
      next_track:disable()
    end)
