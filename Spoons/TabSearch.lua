local TabSearch = {}

function TabSearch.trigger()
    local frontApp = hs.application.frontmostApplication()
    if frontApp:name() == "Firefox" then
        -- Focus the address bar
        hs.eventtap.keyStroke({"cmd"}, "l")  -- Cmd+L equivalent to focus address bar
        hs.eventtap.keyStrokes("% ")
    else
        -- hs.alert("This shortcut only works in Firefox!")
    end
end

return TabSearch

