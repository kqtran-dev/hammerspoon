hs.hotkey.bind({"ctrl", "shift"}, "A", function()
    local frontApp = hs.application.frontmostApplication()
    if frontApp:name() == "Firefox" then
        -- hs.alert("Triggering Tab Search in Firefox!")
        hs.eventtap.keyStroke({"cmd"}, "l")
        -- hs.timer.doAfter(0.0, function()
            hs.eventtap.keyStrokes("% ")
        -- end)
    else
        -- hs.alert("This shortcut is not available in " .. frontApp:name())
    end
end)

-- Notify that Hammerspoon is ready
hs.alert("Hammerspoon Config Loaded!")

function reloadConfig(files)
    hs.reload()
end

local configWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig)
configWatcher:start()
-- hs.alert("Hammerspoon Config Auto-Reload Enabled!")

