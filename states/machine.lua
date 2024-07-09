--[[
    state machine interface

]]

include("finkchlib/ttype.lua")

Machine = {}
Machine.__index = Machine
Machine.__type = "machine"

function Machine:new(states)
    local m = {
        states = states,        -- list of all states
        current = states[1]     -- current state
    }

    setmetatable(m, Machine)
    return m
end

function Machine:update()

    --      for now, do nothing

    -- checks if transition

    -- updates current

    return self.current
end


-- metamethods
function Machine:__tostring()
    return tostr(self.current)
end