--[[
    models appendages, for procedural animation

]]

include("finkchlib/ttype.lua")

Appendage = {}
Appendage.__index = Appendage
Appendage.__type  = "appendage"

function Appendage:new(joint, length)    
    local a = {
        joint   = joint,     -- relative positions
        tip     = joint + Vec:new(0, length), 
        tojoint = nil,       -- absolute positions
        totip   = nil,       
        length  = length,    -- length of the appendage
        target  = nil,       -- where to try and reach
        parent  = nil,       -- parent appendage
        child   = nil        -- child appendage
    }
    setmetatable(a, Appendage)
    return a
end

function Appendage:update()

    -- gets absolute position to joint
    if (ttype(self.parent) == "entity") then
        self.tojoint = self.parent.pos + self.joint
    elseif (ttype(self.parent) == "appendage") then
        self.tojoint = self.parent.totip
    else
        error("unknown type for limb parent \"" .. type(self.parent) .. "\"")
    end

    -- gets a vector that points from the joint towards the target
    local totarget = self.target - self.tojoint

    -- creates the vector for the appendage
    self.tip = totarget:normal() * self.length
    self.totip = self.tip + self.tojoint
end

function Appendage:draw()

    -- for now, just draws a red line for the appendage
    line(self.tojoint.x, self.tojoint.y, self.totip.x, self.totip.y, 8)
end



-- sets parent or child status
function Appendage:setparent(appendage)
    self.parent = appendage
    appendage.child = self
    self.joint = appendage.tip
end

function Appendage:setchild(appendage)
    self.child = appendage
    appendage.parent = self
    appendage.joint = self.tip
end