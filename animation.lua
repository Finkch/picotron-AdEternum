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


-- other
function Animation:get() -- gets current sprite
    return self.sprites[self.frames // self.dur + 1]


-- metamethods
function Animation:__call() -- calling animation increments frame and returns sprite
    
    -- gets current sprite
    local sprite = self:get()

    -- increments frame count, reseting if necessary
    self.frame += 1
    if (self.frame > #self.sprites * self.dur) self.frame = 0

    return sprite
end