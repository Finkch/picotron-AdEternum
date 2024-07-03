

-- a simple queue-like class

Q = {}
Q.__index = Q

function Q:new(max)
    max = max or 64
    local q = {
        data = {},
        max = max
    }

    setmetatable(q, Q)
    return q
end

function Q:add(datum)
    if (self:full()) return -- don't add if full

    self[#self + 1] = datum
end


function Q:clear()
    self.data = {}
end

function Q:print(x, y) -- also clears self!
    x = x or 0
    y = y or 0
    print(tostr(self), x, y)
    self:clear()
end

-- metamethods
function Q:__tostring()
    local str = ""
    for i = 1, #self do
        str ..= tostr(self[i])
        if (i != #self) str ..= "\n"
    end

    return str
end

function Q:__index(key)
    -- looks in data
    if (type(key) == "number") return self.data[key]

    -- makes sure not to override metatable of Q
    return Q[key]
end


-- size
function Q:__len()
    return #self.data
end

function Q:empty()
    return #self == 0
end

function Q:full()
    return #self == self.max
end