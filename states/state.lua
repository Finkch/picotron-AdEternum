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