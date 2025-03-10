local obj = {}
obj.__index = obj
obj.name = "DesktopSwitcher"

local lastPress = {}
local doubleTapTime = 0.15
local sendOriginalKeyDelay = 0.16 -- Slightly longer than doubleTapTime

function obj:getFocusedWindowInfo()
    local win = hs.window.focusedWindow()
    if win then
        local app = win:application():name()
        local title = win:title()
        return app .. " - " .. title
    else
        return "No Window Focused"
    end
end

function obj:switchDesktopAndFocusWindow(desktopNumber)
    -- Switch to the desktop
    hs.eventtap.keyStroke({"ctrl"}, tostring(desktopNumber))

    -- Wait 0.4s for desktop switch, then focus on the first window on the new desktop
    hs.timer.doAfter(0.4, function()
        local win = hs.window.focusedWindow()

        -- If the current focused window is nil (possibly nothing on the new desktop), find one
        if not win then
            -- Try to find a window on the current desktop (which may also be on the second monitor)
            local windows = hs.window.allWindows()
            for _, w in ipairs(windows) do
                if w:isVisible() then
                    w:focus()  -- Focus on the first visible window found
                    break
                end
            end
        else
            -- Focus on the window on the current desktop
            hs.alert.show("Desktop " .. desktopNumber .. "\n" .. self:getFocusedWindowInfo())
        end
    end)
end

function obj:bindHotkey(fKey, desktopNumber)
    lastPress[fKey] = 0  -- Initialize last press timestamp

    hs.hotkey.bind({}, fKey, function()
        local now = hs.timer.absoluteTime()

        if (now - lastPress[fKey]) / 1e9 < doubleTapTime then
            -- Detected double-tap: Switch desktop and focus window
            self:switchDesktopAndFocusWindow(desktopNumber)
        else
            -- Wait to see if a second tap happens before sending the key
            hs.timer.doAfter(sendOriginalKeyDelay, function()
                if (hs.timer.absoluteTime() - lastPress[fKey]) / 1e9 >= doubleTapTime then
                    hs.eventtap.keyStroke({}, fKey) -- Send the original F key if no second tap
                end
            end)
        end

        lastPress[fKey] = now
    end)
end

function obj:start()
    hs.alert.show("DesktopSwitcher Started!")

    -- Bind F1 to F5 for Desktops 1 to 5
    for i = 1, 5 do
        self:bindHotkey("F" .. i, i)
    end
end

return obj
