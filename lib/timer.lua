--[[
    tracks differences in real-world time

]]

include("finkchlib/tstr.lua")

Timer = {}
Timer.__index = Timer
Timer.__type = "timer"

function Timer:new(max_length)
    local t = {
        q = {},
        best = nil,
        worst = nil,
        average = nil,
        max = max_length
    }

    setmetatable(t, Timer)
    return t
end

-- misc
function Timer:diff(i) -- gets the difference between the two most recent items
    i = i or 1 -- defaults to first item
    if (#self < i + 1) return

    return self.q[i] - self.q[i + 1]
end

function Timer:update() -- updates best, worst, and average values
    if (#self < 2) return

    local diff = self:diff()

    -- best and worst
    if (not self.best or diff < self.best) best = diff
    if (not self.worst or diff > self.worst) worst = diffs

    -- gets average
    local average = 0
    for i = 1, #self - 1 do
        average += self:diff(i)
    end
    self.average = average / #self
end

-- metamethods
function Timer:__call() -- calling timer pushes time to the queue
    if (#self >= self.max) deli(self.q, #self)
    add(self.q, t(), 1)
    self:update()
end

function Timer:__len()
    return #self.q
end

function Timer:__tostring()
    local out = {
        q = self.q[1],
        best = self.best,
        worst = self.worst,
        average = self.average
    }

    return tstr(out)
end