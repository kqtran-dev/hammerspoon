local TabSearch = {}

function TabSearch.trigger()
    local frontApp = hs.application.frontmostApplication()
    if frontApp:name() == "Firefox" then
        -- hs.alert("Triggering Tab Search in Firefox!")
        -- 
        -- Focus the address bar
        hs.eventtap.keyStroke({"cmd"}, "l")  -- Cmd+L equivalent to focus address bar

        -- Small delay before typing %
        -- hs.timer.doAfter(0.2, function()
            hs.eventtap.keyStrokes("% ")
        -- end)
    else
        -- hs.alert("This shortcut only works in Firefox!")
    end
end

return TabSearch

