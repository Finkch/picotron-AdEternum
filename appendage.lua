--[[
    models appendages, for procedural animation

]]

Appendage = {}
Appendage.__index = Appendage
Appendage.__type  = "appendage"

function Appendage:new(joint, length, target)
    local a = {
        joint  = joint,     -- position relative to sprite
        tip    = joint + Vec:new(0, length), -- position of the tip of the joint
        length = length,    -- length of the appendage
        target = target,    -- where to try and reach
        body   = nil        -- the body that owns this appendage
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
    self.tip = totarget:normal() * self.length
    local totip = self.tip + tojoint

    -- for now, just draws a red line for the appendage
    line(tojoint.x, tojoint.y, totip.x, totip.y, 8)
end

