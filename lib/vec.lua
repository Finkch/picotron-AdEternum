--[[pod_format="raw",created="2024-07-01 19:40:30",modified="2024-07-02 19:27:42",revision=63]]
-- Metatable; effectively a class

-- 2d vectors

Vec = {}
Vec.__index = Vec


-- constructor
function Vec:new(x, y)
    x = x or 0
    y = y or 0
    local v = {x = x, y = y}
    setmetatable(v, Vec)
    return v
end


-- algebra
function Vec:__add(other)
    return Vec:new(
        self.x + other.x,
        self.y + other.y
    )
end

function Vec:__sub(other)
    return Vec:new(
        self.x - other.x,
        self.y - other.y
    )
end

function Vec:__mul(other)
    return Vec:new(
        self.x * other,
        self.y * other
    )
end

function Vec:__div(other)
    return Vec:new(
        self.x / other,
        self.y / other
    )
end

function Vec:__unm()
    return self * -1
end


-- vector operations
function Vec:mag()
    return (self.x ^ 2 + self.y ^ 2) ^ 0.5
end

function Vec:dir()
    return self / self:mag()
end


-- vector-vector operations
-- note: we overload existing operators to do this
function Vec:__mod(other) -- dot product!
    return self.x * other.x + self.y * other.y
end

function Vec:__pow(other) -- cross product! points towards z
    return self.x * other.y - self.y * other.x
end


-- comparison operators
function Vec:__eq(other)
    return self.x == other.x and self.y == other.y
end


-- tostring
function Vec:__tostring()
    return "(" .. self.x .. ", " .. self.y .. ")"
end