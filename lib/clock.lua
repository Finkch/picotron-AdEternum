--[[pod_format="raw",created="2024-07-06 20:23:33",modified="2024-07-06 21:39:37",revision=210]]
--[[
	keeps track of time
	
]]

Clock = {}
Clock.__index = Clock

-- constructor
function Clock:new(f)
	f = f or 0
	local c = {f = f}
	setmetatable(c, Clock)
	return c
end

-- metamethods
function Clock:__call(f) -- calling a clock updates its counter
	f = f or 1
	self.f += f
	return self
end

function Clock:__mod(n)
	return self.f % n
end

function Clock:__tostring()
	local s = self.f // 60
	local m = s // 60
	local h = m // 60
	
	return string.format("%02dh %02dm %02ds %02df", h, m % 60, s % 60, self.f % 60)
end