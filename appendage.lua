--[[
    models appendages, for procedural animation

]]

include("finkchlib/ttype.lua")

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
    if (ttype(self.parent) == "entity") then
        self.tojoint = self.body.pos + self.joint
    elseif (ttype(self.parent) == "appendage") then
        self.tojoint = self.parent.totip
    else
        error("unknown type for limb parent \"" .. type(self.parent) .. "\"")
    end

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



-- sets parent or child status
function Appendage:setparent(appendage)
    self.parent = appendage
    appendage.child = self
end

function Appendage:setchild()
    self.child = appendage
    appendage.parent = self
end