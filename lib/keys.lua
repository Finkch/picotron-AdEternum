
-- tracks keyboard inputs

Keys = {}
Keys.__index = Keys


-- a globally accessable class representing the keyboard
keys = {}

function init_keys(buttons)
    keys = Keys:new(buttons)
end


-- a class to track keyboard state
function Keys:new(buttons)

    local keys = {}

    -- gives each button some info
    for i = 1, #buttons do
        keys[buttons[i]] = {
            down        = 0,        -- frames button has been held down
            up          = 0,        -- frames the button has been up
            held        = false,    -- whether the button is currently down
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
            v.held = true

            -- checks if the key was pressed this frame
            v.pressed = v.down == 0

            -- increments frames pressed down
            v.down  += 1
            v.up    =  0

        else
            v.held = false

            -- checks if the key was released this frame
            v.released = v.up == 0

            -- resets frames count
            v.down  =  0
            v.up    += 1
 
        end
    end
end

-- functions to easily check status of a key
function Keys:down(key)
    return self[key].down
end

function Keys:up(key)
    return self[key].up
end

function Keys:held(key)
    return self[key].held
end

function Keys:pressed(key)
    return self[key].pressed
end

function Keys:released(key)
    return self[key].released
end