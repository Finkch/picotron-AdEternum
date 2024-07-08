--[[
    handles animations

]]

Animation = {}
Animation.__index = Animation
Animation.__type = "animation"

function Animation:new(sprites, dur)
    local a = {
        sprites = sprites,
        dur = dur,
        frame = 0
    }

    setmetatable(a, Animation)
    return a
end