--[[
    state machine, mostly to handle animations

]]

State = {}
State.__index = State
State.__type = "state"

function State:new(name, animation)
    local s = {
        name = name,
        animation = animation
    }

    setmetatable(s, State)
    return s
end


-- increments and returns animation frame
function State:anim()
    return self.animation()
end


-- metamethods
function State:__tostring()
    return tostr(self.animation)
end