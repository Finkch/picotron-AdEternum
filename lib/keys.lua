
-- tracks keyboard inputs

Keys = {}
Keys.__index = Keys


-- a globally accessable class representing the keyboard
keys = {}

-- buttons is a list of buttons whose status is tracked
function init_keys(buttons)
    return Keys:new(buttons)
end



-- a class to track keyboard state
function Keys:new(buttons)

    local keys = {}

    -- gives each button some info
    for i = 1, #buttons do
        keys[buttons[i]] = {
            frames      = 0,        -- frames button has been held down
            down        = false,    -- whether the button is currently down
            pressed     = false,    -- whether the button was initially pressed this frame
            released    = false,    -- whether the button was released this frame
        }
    end

    setmetatable(keys, Keys)
    return keys
end


-- checks status of each key being tracked
function Keys:update()
    for k, v in pairs(self) do
        if (key(k)) then
            v.down = true

            -- checks if the key was pressed this frame
            v.pressed = v.frames == 0

            -- increments frames pressed down
            v.frames += 1

        else
            v.down = false

            -- checks if the key was released this frame
            v.released = v.frames > 0

            -- resets frames count
            v.frames = 0
 
        end
    end
end

-- functions to easily check status of a key
function Keys:frames(key)
    return self[key].frames
end

function Keys:down(key)
    return self[key].down
end

function Keys:pressed(key)
    return self[key].pressed
end

function Keys:released(key)
    return self[key].released
end