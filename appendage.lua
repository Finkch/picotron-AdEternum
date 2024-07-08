--[[
    models appendages, for procedural animation

]]

Appendage = {}
Appendage.__index = Appendage
Appendage.__type  = "appendage"

function Appendage:new(joint, length, target)
    local a = {
        joint   = joint,     -- relative positions
        tip     = joint + Vec:new(0, length), 
        tojoint = nil,       -- absolute positions
        totip   = nil,       
        length  = length,    -- length of the appendage
        target  = target,    -- where to try and reach
        parent  = nil,       -- parent appendage
        child   = nil        -- child appendage
    }
    setmetatable(a, Appendage)
    return a
end

function Appendage:update()

    -- gets absolute position to joint
    self.tojoint = self.body.pos + self.joint

    -- gets a vector that points from the joint towards the target
    local totarget = self.target - tojoint

    -- creates the vector for the appendage
    self.tip = totarget:normal() * self.length
    self.totip = self.tip + tojoint
end

function Appendage:draw()
    
    -- for now, just draws a red line for the appendage
    line(self.tojoint.x, self.tojoint.y, self.totip.x, self.totip.y, 8)
end

