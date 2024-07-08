--[[
    controls the camera

]]

include("lib/vec.lua")
include("finkchlib/ttype.lua")

Camera = {}
Camera.__index = Camera

-- constructor
function Camera:new()
    local c = {pos = Vec:new()}
    setmetatable(c, Camera)
    return c
end


-- camera methods

-- focuses the camera to a point
function Camera:focus(pos)
    self.pos = pos
end



-- metamethods

-- calling a camera moves camera there
function Camera:__call(reset)
    if (reset) then
        camera()
    else
        camera(self.pos.x - 240, self.pos.y - 135)
    end
end