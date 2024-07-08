--[[
    tracks differences in real-world time

]]

include("finkchlib/tstr.lua")

Timer = {}
Timer.__index = Timer
Timer.__type = "timer"

function Timer:new(max_length)
    local t = {
        s = {}, -- start times
        e = {}, -- end times
        d = {}, -- differences
        best = nil,
        worst = nil,
        average = nil,
        max = max_length
    }

    setmetatable(t, Timer)
    return t
end

-- timing functions
function Timer:start()
    if (#self.s >= self.max) deli(self.s, self.max)
    add(self.s, t(), 1)
end

function Timer:end()
    if (#self.e >= self.max) deli(self.q, self.max)
    add(self.e, t(), 1)
    self:diff()
    self:update()
end

function Timer:diff() -- gets the difference between the two most recent items
    if (#self.d >= self.max) deli(self.d, self.max)
    add(self.d, self.e[1] - self.s[1])
end

-- misc
function Timer:update() -- updates best, worst, and average values
    local diff = self.d[1]

    -- best and worst
    if (not self.best or diff < self.best) best = diff
    if (not self.worst or diff > self.worst) worst = diffs

    -- gets average
    local average = 0
    for i = 1, #self do
        average += self.diff[i]
    end
    self.average = average / #self
end

-- metamethods
function Timer:__len()
    return #self.d
end

function Timer:__tostring()
    local out = {
        "diff" = self.d[1]
        "start" = self.s[1],
        "end" = self.e[1],
        "best" = self.best,
        "worst" = self.worst,
        "average" = self.average
    }

    return tstr(out)
end