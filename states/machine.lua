--[[
    state machine interface

]]

Machine = {}
Machine.__index = Machine
Machine.__type = "machine"

function Machine:new()
    local m = {

    }

    setmetatable(sm, Machine)
    return m
end