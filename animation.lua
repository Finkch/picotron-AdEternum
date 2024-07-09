--[[pod_format="raw",created="2024-07-08 23:52:16",modified="2024-07-08 23:56:35",revision=10]]
--[[
    handles animations

]]

include("finkchlib/tstr.lua")

Animation = {}
Animation.__index = Animation
Animation.__type = "animation"

function Animation:new(name, sprites, durs)
    
    -- finds the total duration of the animation
    local total_dur = 0
    for dur in all(durs) do
        total_dur += dur
    end

    if (#durs == 1) total_dur *= #sprites

    local a = {
        name = name,
        sprites = sprites,
        durs = durs,
        total_dur = total_dur,
        frame = 0
    }

    setmetatable(a, Animation)
    return a
end


-- other
function Animation:get() -- gets current sprite

    if (#self.durs == 1) return self.sprites[self.frame // self.durs[1] + 1]

    local f = self.frame
    for i = 1, #self.durs do
        f -= self.durs[i]
        if (f <= 0) return self.sprites[i]
    end 
end


-- metamethods
function Animation:__call() -- calling animation increments frame and returns sprite
    
    -- gets current sprite
    local sprite = self:get()

    -- increments frame count, reseting if necessary
    self.frame += 1
    if (self.frame >= self.total_dur) self.frame = 0

    return sprite
end

function Animation:__tostring()

    -- gets a list of sprite orders
    local sprs = ""
    for i = 1, #self.sprites do
        sprs ..= tostr(self.sprites[i].sprite) .. " "

        if (i != #self.sprites) sprs ..= "-> "
    end

    -- gets stringified durs
    local durs = ""
    for i = 1, #self.durs do
        durs ..= tostr(self.durs[i]) .. " "

        if (i != #self.durs) durs ..= "-> "
    end

    -- creates table that will be conterted to a string
    local tbl = {}
    tbl[self.name] = {
        self:get().sprite,
        self.frame .. " / " .. self.total_dur,
        sprs,
        durs
    }

    return tstr(tbl)
end