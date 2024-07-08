--[[
    contains sprite info for a single frame of animation

]]

Sprite = {}
Sprite.__index = Sprite
Sprite.__type = "sprite"

function Sprite:new(sprite, mounts)
    mounts = mounts or {}
    local s = {
        sprite = snum,
        mounts = mounts
    }

    setmetatable(s, Sprite)
    return s
end