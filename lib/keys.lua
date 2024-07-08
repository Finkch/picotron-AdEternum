--[[
    handles keyboard and mouse
]]

include("lib/vec.lua")

Keys = {}
Keys.__index = Keys


-- a class to track keyboard state
function Keys:new(buttons)

    local k = {
        spos = Vec:new(), -- screen coordinates
        pos  = Vec:new(), -- map coordinates
        keys = {}
    }

    -- gives each button some info
    for i = 1, #buttons do
        k.keys[buttons[i]] = {
            down        = 0,        -- frames button has been held down
            up          = 0,        -- frames the button has been up
            held        = false,    -- whether the button is currently down
            pressed     = false,    -- whether the button was initially pressed this frame
            released    = false,    -- whether the button was released this frame
        }
    end

    setmetatable(k, Keys)
    return k
end


-- checks status of each key being tracked
function Keys:update()

    -- gets mouse state
    local cx, cy, mb = mouse()

    -- updates mouse position
    self.spos = Vec:new(cx, cy)
    self.pos  = self.spos + cam.pos -- need camera position


    -- updates all keys
    for k, v in pairs(self.keys) do

        -- checks if the key is down
        local kd = nil
        if (k == "lmb") then
            kd = mb & 0b1 != 0
        elseif (k == "rmb") then
            kd = mb & 0b2 != 0
        else
            kd = key(k)
        end

        -- handles both cases for key up and down
        if (kd) then
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
    return self.keys[key].down
end

function Keys:up(key)
    return self.keys[key].up
end

function Keys:held(key)
    return self.keys[key].held
end

function Keys:pressed(key)
    return self.keys[key].pressed
end

function Keys:released(key)
    return self.keys[key].released
end
