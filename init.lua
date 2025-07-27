-- Require the TabSearch module
local TabSearch = require("Spoons.tabsearch")
-- local cmd0 = require("Spoons.cmd0")

-- Bind the TabSearch trigger to Ctrl+Shift+A
hs.hotkey.bind({"ctrl", "shift"}, "A", TabSearch.trigger)
-- hs.hotkey.bind({"cmd"}, "0", cmd0.trigger)

-- Load the NumiMinimize Spoon
hs.loadSpoon("NumiMinimize")


-- Bind the hotkey using the Spoon
spoon.NumiMinimize:bindHotkey()

-- Load the NumiMinimize Spoon
-- disabling in favor of aerospace config
-- hs.loadSpoon("DesktopSwitcher")
-- spoon.DesktopSwitcher:start()

-- Notify that Hammerspoon is ready
hs.alert("Hammerspoon Config Loaded!")

function reloadConfig(files)
    hs.reload()
end

local configWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.config/hammerspoon/", reloadConfig)
configWatcher:start()
-- hs.alert("Hammerspoon Config Auto-Reload Enabled!")

