--[[
    controls the camera

]]

include("lib/vec.lua")

include("finkchlib/tstr.lua")
include("finkchlib/ttype.lua")
include("finkchlib/tmath.lua")

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
function Camera:focus(focal)

    -- converts entity to a vector to the centre of its sprite.
    -- take floor of centre to prevent half-pixel jitters.
    if (ttype(focal) == "entity") focal = focal.pos + tflr(focal.centre)

    self.pos = focal - Vec:new(240, 135)
end



-- metamethods

-- calling a camera moves camera there
function Camera:__call(reset)
    if (reset) then
        camera()
    else
        camera(self.pos.x, self.pos.y)
    end
end