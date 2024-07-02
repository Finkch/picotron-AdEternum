--[[pod_format="raw",created="2024-07-01 19:40:30",modified="2024-07-02 19:27:42",revision=63]]
-- Metatable; effectively a class
local mt = {}

-- Makes a 2d vector
function vec(x, y)
    local v = {
        x = x,
        y = y
    }
    setmetatable(v, mt)
    return v
end

-- Addition and subtraction
function mt.__add(a, b)
    return vec(
        a.x + b.x,
        a.y + b.y
    )
end

function mt.__sub(a, b)
    return vec(
        a.x - b.x,
        a.y - b.y
    )
end


-- Equality
function mt.__eq(a, b)
    return a.x == b.x and a.y == b.y
end


-- To string
function mt.__tostring(a)
    return "(" .. a.x .. ", " .. a.y .. ")"
end