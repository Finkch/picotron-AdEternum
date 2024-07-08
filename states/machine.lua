--[[
    state machine interface

]]

Machine = {}
Machine.__index = Machine
Machine.__type = "statemachine"

function Machine:new()
    local m = {

    }

    setmetatable(sm, Machine)
    return m
end