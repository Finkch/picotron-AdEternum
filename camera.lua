--[[
    controls the camera

]]

include("finkchlib/ttype.lua")

Camera = {}
Camera.__index = Camera

-- constructor
function Camera:new()
    local c = {x = 0, y = 0}
    setmetatable(c, Camera)
    return c
end

-- metamethods
function Camera:__call(x, y)
    if (ttype(x) == "vec") x, y = x.x, x.y
    camera(x - 240, y - 134)
end 