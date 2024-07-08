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

-- metamethods
function Camera:__call(x, y)
    if (ttype(x) == "vec") x, y = x.x, x.y
    if (not x) then
        camera()
    else
        camera(x - 240, y - 135)
    end
end 