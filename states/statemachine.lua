--[[
    describes how many states can intersect

]]

StateMachine = {}
StateMachine.__index = StateMachine
StateMachine.__type = "statemachine"

function StateMachine:new()
    local sm = {

    }

    setmetatable(sm, StateMachine)
    return sm
end