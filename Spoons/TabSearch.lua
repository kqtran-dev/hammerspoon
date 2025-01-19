local obj = {}
obj.__index = obj

function obj:init()
    -- Initialize the Spoon (if needed, you can add configuration setup here)
end

function obj:trigger()
    -- Focus the address bar
    hs.eventtap.keyStroke({"cmd"}, "l")  -- Simulates Command + L (macOS equivalent of Ctrl + L)
    
    -- Delay to ensure the address bar is focused
    hs.timer.doAfter(0.1, function()
        -- Type '%' followed by a space
        hs.eventtap.keyStrokes("% ")
    end)
end

return obj

