--[[
    models appendages, for procedural animation

]]

Appendage = {}
Appendage.__index = Appendage

function Appendage:new(joint, length, target)
    local a = {
        joint = joint,      -- position relative to sprite
        length = length,    -- length of the appendage
        target = target,    -- where to try and reach
        body = nil          -- the body that owns this appendage
    }
    setmetatable(a, Appendage)
    return a
end

function Appendage:draw()

    -- gets absolute position to joint
    local tojoint = self.body.pos + self.joint

    -- gets a vector that points from the joint towards the target
    local totarget = self.target - tojoint

    -- creates the vector for the appendage
    local appendage = totarget:normal() * self.length + tojoint

    -- for now, just draws a red line for the appendage
    line(tojoint.x, tojoint.y, appendage.x, appendage.y, 8)
end

