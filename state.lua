--[[
    state machine, mostly to handle animations

]]

State = {}
State.__index = State
State.__type = "state"

function State:new()
    local s = {
        
    }

    setmetatable(s, State)
    return s
end