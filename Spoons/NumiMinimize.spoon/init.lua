local log = hs.logger.new('numi', 'debug')
local obj = {}

-- Function to check if Numi is the focused application
local function isNumiFocused()
    local app = hs.application.frontmostApplication()
    return app:name() == "Numi"
end

-- Function to bind the hotkey
function obj:bindHotkey()
    hs.hotkey.bind({"cmd", "shift"}, "c", function()
        local numiApp = hs.application.get("Numi") -- Try to get the application

        -- If Numi does not exist, launch it and exit early
        if not numiApp then
            log.d("Numi is not running. Launching Numi")
            hs.application.launchOrFocus("Numi")
            return
        end

        -- If Numi is focused, hide it and exit early
        if numiApp:isFrontmost() then
            log.d("Hiding Numi")
            hs.eventtap.keyStroke({"cmd"}, "h", numiApp)
            return
        end

        -- If Numi is running but not focused, activate it and send Cmd+Shift+C
        numiApp:activate()
        log.d("Sending Cmd+Shift+C")
        hs.eventtap.keyStroke({"cmd", "shift"}, "c", numiApp)
    end)
end

return obj
