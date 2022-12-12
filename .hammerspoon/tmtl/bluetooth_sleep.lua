require("string")

-- turn off bluetooth when in sleep
-- TODO: check it works
local function check_bluetooth_result(rc, stderr, stderr)
  if rc ~= 0 then
    print(string.format("Unexpected result executing `blueutil`: rc=%d stderr=%s stdout=%s", rc, stderr, stdout))
  end
end

local function bluetooth(power)
  print("Setting bluetooth to " .. power)
  local t = hs.task.new("/opt/homebrew/bin/blueutil", check_bluetooth_result, { "--power", power })
  t:start()
end

local function f(event)
  if event == hs.caffeinate.watcher.systemWillSleep then
    bluetooth("off")
  elseif event == hs.caffeinate.watcher.screensDidWake then
    bluetooth("on")
  end
end

local watcher = hs.caffeinate.watcher.new(f)
watcher:start()
