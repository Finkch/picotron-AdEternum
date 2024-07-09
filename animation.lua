--[[pod_format="raw",created="2024-07-08 23:52:16",modified="2024-07-08 23:56:35",revision=10]]
--[[
    handles animations

]]

include("finkchlib/tstr.lua")

Animation = {}
Animation.__index = Animation
Animation.__type = "animation"

function Animation:new(name, sprites, dur)
    local a = {
        name = name,
        sprites = sprites,
        dur = dur,
        frame = 0
    }

    setmetatable(a, Animation)
    return a
end


-- other
function Animation:get() -- gets current sprite
    return self.sprites[self.frame // self.dur + 1]
end


-- metamethods
function Animation:__call() -- calling animation increments frame and returns sprite
    
    -- gets current sprite
    local sprite = self:get()

    -- increments frame count, reseting if necessary
    self.frame += 1
    if (self.frame > #self.sprites * self.dur) self.frame = 0

    return sprite
end

function Animation:__tostring()

    -- gets a list of sprite orders
    local sprs = ""
    for i = 1, #self.sprites do
        sprs ..= tostr(self.sprites[i].sprite) .. " "

        if (i != #self.sprites) sprs ..= "-> "
    end

    -- creates table that will be conterted to a string
    local tbl = {}
    tbl[self.name] = {
        self.frame .. " / " .. self.dur * #self.sprites,
        sprs,
        self.dur
    }

    return tstr(tbl)
end